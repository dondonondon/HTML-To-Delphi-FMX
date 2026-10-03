# Copy-ready prompts — Version 2

Use these prompts after copying **all six skill directories** and their supporting files into the target project's `.agents/skills/`. Adjust every source and output path to your Delphi project. `$skill-name` selects a skill in a Codex prompt; it is not a PowerShell command.

The current UI-creation skill is `create-fmx-ui`. The healthcare experiment initially called it `create-delphi-fmx-ui`.

## 1. Map an HTML page without implementing it

```text
$html-to-fmx-mapping

Source: docs/ui-dashboard.html
Target project: inspect the current Delphi FMX project.
Output: docs/fmx-mapping/UI_CONVERSION_MAPPING.md

Map the visible page regions, independent sections and cards, fixed grids,
variable record lists, and interactions. Include the proposed FMX hierarchy
and design-time/runtime ownership. Produce the Markdown map only.
```

## 2. Map a screenshot or wireframe without implementing it

Copy the [healthcare wireframe](docs/result/VERSION.2.0.0/wireframe.png) to the target project, or replace the source path with its actual location.

```text
$screenshot-to-fmx-mapping

Source: docs/ui/wireframe.png
Brief: a Healthcare Appointment App for patients, with doctor/symptom
search, health categories, an upcoming appointment, a variable doctor
list, and bottom navigation to messages and a profile.
Output: docs/fmx-mapping/UI_CREATION_MAPPING.md

Inspect the image and target project. Map the application content into
page regions, sections, cards, and a reusable doctor-card list. Separate
observed details from assumptions. Include design-time/runtime ownership
and intended actions from the brief or project. Produce Markdown only.
```

## 3. Convert CSS styling only

```text
$css-to-fmx-style

Source: CSS and visual tokens used by docs/ui-dashboard.html
Output style: assets/styles/Dashboard.style
Output mapping: docs/fmx-mapping/FMX_STYLE_MAPPING.md

Inspect the Delphi version and existing StyleBook resources. Map each used
CSS role to an FMX control and style resource. Preserve compatible existing
styles. Report CSS behavior that has no direct FMX equivalent and the checks
actually run. Do not change application .pas, .fmx, .dpr, or .dproj files.
```

This example explicitly requests an external style file. Direct creation through `create-fmx-ui` defaults to the main form's design-time StyleBook; specify an external file explicitly when you want that destination.

## 4. Convert the complete HTML page to native FMX

```text
$html-to-fmx

Source: docs/ui-dashboard.html
Target page: choose a frame path consistent with the current Delphi project.
Mapping output: docs/fmx-mapping/
Style output: use the project's existing style location.

Inspect the existing project, Delphi version, design guide, assets, and
effective StyleBook. Follow the html-to-fmx-mapping and css-to-fmx-style
workflows as directed by this skill. Implement fixed sections and controls
in design-time .fmx resources. Use a reusable TFrame card for variable
transaction records. Integrate the style with the host, compile if possible,
inspect the actual result, and report completed and unavailable checks.
```

## 5. Create native FMX directly from a brief and wireframe

```text
$create-fmx-ui

Source: docs/ui/wireframe.png
Brief: a mobile Healthcare Appointment App that helps patients find
doctors, view upcoming consultations, explore health categories, and
communicate with healthcare providers. Follow the wireframe's search,
categories, upcoming appointment, doctor list, and bottom navigation.

Inspect the target Delphi project and its DESIGN.md or equivalent.
Create the page and a reusable doctor card as Designer-editable .fmx/.pas
pairs. Run screenshot mapping within this task, use the existing design
authority and effective main-form StyleBook, and preserve project data
and action contracts. Register the screen if required by the project.
Report the source, build, Designer, runtime, and device checks actually run.
```

For a separate mapping stage, complete Prompt 2 first, then supply its mapping document to this creation request. Direct creation already performs screenshot mapping internally.

## 6. Review, refine, or enhance an existing FMX screen

### Review only

```text
$review-fmx-ui

Review the existing FMX dashboard against docs/ui-dashboard.html and the
browser reference docs/result/VERSION.1.0.0/UI-HTML.png. Inspect its .fmx
hierarchy, card frame, Pascal handlers, assets, style maps, design guide,
and effective StyleBook loader.

Report demonstrated layout, style, input, or binding issues with affected
controls, evidence, and the smallest proposed correction. Keep this a
review without edits. Separate source checks from actual rendering and
runtime checks, and state which checks could not be run.
```

### Review and fix

```text
$review-fmx-ui

Review and fix the existing FMX dashboard against docs/ui-dashboard.html.
Correct demonstrated layout, styling, clipping, or interaction defects
in place. Preserve the established hierarchy, component names/types,
reusable card boundaries, bindings, navigation, and action contracts.

Check Designer structure and actual rendering when available. Report
the changes, remaining differences, and evidence for each validation step.
```

For deliberate improvements beyond correcting defects, explicitly request `enhance` and describe the desired visual or UX changes. Use the existing screen's source, images, and design guide as the comparison basis.

## 7. Compose existing cards with requested demo data

Use this follow-up when you want a populated demo after creating the page and cards. It addresses the shared gap observed in the four healthcare workflows.

```text
Add fictional dummy data using the cards already created. Implement the
cards on the UI page: create list items, attach card instances, and populate
them through the existing bindings. Load demo data once when the page is
created. Preserve later data bindings, including empty results.
```

The author's original prompt was: “Tambahkan Data dummy nya dengan card yang sudah anda buat” — “Add dummy data using the card you have already created.”

Dummy data is an explicit demo request. Production UI uses actual project data and preserves loading, empty, and error states.

## The four healthcare experiment routes

The [English case-study website](docs/result/VERSION.2.0.0/static-website/index.html#prompts) contains the shared brief and refined step-by-step prompts for:

1. Google Stitch MCP → HTML export → `html-to-fmx`.
2. Direct `create-fmx-ui`.
3. Separate `screenshot-to-fmx-mapping` → `create-fmx-ui`.
4. Agent-generated HTML/CSS → `html-to-fmx`.

You can also [download the complete healthcare prompt guide](docs/result/VERSION.2.0.0/static-website/assets/downloads/healthcare-prompt-guide.txt).

These guide prompts are refined from the author's brief and described workflows, rather than verbatim logs. Method 4's recorded HTML-stage prompt omitted `DESIGN.md`; its suggested additional design instruction is presented separately as an untested refinement.

## Sources and previous version

The [NovaPOS HTML](docs/ui-dashboard.html), [healthcare HTML](docs/ui-wireframe.html), and [wireframe](docs/result/VERSION.2.0.0/wireframe.png) are example inputs. Copy the intended source and assets into your target project, or use their actual locations. Output paths belong to that target project.

The screenshots under `docs/result/VERSION.1.0.0/` and `docs/result/VERSION.2.0.0/` record previous attempts. Check each new implementation with the available target Delphi toolchain. The [V1 prompt archive](docs/result/VERSION.1.0.0/PROMPTS.md) preserves the original three-skill examples.
