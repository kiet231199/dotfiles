import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";

const SKILL_URI = "skill://coding-style";
const GUARDED_EXTENSIONS = [".sh", ".bash", ".py"];
const GUARDED_TOOLS: Record<string, true> = { edit: true, write: true, ast_edit: true };

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

export default function enforceCodingStyle(pi: ExtensionAPI): void {
  // Per-session state: flips once the skill read succeeds.
  let skillRead = false;

  pi.on("tool_result", async (event) => {
    if (skillRead || event.isError) return;
    const input = (event.input ?? {}) as Record<string, unknown>;
    const readSkillUri = typeof input.path === "string" && input.path.startsWith(SKILL_URI);
    const managedSkill =
      event.toolName === "manage_skill" && JSON.stringify(input).includes("coding-style");
    if (readSkillUri || managedSkill) skillRead = true;
  });

  pi.on("tool_call", async (event) => {
    if (skillRead || !GUARDED_TOOLS[event.toolName]) return;
    const offenders = targetPaths((event.input ?? {}) as Record<string, unknown>).filter((p) =>
      GUARDED_EXTENSIONS.some((ext) => p.endsWith(ext)),
    );
    if (offenders.length === 0) return;
    return {
      block: true,
      reason:
        `Blocked by project policy: read ${SKILL_URI} before editing .sh/.bash/.py files ` +
        `(target: ${offenders.join(", ")}). Read the skill with the read tool, then retry this edit.`,
    };
  });
}
