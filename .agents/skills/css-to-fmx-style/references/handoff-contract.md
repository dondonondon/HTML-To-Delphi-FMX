# Handoff between the two skills

This is an instruction-level contract, not an SDK, background job, or a fictional
Codex dependency API. Both stages can be executed sequentially by the same agent.
Use Markdown tables; do not create a transport/schema framework.

## Input from html-to-fmx

Receive the CSS source paths and source context; target Delphi version/platforms;
style file path and naming convention; existing style resources; used selectors with
role, FMX class and state; layout-relevant declarations; and planned consumer units.
Keep selector dependencies such as variables, ancestor selectors and states.

A typical component-role row:

| Source role | FMX consumer | Requested meaning | Proposed consumer |
|---|---|---|---|
| `.btn-primary` | TCornerButton | primary action | FrameCustomers.AddButton |
| `.search-input` | TEdit | search field | FrameCustomers.SearchEdit |
| `.customer-card` | TPanel | reusable card surface | FrameCustomerCard.BackgroundPanel |
| `.single-offer` | TRectangle | one-off card surface; design-time properties | FrameCustomers.OfferBackground |

## Output to html-to-fmx

Update `FMX_STYLE_MAPPING.md` with:

- Style file path, target/platform assumptions and resource `StyleName` values.
- Known effective runtime source/load order, including compiled resource inputs and
  embedded designer synchronization; mark unknown host integration explicitly.
- Exact compatible consumer types and the `StyleLookup` to assign.
- Consumer reuse evidence: distinct instances or a card frame's repeated list/factory
  binding. A single `Unit.Control` path does not establish single-use by itself.
- For property-only mappings, the design-time control/property values and `N/A`
  StyleLookup. Multiple CSS selectors or consumers may point to one shared FMX
  style; the mapping retains their individual source provenance.
- Any required instance properties, e.g. button radius or text settings.
- For icon buttons, the image-list source, `Images`/`ImageIndex` requirements,
  shared `StyleLookup`, `glyphstyle` placement and icon/text spacing at the
  smallest supported width.
- For local `TLabel` or button typography, the font/text properties and exact
  `StyledSettings` flags to remove; keep flags for values owned by a shared style.
- Geometry/responsive/interaction declarations not representable in `.style`.
- States, approximations, unresolved assets/contracts, and observed validation.

Use `mode = style`, `design-time-property`, `layout`, `behavior`, or `unsupported`
in the mapping table. Never fill the StyleLookup column for a primitive that does not
support it. Write `N/A` and specify the destination instead.

## Merge ownership

The CSS skill owns style definitions and technical conversion notes. The HTML skill
owns page layout, wiring and the final consumer-path column. They share one mapping
file. Execute updates in sequence; do not have parallel agents overwrite this file
or the shared `.style`. Reuse the latest mapping before subsequent page conversion.

Standalone use fills intended consumer roles but marks actual unit/control paths
`not integrated`. Missing exact consumers must not block CSS-only resource generation.
