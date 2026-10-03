# Design-time layout and shallow hierarchy

## What design-time means for a coding agent

Edit the actual `.fmx` resource with corresponding `.pas` declarations. The controls
must exist when the resource is loaded and remain editable in Delphi's designer.
Using a text editor rather than automating IDE mouse clicks is acceptable. A method
that creates static controls at startup is NOT equivalent.

Keep unit/class/root names, published fields, event names and resource directives
consistent. Preserve existing inherited/inline frame syntax and project form entries.
Do not hand-convert binary resources using lossy decoding. Use actual Delphi tooling
when a binary-to-text or resource conversion is necessary.

## Static structure versus dynamic instances

| UI region | Where structure is created | Runtime responsibility |
|---|---|---|
| Header, search, footer, navigation | Page `.fmx` | Text/state/events |
| Four fixed KPI cards with changing values | Page `.fmx` or design-time frame instances | Bind values only |
| Fixed KPI cards | Section `TLayout -> TGridPanelLayout -> TLayout` per card, or suitable fixed-column `TListBox` item layouts | Bind values only |
| Fixed grid of single-button actions | Section `TLayout -> TGridPanelLayout -> TCornerButton` per cell | Bind actions/icon state only |
| List container | Page `.fmx` | Populate/clear/select |
| Variable number of result cards | Widget `.fmx`, instantiated per item | Create item/frame; bind data |
| Fixed contents of every item widget | Widget `.fmx` | Bind data; do not recreate children |
| Responsive arrangement | Design-time starting layout | Adjust existing controls only as needed |

Do not infer dynamic data solely from repeated HTML. Repetition may represent fixed
navigation, a static dashboard, or example data. Use task/source data context and
record the assumption where cardinality is unknown.

## Decide what is a data list

Treat a region as a data list when its entries represent records of the same kind and
the number or order can change with data, search, filters, paging or time. A history,
inbox, catalog or search result can qualify even when the supplied HTML contains only
two hard-coded examples. Give each item a stable record identity and one card layout.

Keep a known set of distinct actions or fixed dashboard values in the page `.fmx`:
navigation menus, tabs, shortcuts and KPI blocks do not need a data-card frame solely
because their HTML markup repeats. If the source is ambiguous, inspect existing data
contracts and intended interactions, then state the classification in the UI mapping.
Fixed peer cards or actions still need a shared grid/list container. Each independent
KPI/card needs a cell layout to own its background and content. A fixed action cell
containing only one button can use `TCornerButton` directly in `TGridPanelLayout`.
For a design-time `TListBox`,
use `TListBoxItem -> TLayout` for these fixed cells; reserve the separate card `TFrame`
for variable records. Use `TGridPanelLayout` when its design-time cells and controls
better preserve independent button input and fixed geometry.
For a data list, use `TListBox -> TListBoxItem -> TFrame` and follow
[dynamic items](dynamic-items.md). A scrollbox may contain the list as part of a mixed
page; it does not replace the list itself.

Use these decisions as examples; classify by actual content and behavior rather than
the HTML tag, CSS class or visual use of a card border:

| Source region | Classification | FMX structure |
|---|---|---|
| Employee, product, attendance or request records | Data collection, including static sample rows in HTML | TListBox -> TListBoxItem -> reusable card TFrame |
| Product records arranged in a CSS grid | Data collection | The same list/card pattern; check supported list columns and layout |
| Product detail label/value rows supplied as a collection or with variable fields | Data collection | Section heading plus TListBox -> TListBoxItem -> one reusable detail-row TFrame per field |
| Known product fields with values that change | Fixed details | Design-time labels/values in the section; bind values only |
| Three known totals such as pending, approved and rejected | Fixed dashboard values | Design-time labels and surfaces; bind values only |
| Three known KPI cards in one row | Fixed dashboard group | Section `TLayout -> TGridPanelLayout` (3 columns) -> one `TLayout` per card; or fixed-column `TListBox -> TListBoxItem -> TLayout` |
| Four fixed quick actions in two rows | Fixed action group | Section `TLayout` with title and a 2-column, 2-row `TGridPanelLayout`; each cell directly contains one styled `TCornerButton` |
| Name, email, address and password fields | Fixed form | Design-time inputs in a layout or scrolling region |
| Summary plus a changing transaction history | Mixed page | Fixed summary controls plus a TListBox with transaction cards |

A data-driven menu or configurable set of metrics can be a collection when its
entries genuinely come from variable records. Conversely, a changing label value
alone does not make its enclosing section a collection. Record one short reason for
each repeated region's classification before choosing the implementation.

## Component mapping

| HTML intent | Primary FMX choice |
|---|---|
| Structural group | TLayout |
| Single-use card surface or decorative shape | Sibling TRectangle with design-time fill/stroke/radius/effects |
| Card surface shared by multiple consumers | Background TPanel + one reusable StyleLookup |
| Button / clickable icon action | TCornerButton with Images/ImageIndex and a style `TGlyph` part named `glyphstyle` |
| Text input | TEdit |
| Multiline input | TMemo |
| Text | TLabel |
| UI icon | TGlyph with Images pointing to TImageList and a valid ImageIndex |
| Photo, illustration or logo | TImage |
| Check / select | TCheckBox / TComboBox |
| Dynamic collection | TListBox |
| Dynamic item visual | Design-time TFrame inside TListBoxItem |
| Non-list scrolling | TVertScrollBox / TScrollBox, only with justification |

Reuse a suitable project `TImageList` for icon assets. A standalone icon uses a
design-time `TGlyph` with `Images`/`ImageIndex`. An icon belonging to a
`TCornerButton` uses the button's `Images`/`ImageIndex`; its custom style must
contain a working `TGlyph` named `glyphstyle`. This is a style-internal glyph,
not another application control over the button. Change the index at runtime
only when the icon varies with data or state. Keep standalone glyphs
input-transparent when another control owns the action. Map source icon
fonts/SVGs to compatible image-list assets; do not substitute text, emoji,
`TImage` or `TPath` for icons.
Give icon-only buttons the same StyleLookup when their surface, states and glyph
placement match. A centered source icon needs a centered `glyphstyle`, not the
left-glyph/text layout of a captioned button. Create a separate client-aligned
glyph variant only when its fill behavior is required. A `TRectangle` with a
`TGlyph` is a property-only alternative for a simple clickable icon when its
input, focus and action behavior are verified; prefer the reusable button style
when several icon actions share the same appearance.
Check image-list availability in the designer and on target platforms. If the
source asset cannot be supplied, record the missing icon rather than presenting a
text stand-in as a completed conversion.

## Page, section, card and cell ownership

Translate the purpose of each HTML region, not its DOM ancestry. The page content
region positions sections; a section groups related controls; an independent card
owns its surface and foreground controls; a fixed grid positions peer cells. A
`TVertScrollBox -> TLayout` pair may be necessary for scrolling and content height,
but the content layout must not absorb the contents of all cards as direct children.
Omit unused regions and wrappers that have no actual responsibility.

The following dashboard shape illustrates the ownership boundaries. Use actual
source sections and names for each conversion; it is not a universal page template:

```text
PageFrame: TFrame
  Background: TRectangle              // sibling behind content
  Header: TLayout                      // title and actions, if needed
    HeaderBackground: TRectangle
    Title: TLabel
    BackButton: TCornerButton          // Images/ImageIndex; style glyphstyle
  ContentScroll: TVertScrollBox        // when the page scrolls
    Content: TLayout
      Greeting: TLabel                  // belongs to page content, not a card
      SalesCard: TLayout                // independent card
        SalesBackground: TRectangle     // sibling of labels
        SalesValue: TLabel
      MetricsSection: TLayout
        MetricsGrid: TGridPanelLayout  // three fixed columns
          OrdersCell: TLayout           // card owner in first grid cell
            OrdersBackground: TRectangle // follows cell bounds
            OrdersTitle: TLabel         // anchored left/top; right gap for icon
            OrdersIcon: TGlyph          // anchored right/top
            OrdersValue: TLabel         // anchored within cell
          CustomersCell: TLayout        // own background + value
          StockCell: TLayout            // own background + value
      ActionsSection: TLayout
        ActionsTitle: TLabel
        ActionsGrid: TGridPanelLayout  // two columns, two rows
          NewSaleButton: TCornerButton  // fills cell; Images/ImageIndex + glyphstyle
          AddProductButton: TCornerButton
          CustomersButton: TCornerButton
          ReportsButton: TCornerButton
      RecentTitle: TLabel
      RecentData: TListBox             // variable records
        Item: TListBoxItem             // created per record
          TransactionCard: TFrame      // own .pas/.fmx; instantiated per item
  Footer: TLayout                      // bottom menu if present
    FooterBackground: TRectangle
    ConfirmButton: TCornerButton
```

For variable detail rows, keep the title and list in the same section. The list
owns items, and each item owns an instance of the same detail-row card class:

```text
GeneralInfoSection: TLayout
  GeneralInfoBackground: TRectangle
  GeneralInfoTitle: TLabel
  GeneralInfoList: TListBox
    Item: TListBoxItem                  // one per attribute
      DetailRowCard: TFrame             // same class for every row
      RowAction: TCornerButton          // optional item-owned sibling; Images/ImageIndex + glyphstyle

DetailRowCard: TFrame                   // separate .pas/.fmx
  FieldNameLabel: TLabel
  FieldValueLabel: TLabel
```

The item-owned action is present only when the source row has a separate action.
The card frame and all its descendants remain input-transparent. A stable fixed
field set keeps design-time rows even when their values change.

For a fixed peer group, define the intended row/column collection and cell
placement in the `.fmx`. A KPI/card cell keeps a `TLayout` owner whose background
and children fit that cell. A single-button action may be the grid control itself;
give it `Align=Client` and margins for the gap. Add an action-cell layout only when
it has more work than wrapping one button. A fixed-column design-time `TListBox`
is also valid when its item selection, focus and scrolling match the source; use
`TListBoxItem -> TLayout` and serialize its fixed items in `.fmx`. Do not use a
fixed group as a pretext to create a reusable data card or runtime item factory.
Serialize `Selectable=False` on those fixed items by default. Enable selection
only when the source has an actual persistent selected-item state.

A reusable data card normally needs only its root and direct children. Add a row
layout when its children must move or resize as one group:

```text
CardFrame: TFrame
  Background: TRectangle              // sibling, not parent
  Icon: TGlyph                         // Images/ImageIndex; HitTest=False
  Title: TLabel
  Detail: TLabel
  Status: TLabel
```

Avoid `TLayout -> TRectangle -> TLayout -> TCornerButton/TEdit` when the rectangle
only paints a background. Avoid chains of single-child `TLayout` controls used only
to imitate HTML wrappers. Place labels, edits and buttons directly in their nearest
functional owner: page region, section, card or cell. Prefer `Anchors` with
intentional initial bounds for internal placement; use `Align`, `Margins` and
`Padding` where they match the intended layout. Do not place multiple distinct
card surfaces and their labels/buttons directly under one content layout. Structural depth has no
numeric target; each level must have a visible or behavioral responsibility.

A full-background `TRectangle` sibling normally uses `Align=Contents`,
`HitTest=False`, and sits
behind the content in object order. `Align=Client` can participate in normal space
allocation; do not assume it is always a harmless overlay. Check z-order, padding,
bounds, clipping and input after loading. Do not fix bad resource order with repeated
runtime `SendToBack` calls unless there is an actual dynamic reason.

Keep style-resource internal trees separate from application-layout depth checks.

## Responsiveness

Start with `Anchors` for controls inside a frame, section, card or cell. Use
`Align` when the parent must allocate space to a child, especially a simple
layout or the page shell: header `Align=Top`, footer `Align=Bottom`, content
`Align=Client`. A background `TRectangle` uses `Align=Contents` behind its
foreground siblings. Use `Margins` and `Padding` for intended gaps. Use a small
resize procedure only where required to adjust EXISTING controls or list
columns/item geometry. No new static
controls on each resize. Translate layout behavior rather than copying every CSS
position or media query. Preserve reading order and visible hit areas.

Specify the resize behavior for each container boundary, from the form/frame root
through the section/card/cell owner to its children. A child follows its immediate
parent, so a full-width child inside a fixed-width owner still cannot follow the
frame. For an internally positioned child, set `Align=None`, its initial
design-time bounds, and the edges in `Anchors` that must retain their distance.
Use `Align` when the child should participate in the parent's space allocation.
When that allocation would shrink other aligned siblings, keep the independently
positioned child anchored instead.
For example, a bottom control alongside `Align=Left` and `Align=Client` siblings
can use `Anchors=[akLeft,akRight,akBottom]` to keep its bottom inset and stretch
its width without taking height from those siblings. Set its initial bounds and
intended edge gaps in the designer. This is an overlay within that parent: check
z-order, overlap, clipping and hit areas; parent it to the client region instead
if it should not cover the left region. Anchor behavior depends on the immediate
parent resizing. Neither the presence of `Anchors` nor a runtime resize handler
proves the intended designer behavior; resize the actual parent/frame in the
designer and observe the result.

For every grid cell, inspect the bounds of its actual descendants at the smallest
supported, reference and wider widths. Make a card background follow the cell
(`Align=Contents` or all four anchors with intended margins). Reserve a trailing
icon's width and gap: anchor it to the top/right; give the title only the remaining
width and let value/note labels expand or trim within the cell. Set explicit
trimming/wrapping and minimum viable widths for long text. `Anchors` preserve edge
distances but cannot prevent overlap when the available width is smaller than the
content. Reflow or reduce columns where the source/target behavior permits, or
record a supported minimum width. Resizing only `TGridPanelLayout.Width` does not
make fixed-position child controls responsive.

For card grids, first inspect the target TListBox's supported columns/layout behavior.
Do not assume `TListBox` implies one column. Do not substitute a scrollbox solely
because the HTML used CSS grid. Record any limitation and preserve the required
list/card pattern; report a genuine unresolved conflict with the source behavior.

Check resizing at the source reference size and at smaller/larger supported widths.
Scroll, focus and soft-keyboard behavior need platform testing, not just screenshots.
