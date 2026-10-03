# Data lists with TListBoxItem + design-time TFrame

## Mandatory pattern

```text
Page .fmx
  CustomersListBox: TListBox
    TListBoxItem (one per record)
      TFrameCustomerCard instance (card layout defined in its own .fmx)
        BackgroundPanel
        CustomerNameLabel
        CustomerDetailLabel
```

Define one widget per meaningful visual variant, not one class per record. Its public
binding method accepts a lightweight DTO or the project's existing model. No database
query, network request, navigation singleton or hidden service locator in the widget.

## Variable label/value details

A product's General Information, specifications, or similar label/value rows can
be a data list when supplied as a collection or when the field set, order, or row
count varies by entity or response. HTML example rows do not establish a fixed set.
Keep the section heading/surface and `TListBox` in the page `.fmx`. Give one
reusable detail-row `TFrame` design-time label and value controls; bind its text,
optional status decoration, and stable field key for each item. Use the same class
for SKU, barcode, category, status, location, and other rows with that visual
shape. Do not create one frame unit per attribute or copy the HTML row wrappers.
If only the values change while the field set is known and fixed, keep those fields
as static controls in the section instead.

Follow existing card naming and placement conventions; when none exist, use
`frames/cards/frCard<Entity>.pas` and `.fmx`, with a `TFCard<Entity>` class and matching
`FCard<Entity>` resource root. One card class serves all records of that type; never
generate separate units for dummy row 1, row 2 and row 3.

The page owns the design-time `TListBox` with
`StyleLookup = 'transparentlistboxstyle'` serialized in its `.fmx`. Normally
create and bind `TListBoxItem` and card instances at runtime because the number
of records varies.

## Optional preview and validation records

Prefer available real records for validation. Provide two or three representative
fixtures only for a requested demo/designer preview or an isolated validation harness;
do not add a production preview mode, switch, or dummy-loading branch for conversion
alone. When preview is prohibited, omit it and record unavailable populated-list
checks as `not run` if real records cannot exercise them.

When used, bind fixtures through the same item factory and card binding path as real
records. Include long text, status and optional content where relevant. Keep fixtures
in the requested demo or isolated harness and never pass them to services or present
them as saved records. Clear or replace any explicitly requested application demo
items before real data loads; repeated activation must not duplicate them.
An empty result, network failure or authorization
error from a real source must keep its actual empty/error state; never substitute
dummy records automatically.

If the requested deliverable specifically needs populated items in the Delphi
designer, serialize a small preview only when the target Delphi version can load
`TListBoxItem -> TFrame` reliably. Verify it opens in the designer, then remove or
replace those preview items when real data is bound. The card's fixed visual controls
always remain design-time in the card `.fmx`.

## Input transparency

Set `HitTest=False` in the widget `.fmx` for the frame and every visual descendant.
Keep decorative controls out of keyboard navigation too. A small recursive helper
may enforce transparency after creation; it is behavior setup, not runtime UI construction.
Verify style-generated children after styles apply. Do not disable the whole frame
with `Enabled=False`, since disabled styling is not equivalent to input transparency.

Set each runtime `TListBoxItem.Selectable := False` when creating it, including
preview rows. This prevents persistent selected-row state; it does not mean
disabling the item or making it input-transparent. Bind whole-card behavior to
`TListBox.OnItemClick`, using the exact event signature from the target Delphi
version. Verify a tap/click still dispatches the intended row ID with
`Selectable=False`. If the source requires persistent row selection, document
that exception and use `Selectable=True` deliberately. Do not wire all
labels/images to a common click handler or use the frame's OnClick.

For a source row with an independent action such as Copy SKU or Scan Barcode, do
not make a button inside the input-transparent card appear clickable. Where the
target FMX version supports it, create an item-owned `TCornerButton` as a sibling
of the card frame. For an icon, use the button's `Images`/`ImageIndex` with a
custom style containing a working `glyphstyle` `TGlyph` part. Reserve space
in the row so the action does not cover the value. Bind the action to that row's
stable key in the host, and verify it does not also dispatch `OnItemClick`. Reuse
the same card frame for rows with and without an action. If an independent action
or editable control cannot work with this pattern, document the conflict and
request a behavior decision; never silently drop it.

Creating this optional sibling with a variable item is a narrow exception to the
runtime-control restriction. It belongs to the shared item factory and the item's
lifetime, with its action, geometry, style and row identity recorded in the map.
Assign its mapped instance properties, including `Images`/`ImageIndex`, in that factory.
Bind and free it with that item. The card's fixed descendants remain in its `.fmx`,
with `HitTest=False`; this exception does not permit recreating card children,
building a static page in code, adding presenter wrappers, or moving the action into
the card. Verify its hit area after resize/scroll and that one activation dispatches
only its own action. Fixed design-time items keep their actions design-time.

## Identity, ownership and exceptions

Prefer the project's existing binding strategy or a small typed TListBoxItem descendant
with a string/Int64 ID. Avoid pointer casts and truncating 64-bit IDs into NativeInt Tag.
`TagObject` is not an ownership policy; document/follow explicit ownership when used.

The list can own the item; the item owns its frame. Parent establishes the visual
hierarchy, not a complete substitute for object lifetime management. Do not double-free
owned widgets. Free an uncommitted item if frame creation/binding raises.

Use a try/finally-protected BeginUpdate/EndUpdate around batches. Set item height based
on the widget's intended height and actual layout; leaving the default row height can
clip a card. For visually separate cards, choose a positive gap from the source
spacing or project spacing scale, and make it part of every item's geometry:
`Item.Height = visible card height + gap`. Keep the frame's painted surface within
the visible card height, for example `Frame.Align=Client` with
`Frame.Margins.Bottom=gap` where the target item style honors that margin. A larger
item height alone creates no gap if an `Align=Client` frame expands into it.
Use one gap mechanism; card-internal padding is not space between cards, and
stacking item margins, frame margins and list padding can double the gap. An
`Align=Top` frame with an explicit measured height/width is another option when
the target style requires it; verify its width and resize behavior. Measure again
after binding or reflow if content changes card height. Do not add empty spacer
items or wrapper layouts just to separate cards. Keep item click handling on
the whole row, including the gap.

Apply that same item factory, gap and card height calculation to real records and
preview records when used. For a multi-column data list, check spacing on both axes and
that added space does not clip card content or overflow a column. If the source
intentionally uses connected rows with dividers instead of separate cards,
record that choice and implement visible dividers; do not leave touching card
surfaces as an accidental default. Check the first, adjacent and last visible
items at the narrowest supported, reference and wider widths, including long
text and after clear/reload. Check the list viewport: show all preview rows when
the design calls for it, otherwise make the remaining rows reachable by scrolling.
Keep the item/frame names safe for repeated instances and preserve unique component
names within each owner. Consider list built-in text/selection/padding so it does not
show a duplicate label behind the widget or hide focus/selection feedback.

## Scale and threads

TListBox with arbitrary embedded frames is not automatically virtualized. Do not
promise cheap creation of thousands of widgets. Use the project's paging/incremental
loading and batch updates first. Do not replace the required container or build a
virtualization framework without a demonstrated requirement and permission.

Create/update FMX controls on the UI thread. For async images/data, avoid callbacks
capturing frames after their item is freed. Reuse the existing cancellation/lifetime
pattern.
The examples under `../examples/dynamic-card` illustrate bindings, typed item identity,
exception cleanup, batching and designer-created widget internals. They are not a
backend implementation, finished screen, or Delphi-certified component package.
