# FMX style format and component contracts

## Real resource format

A `.style` file is an FMX serialized object resource, commonly text or binary. Prefer
text for a newly authored, version-control-friendly file when supported by the target.
Use the target IDE/runtime to load, save, and validate it. Preserve an existing binary
style unless a verified conversion route is available; never edit binary content as text.

A minimal text-style structure is demonstrated in `../examples/CardSurface.style`:
an outer `TLayout` contains a resource with its own `StyleName`. Application components
select that resource through `StyleLookup`; these are two different properties.
This example demonstrates a panel surface only. It is not a complete platform theme.

Do not use `TStyleBook` as an invented text-style root or synthesize `ResourcesBin`
hex in a form. Use Delphi-generated serialized data when embedding a style.

## Styled controls versus primitives

`TPanel`, `TLabel`, `TCornerButton`, and `TEdit` are compatible kinds of style consumers.
`TRectangle`, `TLayout`, and `TImage` are primitives/layout controls, not equivalent
`StyleLookup` consumers. Verify the concrete target class and published properties.

To share a card background through StyleBook without deep application nesting:

```text
TFrameCustomerCard
├── BackgroundPanel: TPanel  [Align=Contents, HitTest=False, StyleLookup=app_panel_card]
├── CustomerImage: TImage
├── NameLabel: TLabel
└── SubtitleLabel: TLabel
```

The rectangle belongs inside the panel's style resource. Foreground controls do not
become children of the panel. A one-off primitive background may instead carry
properties in `.fmx`, but record that as a design-time property mapping, not a style.
Do not add custom component classes only to give a rectangle a style.

## Preserve the target's actual contract

Before building button/edit/list styles, inspect a working style for the target
version and component. Named parts such as text, background, content, caret, and
selection can be consumed by FMX code; their requirements are component/version-specific.
Do not assume every class looks for the same names or casing. Verify rather than
inventing a list of required parts.

For `TCornerButton`, preserve the corner geometry contract and the relevant resource
shape. Set matching instance XRadius/YRadius in `.fmx` when the target control applies
those values to its resource. Include these values in the handoff. Do not style an
ordinary button and assume corner behavior is identical.

When a `TCornerButton` should show an icon through `Images`/`ImageIndex`, its
custom style needs a target-compatible `TGlyph` part named `glyphstyle` in addition
to background/text. Inspect an existing working style for the target Delphi version;
place the glyph and text with enough space at the smallest button width. Merely
setting `ImageIndex` on a button whose style has no glyph part does not establish
that the icon will render. Keep the glyph inside the style instead of requiring a
separate application-level icon overlay for a single button.

Do not recursively embed styled controls with the same StyleLookup inside their own
resources. Prefer primitives, layouts, text and verified effects for style internals.
The application's flat-hierarchy policy does not forbid nesting required inside a
style contract; that internal tree is separate from application form/frame composition.

Check text `StyledSettings` deliberately. Do not accidentally override a shared style
with per-control font assignments, and do not indiscriminately clear all styled settings.
When a platform supports native `ControlType`, verify whether the custom style applies;
use the styled presentation for controls whose custom StyleBook appearance is required.

## Integration belongs to skill 2

This skill outputs the external style and mapping only. The UI skill creates/reuses
the main form's design-time `TStyleBook`, assigns it to the form, and selects an embedding
or deployment/loading strategy. Do not edit application forms from this standalone skill.

Official references are listed in the package's `SOURCES.md`. Prefer the installed
Delphi source/IDE for the exact target release over assuming a documentation example
from a different version is directly reusable.
