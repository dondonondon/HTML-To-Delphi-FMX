# FMX Style Mapping

## Context

- CSS source: <paths>
- Style file: <path>
- Target Delphi / platforms: <detected, or explicit assumption>
- Base style / contract reference: <path or source>
- Integration: <not integrated / host form and StyleBook>
- Runtime source / load order: <file/embedded/named resource + initialization/reload; or unknown>
- Embedded designer synchronization: <destination + refresh route; or not integrated>

## Component styles and handoff

| CSS selector / role | FMX class | Mode | StyleName / StyleLookup | Actual consumer / intended role | Instance properties / handoff | Status |
|---|---|---|---|---|---|---|
| <selector> | <class> | <style/layout/etc.> | <name or N/A> | <unit.control or not integrated> | <requirements> | <new/reused/blocked> |

Use `design-time-property` and `N/A` StyleLookup for a single-use `TRectangle`
surface or simple `TLabel` typography. Repeat one semantic StyleName across
rows when multiple selectors/consumers use the same resource; record each CSS
source separately. Include selective `StyledSettings` changes in the handoff.
For shared card surfaces, record distinct instance consumers or the reusable frame's
list/factory binding; do not count only distinct source paths.

## States

| Style | Normal | Hover | Pressed | Focus | Disabled | Notes |
|---|---|---|---|---|---|---|
| <style> | <mapping> | <mapping or N/A> | <mapping or N/A> | <mapping or N/A> | <mapping> | <differences> |

## Non-style declarations and limitations

Record layout rules, variable/cascade assumptions, platform differences, unsupported
CSS, font substitutions and unresolved contracts. Remove this placeholder after use.

## Validation

| Check | Result | Evidence / reason |
|---|---|---|
| Static inspection | not run | |
| Delphi style load | not run | |
| Consumer smoke test | not run | |
| Platform visual checks | not run | |
