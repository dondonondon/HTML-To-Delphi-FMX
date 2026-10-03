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
| Single-use card surface | Design-time `TRectangle` properties in `.fmx` | No style resource for one consumer |
| Shared card surface | `TPanel.StyleLookup` -> rectangle resource | Multiple identified consumers share one visual contract; foreground controls stay siblings |
| Background/border/radius | Shape in the relevant style | Never invent Fill/Stroke on a styled control |
| Simple label typography | Design-time `TLabel` text properties in `.fmx` | Hand off selective `StyledSettings`; no size/color-only label style |
| Shared text behavior beyond simple typography | Compatible text style resource | Verify actual consumers use its styled values |
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
For newly converted font settings, never output an FMX font size of exactly `12`.
If the resolved CSS size or mapped FMX value is `12`, emit `12.5` and record that
substitution in the mapping. Leave all other sizes and unrelated existing styles
unchanged. Check the effective font size when `StyledSettings` or inheritance applies.

## Stable updates

Prefer semantic style identities over one style per DOM node or CSS class. Multiple
selectors may resolve to one style, and one selector may need multiple component
styles. Deduplicate by resolved appearance AND compatible target control, not by color alone.
Do not name FMX resources by copying source CSS classes or token names automatically.
Keep the exact source selector/token to FMX style or design-time-property mapping in
`FMX_STYLE_MAPPING.md` instead.

Before creating a resource, identify its actual consumers. A one-off card surface
uses a design-time `TRectangle` with its fill, stroke, radius and effects set on the
instance. When the same card surface is used by multiple independent consumers,
use one `TPanel` style with a `TRectangle` inside its resource. Do not create a
StyleBook entry for each fill color, opacity, radius, or single card. A reusable
card `TFrame` can also own its surface once for repeated data items.

Count consumers by intended instantiated usage, not only distinct `Unit.Control`
declarations. One background declaration in a card frame instantiated per record
qualifies as repeated usage even when the current result contains zero or one item.
Record that frame's actual list/factory binding as evidence; do not invent future
consumers to justify a shared style. A frame used only once without a repeated binding
remains single-use. Preserve this distinction in the mapping and validation without
changing the component hierarchy.

For icon-only `TCornerButton` consumers, group by surface, pressed/focus/disabled
behavior, and glyph placement. Reuse one compatible style across buttons whose
only differences are action, icon, `Images`/`ImageIndex`, or instance bounds.
Center `glyphstyle` with a measured size for centered icons; use a client-aligned
glyph with intended margins only when the source calls for fill behavior. Create
separate center/client or surface variants only when their layouts or states
actually differ. Preserve target-required style parts and verify rendering.

Map font family, size, weight, color and ordinary alignment to `TLabel` instance
properties when they are the only differences. A typography token is not by itself
a reason for a new `stitch_text_*`-style resource. Create a shared text style only
when its actual consumers need one common style-owned contract, and do not also
override those same values on every consumer with `StyledSettings=[]`.

Keep output ordering and names stable. On rerun, update owned resources and mapping
rows instead of appending duplicates or changing names gratuitously.
