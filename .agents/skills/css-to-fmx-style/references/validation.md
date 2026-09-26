# Style validation

## Static inspection

Check real object-resource syntax, stable/unique top-level style names, exact
StyleLookup spelling in the mapping, color encoding, supported classes/properties,
and preservation of unrelated existing resources. Distinguish resource names from
repeated internal names such as `text` inside different styles.

Compare every generated component family against a target-compatible style contract.
For newly authored interactive controls, inspect the normal, focus, pressed, disabled,
selection and editable-content requirements applicable to the source.

## Target checks

Use the actual Delphi toolchain when available. Test loading the `.style` through
the IDE's Style Designer or the target `TStyleBook.LoadFromFile` implementation.
Then attach the style to a host form and exercise actual consumer controls. Inspect
text visibility, input/caret/selection, focus, disabled state, corner geometry and resize.
A file that loads is not yet proof that every consumer's contract works correctly.
For icon-bearing `TCornerButton` consumers, set an actual `Images`/`ImageIndex` and
verify that `glyphstyle` renders the icon without covering or clipping the text at
the smallest supported button width. Exercise pressed/focus/disabled appearance
and the button's click target; a parsed glyph part alone is not visual proof.

Also verify target platforms and presentations; a Win64 test is not an Android/iOS test.
Do not convert the whole project/build system merely to manufacture validation evidence.

## Honest result vocabulary

Report each separately: static inspection, style load, consumer smoke test, project
build, designer open, and visual/platform checks. Use `passed`, `failed`, or `not run`,
with the command/result or reason. No compiler/IDE available means `not run`, not `passed`.
Keep unresolved non-critical appearance differences distinct from an invalid resource
or an input component whose content/caret contract is broken.
