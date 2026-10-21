import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";
import { spawnSync } from "node:child_process";
import { existsSync } from "node:fs";
import { isAbsolute, relative, resolve } from "node:path";

const GUARDED_TOOLS: Record<string, true> = { edit: true, write: true, ast_edit: true };
const PYTHON_SUFFIX = ".py";
const SHELL_SUFFIXES = [".sh", ".bash"];
const RUFF_CONFIG_PATH = "assets/ruff.toml";
const RUFF_FORMAT = "concise";
const SHELLCHECK_FORMAT = "gcc";
const MAX_REPORT_CHARACTERS = 1500;
const FINDINGS_EXIT_CODE = 1;
// Directories whose files the project exempts from the style rules.
const SKIPPED_PREFIXES = ["assets/tests/", ".scratch/", ".git/"];

interface Findings {
  linter: string;
  path: string;
  report: string;
}

// Collect every path-like target from a tool call's input.
function targetPaths(input: Record<string, unknown>): string[] {
  const paths: string[] = [];
  if (typeof input.path === "string") paths.push(input.path);
  if (Array.isArray(input.paths)) {
    for (const p of input.paths) if (typeof p === "string") paths.push(p);
  }
  // `edit` embeds targets in its text body as "[path#TAG]" header lines.
  if (typeof input.input === "string") {
    for (const line of input.input.split("\n")) {
      const m = /^\s*\[([^\]#]+)(#[0-9A-Fa-f]+)?\]\s*$/.exec(line);
      if (m) paths.push(m[1]);
    }
  }
  return paths;
}

// Return the linter output when it reports findings, and an empty string otherwise.
// A missing binary, a timeout, or a linter error reports nothing: the gate never adds noise.
function runLinter(argv: string[], cwd: string): string {
  const result = spawnSync(argv[0], argv.slice(1), { cwd, encoding: "utf8", timeout: 30000 });
  if (result.error) return "";
  if (result.status !== FINDINGS_EXIT_CODE) return "";
  const output = `${result.stdout ?? ""}${result.stderr ?? ""}`.trim();
  return output;
}

function findingsFor(relativePath: string, cwd: string): Findings | undefined {
  if (relativePath.endsWith(PYTHON_SUFFIX)) {
    return {
      linter: "ruff",
      path: relativePath,
      report: runLinter(
        ["ruff", "check", "--config", RUFF_CONFIG_PATH, "--output-format", RUFF_FORMAT, relativePath],
        cwd,
      ),
    };
  }
  if (SHELL_SUFFIXES.some((suffix) => relativePath.endsWith(suffix))) {
    return {
      linter: "shellcheck",
      path: relativePath,
      report: runLinter(["shellcheck", "-x", "-f", SHELLCHECK_FORMAT, relativePath], cwd),
    };
  }
  return undefined;
}

function findingsForFile(cwd: string, target: string): Findings | undefined {
  const absolutePath = isAbsolute(target) ? target : resolve(cwd, target);
  if (!existsSync(absolutePath)) return undefined;
  const relativePath = relative(cwd, absolutePath).replaceAll("\\", "/");
  if (relativePath.startsWith("..")) return undefined;
  if (SKIPPED_PREFIXES.some((prefix) => relativePath.startsWith(prefix))) return undefined;

  const findings = findingsFor(relativePath, cwd);
  if (!findings || findings.report === "") return undefined;
  return findings;
}

function reportText(findings: Findings): string {
  const truncated =
    findings.report.length > MAX_REPORT_CHARACTERS
      ? `${findings.report.slice(0, MAX_REPORT_CHARACTERS)}\n[lint output truncated]`
      : findings.report;
  return `Lint findings from ${findings.linter} for ${findings.path}. Fix them before the next edit:\n${truncated}`;
}

export default function lintEditedFile(pi: ExtensionAPI): void {
  pi.on("tool_result", async (event, ctx) => {
    if (event.isError || !GUARDED_TOOLS[event.toolName]) return;

    const reports: string[] = [];
    for (const target of targetPaths((event.input ?? {}) as Record<string, unknown>)) {
      const findings = findingsForFile(ctx.cwd, target);
      if (findings) reports.push(reportText(findings));
    }
    if (reports.length === 0) return;
    return { additionalContext: reports.join("\n\n") };
  });
}
