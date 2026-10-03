# Maintain the target application's design guide

Establish reusable visual decisions before page mapping, for both written briefs and image inputs. The guide belongs to the target application; do not create a generic `DESIGN.md` inside the skill package or use this repository's working directory when the requested application is elsewhere.

## Find or prepare the guide

1. Follow project instructions and any user-specified design document. Inspect the applicable application root and its design/UI documentation for `DESIGN.md` or an equivalent maintained guide. For repositories with several applications or brands, select the guide for the requested target. Extend an equivalent existing document rather than creating a second competing authority. Do not rename it merely to match `DESIGN.md`.
2. Compare the relevant guide with representative UI, main-form StyleBook resources, and available assets. Read only evidence permitted by the user's scope; a prohibition on inspecting reference frames still applies. Keep observed values separate from inferred choices and unresolved mismatches.
3. If no guide exists and the application already has UI, create `<target-application-root>/DESIGN.md` from its established theme and recurring patterns. Record conflicting or unavailable evidence; do not treat an arbitrary outlier screen as the application's standard.
4. If neither a guide nor existing UI is available, create the guide from the brief, brand information, target platforms, and any supplied visual reference. Choose a coherent small set of values for unspecified visual details and label them as initial design decisions. Continue implementation without requiring separate design approval. Ask only when a material missing requirement or conflict blocks the requested result.

If the user explicitly forbids new documentation files, retain the design decisions in an allowed existing document or the response and state that they were not persisted. If no target location can be inferred, provide the proposed guide with the deliverable and identify the unresolved save location; do not save it in an unrelated project.

## Keep the content useful and concrete

Include only decisions relevant to this application, adding detail as screens require it:

- Target platforms, theme/brand, intended density, and the source of the design decisions.
- Semantic colors such as primary action, background, surface, text, border, success, warning, and error. Record actual values and their encoding, including alpha where relevant.
- Typography roles with font family/fallback, size, weight, line handling, and platform limitations when known.
- Spacing scale, page padding, card gaps, corner radii, border widths, control heights, and supported widths/reflow rules. Distinguish logical UI units from screenshot pixels.
- Reusable visual patterns for headers, cards, primary/secondary actions, inputs, lists, and empty/loading/error states used by the application.
- Main-form path and StyleBook identity when known. Map component roles to existing `StyleName`/`StyleLookup` resources and required instance properties. Distinguish observed existing resources, planned resources, implemented changes, and checks actually performed. Never invent a resource name and describe it as already available.
- Icon/image asset conventions and named exceptions or unresolved design drift that materially affect reuse.

Reuse the existing guide's organization. This file describes the application's visual design; skill rules remain the implementation authority, and per-page component names, trees, handlers, and business fields belong in page maps and existing contracts.

## Reuse across screens

Read the guide at the start of every screen task. Reference its values and patterns in the page map; do not choose a fresh palette, type scale, or card treatment simply because the next screen is different. Consistency means shared visual language, while each screen retains a layout suited to its purpose.

Reuse compatible resources first. Add a reusable decision to the guide when genuinely needed; merge into the relevant section rather than regenerating the entire file. Retain existing values, resource identities, and decisions unless the user requests a change or current evidence establishes a documented correction. A change to a shared StyleBook resource can affect older screens, so inspect its relevant consumers and keep one-page variations scoped.

If a screenshot differs from the guide, honor the user's stated intent: an explicit request to reproduce that appearance can justify a page-specific exception, which belongs in the page map. Do not promote a screenshot's differences to global standards or redesign other pages automatically. If the user requires both exact reproduction and a conflicting application standard, identify the conflict and ask only for the unresolved choice. Document/code drift likewise needs a recorded decision; do not silently rewrite the guide to match whichever source was read last.

At completion, verify consistency with the guide, record new reusable decisions and actual resource status, and report the selected guide's path. Preserve the default of editing style resources in the main form; a `DESIGN.md` path or design token is not permission to write an external `.style` file.
