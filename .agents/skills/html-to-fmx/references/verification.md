# UI verification checklist

## Static and resource consistency

Check every `.fmx` root class against `.pas`; `{$R *.fmx}` presence; declared designer
components; event handler names/signatures; source unit references; correct FMX uses;
published properties for the target release; existing inherited/inline syntax; and
project registration where required. No orphan handler or nonexistent property.

Inspect constructors/FormCreate for accidental static control factories. Dynamic
labels do not excuse runtime creation of a fixed page structure. Inspect each widget
resource for recursive HitTest=False and verify whole-item identity/click dispatch.
Backgrounds must not unnecessarily parent foreground controls or block input.

Compare the repeated regions against the mapping: variable data records must use
`TListBox -> TListBoxItem -> card TFrame`, while fixed menus, shortcuts, tabs and KPI
blocks stay in the page resource. Check that every data card has its own `.fmx` with
fixed descendants and that representative dummy records can be previewed through
the same card binding. Verify demo items are cleared or replaced before real data loads.
Check `Selectable=False` on runtime dummy/real items and on serialized fixed
`TListBoxItem`s. Any `Selectable=True` needs a mapped persistent-selection
requirement. Verify `OnItemClick` still reports the correct row when
`Selectable=False`, including after scrolling; nonselectable must not mean
`Enabled=False` or `HitTest=False` on the item.

Confirm repeated records reuse a card class and that reopening the preview does not
duplicate items. Empty/error responses from a real data source must not activate
dummy records. For mixed pages, verify fixed regions remain independent of list items.
For separate cards, inspect two adjacent dummy items and two adjacent real items:
the same positive gap must remain visible after binding, scrolling and reload.
Check the actual painted card bounds, not only `Item.Height`; an `Align=Client`
frame without an inset can consume the supposed gap. Check first/last rows,
long or wrapped content, narrow/wide widths, unwanted selection state, click
area and viewport height so preview rows are visible or reachable by scrolling.
For connected rows, verify the mapped divider appears instead of an unintended
zero-gap stack of individual card surfaces.
For label/value detail rows, verify the mapping distinguishes rows supplied as a
collection or a variable field set/order/count from fixed fields with changing
values. If the rows form a collection, confirm the section title and list are
design-time, each item uses the same reusable detail-row
frame class for the same visual shape, and field names/values are bound as data.
Reject one frame unit per field name or hard-coded example rows presented as the
only possible data. For independent row actions, confirm the button is item-owned
outside the input-transparent frame, uses the row's stable identity, and does not
also dispatch the list's whole-item action. Verify Copy/Scan or similar source
actions remain functional; document any unresolved conflict.
Compare the map's proposed parent-child tree with the actual `.fmx` object tree,
not just names or screenshots. For each source region, inspect these ownership
boundaries:

| Source role | Required actual parentage |
|---|---|
| Header/footer | Region `TLayout` owns its background and controls |
| Independent card | Card `TLayout` owns its background and content as siblings (or the reusable card `TFrame` root does) |
| Fixed peer KPI cards | Section `TLayout` owns the grid/list; each card-cell `TLayout` owns its own surface and content |
| Fixed single-button actions | Section `TLayout` owns the grid; each cell may directly contain one `TCornerButton` |
| Section title and fixed grid | Both belong to the same section layout |
| Variable record list | Page `.fmx` owns `TListBox`; each runtime `TListBoxItem` owns one reusable card `TFrame` |

Check fixed columns/rows, cell sizing and button hit testing. At the narrowest
supported, reference and wider widths, inspect the bounds of each KPI cell's
background, title, icon, value and note against its actual cell bounds. Verify
the background follows the cell, title/icon have reserved space, and long text
trims/wraps or triggers a planned reflow without collision. Changing only grid
width while children retain fixed positions fails this check. For a single-button
action cell, verify the button fills its cell with intended margins and no
redundant wrapper/layout or overlay glyph is needed. A page content layout
containing several card surfaces, labels and actions as direct children fails this
review even if its screenshot looks similar. A correct `PageScroll -> ContentLayout`
pair still fails when distinct cards have no owners. Conversely, a page with no
cards does not require invented card layouts.

For each standalone UI icon, verify its `TGlyph.Images` resolves to the intended
`TImageList`, its `ImageIndex` is valid, and it does not capture another control's
input. For a button icon, verify `TCornerButton.Images`/`ImageIndex`, a working
style-internal `TGlyph` named `glyphstyle`, and visible icon/text at actual button
sizes. A button style containing only background/text does not satisfy the icon
contract. Verify fixed indices are serialized in `.fmx` and state-dependent icons
change only their index. Reject text/emoji, `TImage` and `TPath` icon substitutes;
keep `TImage` for photos, illustrations and logos.

Review resource nesting and geometry for overlaps, row height, z-order, padding,
text clipping, resize behavior, empty state, long strings and keyboard focus. Flat
hierarchy does not mean flattening logically necessary groups.
Inspect each generic layout's purpose. Remove single-child wrapper chains and
decorative shapes that parent foreground controls without a layout or clipping role.
For deeper paths, identify the actual scroll, tab, list, grouping or reuse boundary.

Check StyleLookup names against the correct shared resource, documented expected
instance properties, actual StyleBook wiring and file/resource deployment. Reject
StyleLookup on primitives, fake ResourcesBin, and TButton in newly converted output.
Check every converted `TListBox` in the `.fmx` for the exact design-time
`StyleLookup = 'transparentlistboxstyle'`, including fixed-column lists. Verify
the applicable host style/theme resolves it and that the list background,
selection, scrolling and card gaps remain visible after the style loads.
Check that state or platform limitations have not been presented as full conversion.

## Execute when available

Use existing documented build/test commands and target configuration. Delphi compilation
alone does not prove every resource property will deserialize or that every style
works. Open the form/frame in the target IDE and run resource/consumer smoke tests.
Test item clicks after scrolling, focus/keyboard, edit selection/caret, disabled
controls and each target platform that is available.

Keep data/image loading off the UI thread while marshalling control updates correctly.
Test clearing/reloading items while pending work exists, using the project's lifetime
and cancellation pattern. Do not add speculative parallel code solely for a demo.

## Report evidence, not intention

Record actual file paths changed, command/target/result for builds, designer/resource
load checks, and behavior/visual checks. Distinguish `passed`, `failed`, and `not run`.
No Delphi toolchain means the implementation may be statically reviewed, not certified
compilable. A minimal example included with a skill is not evidence for a target app.
Record blocking mismatches, not just cosmetic differences. Do not announce success
while an input style has no working caret/content contract or a required action is dead.
