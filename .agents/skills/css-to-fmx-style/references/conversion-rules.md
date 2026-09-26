# CSS conversion rules

## Resolve meaning before generating styles

Identify tokens, component roles, variants, and the winning declarations where context
is available. Account for cascade order, specificity, inheritance, CSS custom-property
scope, fallbacks, `!important`, and relevant state selectors. Do not use a regex class
name list as proof that a rule is unused. Keep dependent `:root` tokens, descendant
selectors, attribute selectors, state selectors, imports, and media-query context.

For CSS frameworks, prefer the already-built CSS. Do not assume `.bg-primary`,
`text-sm`, or utility names have a particular value without theme/config evidence.
For Sass/Less/Tailwind source, use existing trusted project tooling when necessary;
do not treat unexpanded directives as final CSS.

With CSS alone, `.primary` is not enough to prove the consumer is a button. Use an
explicit role map, a strongly semantic selector, or label the proposed role as assumed.
Keep unresolved portions in the mapping rather than inventing a result.

## Placement table

| CSS concern | FMX destination | Required care |
|---|---|---|
| Button appearance | `TCornerButton` style parts | Preserve text, focus, pressed and disabled behavior |
| Input appearance | `TEdit` style parts | Preserve editable content, caret, selection and focus |
| Reusable card surface | `TPanel.StyleLookup` -> rectangle resource | Application controls stay siblings of the background |
| Background/border/radius | Shape in the relevant style | Never invent Fill/Stroke on a styled control |
| Text color/font/alignment | Appropriate text resource / control text settings | Account for `StyledSettings` and target font availability |
| External width/height/margin | Instance `.fmx` properties | Not automatically a shared style |
| Container padding/gap | Layout mapping to `.fmx` | Distinguish resource padding from component layout padding |
| Flex/grid/position | UI conversion handoff | Not a `.style` layout engine |
| Media/container queries | Responsive handoff | Record tested viewport assumptions |
| Hover/active/focus/disabled | Supported style states/triggers | Hover is not a substitute for keyboard focus |
| Scroll behavior | UI container choice | HTML overflow does not select `TScrollBox` by itself |
| Gradients/shadows | Supported resource fill/effect | Record approximation and performance risk |
| Filters/backdrop-filter | Usually unsupported or approximated | Never silently drop them |
| Pseudo-element content/icons | UI or style primitive with verified assets | No fabricated icon-font glyph mapping |

## Values and units

Use logical UI measurements, not physical screenshot pixels blindly. CSS px to FMX
logical units can be a starting assumption at a selected scale, not a universal
identity. Resolve rem/em against source settings; percentages and viewport units
usually remain layout responsibilities. Round only where necessary.

Convert CSS `#RRGGBB` to FMX ARGB with explicit alpha, for example
`#2563EB` -> `$FF2563EB`. CSS eight-digit hex is `#RRGGBBAA`, not FMX's
`$AARRGGBB`. For RGBA, round/clamp alpha deliberately. Never swap these layouts.

Do not promise exact font-weight 600 through a simple bold flag. Verify available
font family/weight behavior, record substitutions, and keep font licensing intact.
No font files are bundled with this skill.

## Stable updates

Prefer semantic style identities over one style per DOM node or CSS class. Multiple
selectors may resolve to one style, and one selector may need multiple component
styles. Deduplicate by resolved appearance AND compatible target control, not by color alone.

Keep output ordering and names stable. On rerun, update owned resources and mapping
rows instead of appending duplicates or changing names gratuitously.
