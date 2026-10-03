# Project design continuity for HTML conversion

Maintain the target application's visual design guide as part of a complete `html-to-fmx` conversion. This adds design documentation and reuse to the existing mapping, CSS conversion, implementation, and verification workflow. It does not change native component hierarchy rules or style storage/integration policy. Standalone `html-to-fmx-mapping` and `css-to-fmx-style` keep their existing output scope.

## Discover or create the guide

Follow project instructions and any user-specified design authority. Search the applicable target application root and its UI/design documentation for `DESIGN.md` or an equivalent maintained guide. Reuse the guide for that application or brand, including one previously maintained by `create-fmx-ui`; do not create a competing document or rename an existing equivalent.

If no guide exists, create `<target-application-root>/DESIGN.md` automatically. For an established application, derive its reusable visual language from permitted existing UI, styles, and assets, and distinguish source-page variations. For a new application, derive initial decisions from the requested HTML and resolved CSS, including custom properties, cascade, state and responsive context. Label unresolved values or substitutions rather than inventing them. A single source page establishes only the patterns it actually demonstrates.

Honor restrictions on reading reference frames or creating documentation. If new Markdown files are explicitly forbidden, use an allowed existing document or the response and report that the guide was not persisted. If no target location is known, identify the proposed guide location with the deliverable rather than saving in an unrelated working directory. Routine preparation of this guide requires no separate approval step.

## Preserve source fidelity and existing screens

For a conversion request, keep the requested HTML/CSS appearance as the page target. Use the project guide to identify equivalent tokens, compatible existing style resources, and established asset conventions. A shared color or similar resource name alone does not prove compatible appearance, control type, or state behavior.

If the source differs from the guide, record the difference as a page-specific variant in the UI map and preserve the source within native FMX limitations. Do not silently replace source colors, spacing, typography, or layout with project defaults, or promote a source-page exception to a global theme change. If the user explicitly requests adaptation to the application design, apply that instruction and document the adaptation. Ask only when explicit requirements conflict and the intended result cannot be inferred.

Before modifying an existing shared style, inspect its relevant consumers and preserve previous screens. Reuse compatible resources or add a scoped variant through the existing CSS workflow. This guide does not authorize unrelated redesigns, resource renaming, or theme replacement.

## What the guide records

Keep it concise and follow the existing document's organization:

- Applicable application, platforms, theme/brand, and evidence paths.
- Semantic colors and actual values/encoding; typography roles, fonts/fallbacks and weights; spacing, radii, borders, control sizes, and logical-unit/scale assumptions.
- Reusable component patterns, relevant states, and supported width/reflow behavior evidenced by source or project.
- Main-form/StyleBook identity when known, and links to the actual `FMX_STYLE_MAPPING.md` and style source used by this workflow. Record compatible `StyleName`/`StyleLookup` identities and required instance properties; use the style map for detailed consumer rows rather than duplicating it.
- Available asset conventions, native approximations, and unresolved design drift that affect future conversions.

Distinguish existing resources, proposed additions, implemented changes, and validation actually performed. A guide entry is not proof that a style exists or loads. Per-page component trees, concrete control names, event wiring, and source-specific exceptions remain in the UI map.

## Update and verify

Link the selected guide in the page map before implementation. At completion, check reused design values and resource identities against the guide and the resolved source. Merge only reusable additions or documented corrections; preserve unrelated decisions and avoid regenerating the whole guide. Keep page variants local unless the user requests a change to the application-wide design.

Report whether the guide was reused, created, or extended and provide its path. Continue the existing build, designer, resource-load, behavior, and platform checks with honest evidence; design documentation adds no runtime validation claim.
