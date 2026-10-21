# `perf` commit rules

Performance improvement with no behavior change. When the behavior
changes too, use `feat` or `fix` instead.

## Body

The body is mandatory; never skip it. It has two sections with
fixed headings, in this order, separated by a blank line:

```text
Design:
<diagram and explanation of the improved flow and where the gain
comes from>

Implementation:
<what was changed, target 2 lines; name the measured or expected
gain>
```

## Diagram

The shared diagram rules in SKILL.md apply. Draw the diagram under
`Design:`: the new flow, as a block diagram or a UML diagram. An
improvement without a shown flow does not explain where the gain
comes from. Skip the diagram only when the change is purely
mechanical (a flag, a dependency bump) with no flow to show.
