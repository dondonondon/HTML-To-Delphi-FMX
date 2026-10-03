# StyleBook integration belongs to html-to-fmx

## Discovery and placement

Find the actual application's main form from the project, not from an assumed
filename. Reuse the suitable existing design-time TStyleBook. If none exists, add
one to that main form's `.fmx`, add its matching `.pas` field, and assign the form's
StyleBook property. Do not create a new StyleBook per widget/page.

Do not assume a TFrame has a form-style `StyleBook` property. Frames use the host
form's applicable style context. Verify style availability on all consuming forms
and their creation order; merely placing a StyleBook on one form is not a proof that
all other forms use it. Integrate with the project's existing style manager if present.

For a new task with no host/main form supplied, generate the requested page/frame and
style, but identify host integration as pending. Do not create an unrelated application
just to hide this missing project context.

Before authoring styles, trace embedded resources, initialization loaders, `.dproj`/
resource inputs and later theme loads. Record the effective runtime source and load
order. An existing `LoadFromFile`/`LoadFromStream` call can replace embedded definitions;
do not assume it merges them or that editing the main form alone survives startup.

## Source, preview and runtime

The generated `.style` is the maintainable external source. Select the existing
project's integration strategy rather than assuming a new file is automatically used.
When an existing source is compiled into a named resource, update that authoritative
source through this workflow and preserve the existing resource identifier and loader.
Verify the project compiles the updated source, and synchronize any embedded designer
copy. Avoid adding a second competing source or an unrelated replacement loader.
`create-fmx-ui` retains its own main-form destination and explicit external-write policy;
use its appearance reference for a verified merge when an existing loader would overwrite
main-form additions.

Preferred where available: load/save the external file through the target IDE's
Style Designer into the design-time StyleBook, so the resource is available in the
designer and deployed without an external-path dependency. Keep external and embedded
versions synchronized; record the source file and how it is refreshed.

Never fake embedded binary `ResourcesBin` data. Without the IDE/verified tooling,
use a real supported loader for the external file and record that designer preview
embedding was not completed. Do not claim design-time preview is verified merely
because the runtime can load the file.

For external loading, reuse an existing initialization hook or chain a new one without
replacing old logic. Check the file and load it through the target StyleBook API;
handle/report failure explicitly rather than swallowing it. This small initialization
is allowed; it is not runtime creation of static UI. Load before showing styled content.

A path beside the executable is a Windows deployment option, not a universal mobile
asset path. For Android/iOS use actual deployment mappings and platform-readable
locations verified in the project. Do not hardcode `D:\...` or a developer machine
path into application behavior. Update project deployment only where necessary.

## Applying mapped styles

Set StyleLookup in design-time `.fmx` for applicable controls using exact names from
`FMX_STYLE_MAPPING.md`. Follow any required instance geometry/text settings returned
by the CSS skill, including TCornerButton radii where applicable.
For a single-use card surface, apply the mapped fill, stroke, radius and effects
directly to a sibling `TRectangle` in `.fmx`; it has no StyleLookup. Use one
styled `TPanel` background when multiple identified card consumers share the
same surface. FMX style names need not match CSS names; the mapping records
their provenance and may map several CSS selectors to one StyleLookup.

For every converted `TListBox`, including fixed-column and variable-data lists,
serialize `StyleLookup = 'transparentlistboxstyle'` on the list in the page/frame
`.fmx`. Check that this name resolves in the host's applicable FMX style context
on the target Delphi version and platforms, and that list backgrounds, item
clicks, optional selection and scrolling render as intended. Reuse the working
project/theme resource. If it is unavailable, adapt a compatible native listbox style through
the style workflow and integrate it into the host; do not generate an empty
placeholder merely to satisfy the name.

For icon-bearing `TCornerButton` controls, set `Images` and `ImageIndex` on the
button. Inspect the selected custom style for a functioning `TGlyph` part named
`glyphstyle`; a style with only `background` and `text` cannot be assumed to
render the icon. Keep glyph positioning and spacing inside the button style and
verify the icon, text, pressed/focus states and hit area on the consumer. Avoid a
separate frame-level glyph merely to compensate for an incomplete button style.
Reuse one StyleLookup for icon-only buttons with the same surface, states and
glyph placement, regardless of their icon or action. Verify the glyph is centered
or intentionally client-aligned at actual button sizes.

For simple `TLabel` typography, use design-time `TextSettings` properties and
leave StyleLookup unset unless a shared text resource provides behavior beyond
those properties. On a `TLabel`, `TCornerButton`, `TButton` or other control with
`StyledSettings`, remove only the flag for each locally assigned text value:
`Family` for font family, `Size` for font size, `Style` for font style, and
`FontColor` for font color. `Other` covers text alignment, trimming and word wrap
together. Keep flags for style-owned values; use `StyledSettings=[]` only when
all text settings are local. A typography-only StyleLookup paired with
`StyledSettings=[]` on the same control is redundant.

Update the mapping with actual `Unit.Control` consumers after integration. Do not
copy the same StyleLookup onto TRectangle, TLayout, TImage, TGlyph, or a frame that does not
support it. Use a sibling `TRectangle` for one-off card surfaces or a styled
`TPanel` for surfaces shared by multiple consumers; foreground controls remain
siblings rather than children of the background.

For shared-surface validation, count actual usage rather than only distinct source
paths. One `Unit.Control` inside a card frame instantiated for variable records is
a repeated consumer; record the frame and its list/factory as evidence. A genuinely
one-off control remains single-use. See the CSS conversion reference's consumer rules.

Do not replace a full platform theme with a small custom fragment accidentally.
Verify fallback and base resources for controls not explicitly converted. Test actual
buttons/edit boxes, not just the appearance of a decorative panel.
Check requested resource names and preserved consumers after startup and any existing
theme reload, not only immediately after deserializing the form.
