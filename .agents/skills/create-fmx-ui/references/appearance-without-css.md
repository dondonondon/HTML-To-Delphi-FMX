# Appearance and main-form StyleBook ownership

Use this storage and integration policy for every `create-fmx-ui` task, including briefs or screenshots accompanied by CSS. Retain the shared FMX component and hierarchy rules. Record appearance decisions in the screen's UI map; a separate CSS mapping is not required for main-form style updates or supported instance properties.

## Style destination

1. Find the actual main form from the project. Trace its embedded `TStyleBook`, initialization code, `.dproj`/resource inputs, external loads and theme reloads before editing. Record the effective runtime source and load order in the UI map. Reuse compatible resources that actually reach consumers; author requested additions in the main form's existing design-time StyleBook while preserving unrelated resources and platform variants.
2. If no StyleBook exists on the main form, create one in that form's `.fmx`, synchronize its `.pas` field, and assign the form's `StyleBook` property. Frames consume the host's style context; do not create a StyleBook per frame or assume a `TFrame.StyleBook` property.
3. Write an external style file only when the prompt explicitly asks for that file to be created or updated. For example, `update assets/style/main.style` permits an update to that destination. Merely finding or being shown a `.style` file permits inspection, not an update, export, replacement, or a new sibling style file. The rule applies regardless of binary or text serialization.
4. Use the IDE or verified Delphi serialization tooling allowed by the current project instructions to save embedded style changes in the main form. Do not fabricate `ResourcesBin` bytes or decode binary resources as text. If safe embedded editing is unavailable, complete independent UI work and report main-form style integration as pending; do not silently switch to external-file generation or runtime loading.

When no host project/main form is supplied, keep the requested screen scope and identify main-form integration as pending. Do not create an unrelated application to provide a host.

## When startup replaces the embedded style

An existing resource/file loader may replace the StyleBook edited in `.fmx`. Choose the integration route before authoring resources:

- Reuse compatible resources from the loaded source when they already satisfy the screen. A resource available only before startup is not a working reuse target.
- For required main-form additions, use a small, verified integration at the existing initialization hook: retain the requested embedded resource definitions before replacement, load the established base, then merge those definitions into the effective style before consumers are shown. Merge by `StyleName` and the applicable platform variant, preserving unrelated base resources. Identical definitions can be reused; use a scoped name for an incompatible collision unless changing that shared resource is within the task's scope.
- Use target-supported cloning/serialization, object ownership and style refresh behavior. Do not assume a second `LoadFromStream` call appends resources, invent a merge API, remove the existing loader, or add runtime factories for static controls. Keep the definitions embedded and the main form's existing StyleBook as the consumer context.
- If the task explicitly authorizes an external source update, update that authoritative source instead and synchronize its embedded designer copy and existing resource/deployment pipeline. Record both destinations.

Verify the requested names and existing consumers after initialization and after any existing theme reload. If compatible reuse or a verified merge is unavailable and external writes were not requested, complete independent UI work and record the exact runtime source, affected names and required decision. Do not report an overwritten embedded edit as completed integration.

## Choose and record the visual values

Use the project's selected `DESIGN.md` or equivalent, prepared through [project design guidance](project-design.md), together with the established theme and assets. Reuse recorded values before choosing new ones. For a screenshot, distinguish observed values from estimates and record page-specific differences in the page map. For a new application without a guide or theme, establish a coherent small set of typography sizes, spacing, colors, radii, and control heights in the guide before implementation. Resolve minor visual choices without a separate approval step.

## Select the FMX destination

| Situation | Implementation | Record in the UI map |
|---|---|---|
| A compatible style is available in the main form's style context | Reuse its exact `StyleLookup`; verify host resolution | Main form/StyleBook, consumer, resource name, required instance properties |
| Supported per-instance geometry or visual properties express the design | Serialize them in `.fmx`; account for `StyledSettings` | Consumer, property/value, reason it belongs to the instance |
| The design needs different styled-control parts or state appearance | Adapt a working style for the target class and Delphi release inside the main form's StyleBook | Main form/StyleBook, resource, consumers, named parts, states and verification |
| The prompt explicitly requests an external style file update | Update that destination with verified tooling and inspect how the host consumes it | Requested file, affected resources, host integration, synchronization/deployment if applicable |

A one-off decorative shape can use native design-time properties. Styled buttons and inputs require their actual style contracts; do not invent direct `Fill`/`Stroke` properties on `TCornerButton` or `TEdit`. Inspect target-compatible styles before authoring new interactive resources. Preserve text, focus, pressed/disabled behavior, input content/caret/selection, and `glyphstyle` for icon buttons where applicable. Reuse semantic resource names and preserve unrelated styles.

For main-form changes, record the exact main-form `.fmx` path, StyleBook component, resource `StyleName`, compatible consumer class, `StyleLookup`, actual `Unit.Control` consumers, and required instance properties in the UI map or existing project style map. If an external file was explicitly requested, also record that file and its host integration; create `docs/ui/FMX_STYLE_MAPPING.md` only when needed for that external-style handoff. Use native roles and input evidence when CSS selectors are unavailable.

## Integrate and verify

Use the shared StyleBook reference for native host-context and consumer contracts. Apply this skill's main-form storage policy instead of that reference's default external-source and runtime-loader fallback. The style-name handoff comes from the UI map or existing style map. Verify style availability on consuming forms and frames after the recorded load sequence, including the merge or explicitly requested source synchronization above. For an explicitly requested external-file change, follow the actual host loading/embedding and deployment strategy and report any required synchronization.

Verify resource contracts and consumer behavior with the available target tooling. Record `passed`, `failed`, or `not run` for style resolution/load, designer preview, visual comparison, and input behavior. A balanced text resource or a matching color table does not establish a working style.
