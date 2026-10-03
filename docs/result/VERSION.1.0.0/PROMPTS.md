> **Version 1 prompt archive.** Retained with the NovaPOS study. See the [current prompt guide](../../../PROMPTS.md) for all six Version 2 skills.

# Copy-ready prompts

Use these prompts in Codex after placing all three skill directories under the target project's `.agents/skills/`. Adjust output paths to match your Delphi project. `$skill-name` mentions a skill in a Codex prompt; it is not a PowerShell command.

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

## 2. Convert CSS styling only

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

## 3. Convert the complete page to native FMX

```text
$html-to-fmx

Source: docs/ui-dashboard.html
Target page: choose a frame path consistent with the current Delphi project.
Mapping output: docs/fmx-mapping/
Style output: use the project's existing style location.

Inspect the existing project, Delphi version, assets, and StyleBook. Follow
the html-to-fmx-mapping and css-to-fmx-style workflows as directed by this
skill. Implement fixed sections and controls in design-time .fmx resources.
Use a reusable TFrame card for variable transaction records. Integrate the
style with the host, compile if possible, inspect the actual result, and
distinguish completed checks from checks that could not be run.
```

## 4. Refine an existing conversion

```text
$html-to-fmx

Compare the current FMX dashboard against docs/ui-dashboard.html and the
browser reference screenshot docs/result/VERSION.1.0.0/UI-HTML.png. Inspect the existing
.fmx hierarchy, card frame, Pascal handlers, assets, style mappings, and
StyleBook integration. Fix only demonstrated layout or interaction differences.
Check the designer structure and actual application rendering when available.
Report remaining differences and the evidence for each validation step.
```

The screenshots under `docs/result/` show previous attempts. They do not replace checking a new conversion on its target Delphi version and platform. In another project, copy the test HTML there or replace `docs/ui-dashboard.html` with the intended source path.
