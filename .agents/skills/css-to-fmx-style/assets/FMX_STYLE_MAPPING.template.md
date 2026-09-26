# FMX Style Mapping

## Context

- CSS source: <paths>
- Style file: <path>
- Target Delphi / platforms: <detected, or explicit assumption>
- Base style / contract reference: <path or source>
- Integration: <not integrated / host form and StyleBook>

## Component styles and handoff

| CSS selector / role | FMX class | Mode | StyleName / StyleLookup | Actual consumer / intended role | Instance properties / handoff | Status |
|---|---|---|---|---|---|---|
| <selector> | <class> | <style/layout/etc.> | <name or N/A> | <unit.control or not integrated> | <requirements> | <new/reused/blocked> |

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
