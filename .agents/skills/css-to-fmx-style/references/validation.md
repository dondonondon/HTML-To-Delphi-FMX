# Style validation

## Static inspection

Check real object-resource syntax, stable/unique top-level style names, exact
StyleLookup spelling in the mapping, color encoding, supported classes/properties,
and preservation of unrelated existing resources. Distinguish resource names from
repeated internal names such as `text` inside different styles.
Audit newly created resources against existing and newly mapped consumers:
reject duplicate resources that differ only by source CSS name, icon index,
action name, or a property that belongs on a single design-time instance.
Confirm every new card-surface resource has multiple identified instances or a verified
repeated frame/list binding, using the consumer definition in
[conversion rules](conversion-rules.md). One source declaration instantiated per record
qualifies even with an empty or single-record result; a genuinely one-off instance maps
to `TRectangle` properties. Confirm simple label
typography maps to `TLabel` properties rather than one style per text token.
For newly converted font settings, verify the effective FMX font size is never
exactly `12`: the `12` case must be `12.5`, while all other sizes remain as mapped.

Compare every generated component family against a target-compatible style contract.
For newly authored interactive controls, inspect the normal, focus, pressed, disabled,
selection and editable-content requirements applicable to the source.

## Target checks

In standalone CSS conversion mode, use a disposable host outside the application source
or an existing test harness that accepts the style without editing application forms or
project registrations. If no suitable host is available, report consumer testing as
`not run`. When invoked as part of `html-to-fmx`, continue using that workflow's normal
host integration and validation steps.

Use the actual Delphi toolchain when available. Test loading the `.style` through
the IDE's Style Designer or the target `TStyleBook.LoadFromFile` implementation.
Then attach the style to a host form and exercise actual consumer controls. Inspect
text visibility, input/caret/selection, focus, disabled state, corner geometry and resize.
A file that loads is not yet proof that every consumer's contract works correctly.
For icon-bearing `TCornerButton` consumers, set an actual `Images`/`ImageIndex` and
verify that `glyphstyle` renders the icon without covering or clipping the text at
the smallest supported button width. Exercise pressed/focus/disabled appearance
and the button's click target; a parsed glyph part alone is not visual proof.
For icon-only buttons, inspect actual glyph bounds at each supported button size:
the glyph must be centered or intentionally fill with margins. Check that
consumers with the same visual/state contract share one StyleLookup. For styled
text controls, compare the intended style-owned and instance-owned values with
their `StyledSettings`; a local value whose flag remains set is not an effective
override, while `StyledSettings=[]` can make a typography-only style redundant.

Also verify target platforms and presentations; a Win64 test is not an Android/iOS test.
Do not convert the whole project/build system merely to manufacture validation evidence.

## Honest result vocabulary

Report each separately: static inspection, style load, consumer smoke test, project
build, designer open, and visual/platform checks. Use `passed`, `failed`, or `not run`,
with the command/result or reason. No compiler/IDE available means `not run`, not `passed`.
Keep unresolved non-critical appearance differences distinct from an invalid resource
or an input component whose content/caret contract is broken.
