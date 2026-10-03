---
name: review-fmx-ui
description: Review existing native Delphi FireMonkey UI, including html-to-fmx and create-fmx-ui results. Refine proven defects or enhance appearance and UX when requested, while preserving the established hierarchy and behavior. Use for existing .fmx/.pas screens, not new screen creation, HTML conversion, VCL, or web UI.
---

# Review and refine Delphi FMX UI

Review the actual existing screen and its source evidence. Improve it in place only when
the user requests changes. Reuse the existing conversion/creation references rather
than rerunning their implementation entrypoints or regenerating the screen.

## Select the mode from the request

| Mode | User intent | Work allowed |
|---|---|---|
| `review` | Review, inspect, compare, or identify problems | Inspect and run available checks; report findings without editing application code, assets, mappings, or design documents |
| `refine` | Review and fix, refine, repair, or correct conversion differences | Review, then fix evidenced defects in the requested screen and its permitted style/asset integration |
| `enhance` | Explicitly improve appearance or UX beyond correcting defects | Review, then implement the requested improvements within the existing structure and project design constraints |

A review request alone selects `review`. A request to fix is authorization for `refine`;
do not stop at a findings-only report or ask again for routine permitted edits.
Enhancement must be requested; finding a defect does not authorize a redesign. Resolve
minor choices within the authorized scope and ask only for missing information that
blocks correct work. A later user instruction can change the mode.

## Preserve the established structure

Before editing, record the existing component names/types and parent-child tree from
the `.fmx`, together with event bindings and reusable frame/list boundaries. Keep this
baseline in memory or a disposable check artifact; a new application document is not
required just to review a screen.

- Preserve page/section/card/cell ownership, fixed grids and controls, reusable card
  units, and `TListBox -> TListBoxItem -> TFrame` boundaries.
- Do not reparent, add/delete wrappers or sections, flatten the tree, replace component
  classes, rename components/units, or substitute a different list/container to fix
  appearance. Change structure only when the user explicitly authorizes that specific
  structural change; otherwise report the conflict and complete independent fixes.
- Keep fixed UI serialized in `.fmx`. Do not introduce static `BuildUI` factories,
  presenter wrappers, new base classes, or a UI framework.
- Keep card visuals input-transparent and whole-row actions centrally routed according
  to the existing contract. Preserve the item-owned sibling action pattern; its narrow
  runtime exception does not authorize activating card children or changing hierarchy.
- Preserve data binding, record identity, event contracts, navigation, aliases, services,
  and business behavior. Correct a broken UI event only against its evidenced intended
  behavior; do not invent an action, endpoint, or backend capability.

Geometry, `Align`/`Anchors`, margins/padding, wrapping/trimming, typography, colors,
supported instance properties, compatible style resources, and existing asset bindings
can be corrected within that tree. Verify the immediate parent bounds, hit areas and
downstream effects. Do not hide required content/actions to disguise a layout problem.

These preservation rules take precedence over repair suggestions in shared references
that remove wrappers, change component types, or rebuild ownership. Treat such
suggestions as diagnostic findings unless the user authorized the structural change.

## Establish the comparison target

Inspect the named `.fmx`/`.pas`, relevant project instructions, target Delphi/platforms,
existing UI/style maps, `DESIGN.md` or equivalent, assets and actual style loader. Preserve
unrelated dirty work. Locate the requested frame if only a screen name is supplied;
do not review every screen in the application by default.

For converted UI, use the named HTML/CSS/assets and its reference render at a stated
logical viewport/scale. For created UI, use the brief, screenshot application-content
crop and recorded scale assumptions. Inspect supplied images themselves; separate
observed evidence from inference. Existing application captures show the implementation,
not the intended design, unless the user identifies them as the design reference.

If a source or image is unavailable, continue source/resource checks independent of it
and identify the missing visual evidence. Do not claim fidelity from a filename alone.
If no source was supplied, review against the maintained project guide and observable
defects; label that comparison basis. `refine` preserves the established visual target;
`enhance` records deliberate deviations requested by the user as local changes.

## Consume shared references selectively

- Always read [verification](../html-to-fmx/references/verification.md); use its checks
  as evidence requirements, subject to the mode and structure-preservation rules above.
- Read [layout and design-time](../html-to-fmx/references/layout-and-design-time.md)
  for geometry, responsiveness and ownership diagnostics.
- Read [dynamic items](../html-to-fmx/references/dynamic-items.md) for lists, row actions,
  item geometry, ownership and asynchronous item lifetime issues.
- Read [style integration](../html-to-fmx/references/style-integration.md) when reviewing
  style resolution/load order. For interactive resource parts and text overrides, read
  [style contracts](../css-to-fmx-style/references/style-format-and-contracts.md).
  For shared-resource reuse, use the consumer definition in
  [CSS conversion rules](../css-to-fmx-style/references/conversion-rules.md).
- For style changes originating from `create-fmx-ui`, or when authoring provenance is
  unresolved, read [main-form style ownership](../create-fmx-ui/references/appearance-without-css.md).
  Keep its embedded default and explicit external-write boundary. For an established
  HTML conversion, follow its recorded style source, loader and authorized file scope.
  An existing external file alone does not identify the workflow or authorize a write.

These are same-agent reference dependencies, not instructions to run conversion,
creation, or a full remapping. Resolve paths relative to this skill directory. If a
sibling is absent, locate the installed skill by name; if a required reference remains
unavailable, report it and complete independent checks. Keep the package directories
together when copying this skill to another project.

## Review, then make authorized corrections

Inspect actual control/resource bounds and consumer contracts, not only property names
or a screenshot. Prioritize dead actions, clipped/unreachable content, overlaps, wrong
icons/text/styles and broken resize/scroll/input behavior. Distinguish a defect supported
by evidence from an optional aesthetic preference. For each finding identify the
affected file/control, trigger or viewport, consequence, evidence, and smallest fix.

In `review`, report those findings without applying them. Use permitted checks with
disposable or normal build outputs; do not persist designer resize experiments or add
application preview controls, dummy data paths, or new documentation automatically.

In `refine` or `enhance`, edit the existing resource and matching Pascal only as needed
for the selected changes. Reuse existing style/assets first. Trace effective runtime
style loading before editing; preserve existing consumers and verify additions after
startup and existing theme reloads. Keep shared-resource changes scoped; similar names
or colors do not establish compatibility. Respect the source workflow's style-write
policy and use verified target tooling for binary/embedded resources.

Reuse real records for populated-list checks when available. Fixtures are conditional
on a requested demo/designer preview or an isolated validation harness; do not add a
production preview mode or substitute dummy records for actual loading/empty/error
states. Follow shared rules for changed icons, font sizes and `StyledSettings` without
normalizing unrelated existing controls.

Compare the post-edit component tree and event/data/navigation contracts with the
baseline. Recheck the affected render, reference/narrower/wider supported widths, row
actions and relevant consumers with available tools. Fix material regressions within
scope; do not broaden into unrelated screens or demand unavailable device checks.
In edit modes, update existing page/style mappings only for actual changed decisions
and verified resource status. Extend the project guide only for authorized reusable
design changes, keeping page-specific enhancement differences local.

## Report the result

Lead with findings for `review`, or concrete changes and remaining issues for edit
modes. Include file/control locations, evidence, applied fixes versus unresolved
findings, and any intentional enhancement differences. If no actionable defect is
found, say so with the limits of the inspection rather than inventing improvements.

Report source/static, build, designer/resource load, source-versus-native visual
comparison, runtime/input and device checks separately as `passed`, `failed`, or
`not run`, with viewport/platform/capture or command evidence as appropriate. Static
review and compilation do not prove designer loading, style survival or visual parity.
State whether hierarchy was preserved and any explicitly authorized structural exception.
Keep the report in the response unless the user requests a saved report or an existing
project workflow requires one.
