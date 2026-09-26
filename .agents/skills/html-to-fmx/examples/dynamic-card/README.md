# Dynamic-card pattern

This is a small pair of designer-resource examples, not a complete executable project.
It illustrates the architecture, ownership and event flow. Adapt unit names and API
signatures to the inspected target project. No network/data service is supplied.

`FrameCustomerListPage.pas/.fmx` contains the static header, TCornerButton, TListBox
and footer. The list has design-time `StyleLookup = 'transparentlistboxstyle'`;
the host must resolve that style from its applicable theme/StyleBook. Its
`SetCustomers` creates only runtime items and widget instances.
Each created item sets `Selectable=False`; whole-card actions are wired through
`OnItemClick`. Verify that event on the target FMX version.
`FrameCustomerCard.pas/.fmx` contains the design-time widget internals, all with
HitTest=False. No factory recreates the widget's labels/panel at runtime.
`AddCustomer` reserves an 8-unit example gap in each item and insets the aligned
card by that amount, so the card background does not fill the gap. Use the same
method for preview and real records; replace 8 with the mapped source/project
spacing. Check the actual gap with the target TListBox style and after resize.

The whole-item click is handled by TListBox.OnItemClick and forwarded to
`OnCustomerSelected` with a typed string ID. The host must handle that event and
`OnReloadRequested`, and provide actual data on the UI thread. Clear/reload releases
owned item/frame instances. This minimal example does not perform async work.

The card's TPanel uses `app_panel_card` from the other skill's
[CardSurface.style](../../../css-to-fmx-style/examples/CardSurface.style).
The host application must merge/load that resource into its applicable StyleBook.
It is deliberately not duplicated here. Labels and the reload TCornerButton use
existing/default styles in this pattern because no CSS for those controls is supplied.
A real conversion must map their actual CSS through the style skill too.

Checks performed for packaging: paired filenames, root class and field matching,
resource nesting, handler declarations and explicit widget HitTest settings. Delphi
compile, IDE loading, style loading, keyboard and device testing were not run here.
Do not claim these files are compile-tested based on the package checks.
