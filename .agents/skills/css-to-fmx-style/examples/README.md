# Card surface example

`card-surface.css` maps to resource `app_panel_card` in `CardSurface.style`.
The consumer is **TPanel**, with `StyleLookup = 'app_panel_card'`. The resource's
rectangle paints the surface; it is not an application rectangle with StyleLookup.

This file illustrates serialized text and a minimal primitive-based panel style.
It was structurally inspected in the package, but not loaded in Delphi here.
Load and validate it in the target Style Designer before treating it as a known-good
baseline. It is neither a complete platform theme nor a template for TEdit/TCornerButton.
Merge the resource into the project's style rather than replacing an existing full theme.
