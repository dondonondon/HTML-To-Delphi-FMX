# HTML to Delphi FMX skills

Three agent skills for turning HTML/CSS into editable Delphi FireMonkey UI. They guide a coding agent through component mapping, native FMX styling, and `.fmx`/`.pas` implementation. They are instructions and examples, not an automatic transpiler or a substitute for testing in Delphi.

[Bahasa Indonesia](README-ID.md) · [Copy-ready prompts](PROMPTS.md) · [References](SOURCES.md)

## Skills

| Skill | Purpose | Output |
| --- | --- | --- |
| [`html-to-fmx-mapping`](.agents/skills/html-to-fmx-mapping/SKILL.md) | Plan page regions, sections, cards, fixed grids, and variable lists | Markdown component map |
| [`css-to-fmx-style`](.agents/skills/css-to-fmx-style/SKILL.md) | Map CSS roles to native FMX style resources | `.style` and style mapping |
| [`html-to-fmx`](.agents/skills/html-to-fmx/SKILL.md) | Implement an HTML page as native, editable FMX | `.fmx`/`.pas` pairs, reusable cards, style integration, and mappings |

`html-to-fmx` uses both sibling skills in one workflow, so keep all three directories together. Fixed UI belongs in the design-time `.fmx`; variable records use `TListBoxItem -> TFrame` cards. The agent must inspect the target Delphi project and state which checks it actually ran.

## Use in Codex

Codex discovers `.agents/skills` in the current directory and its parents up to the repository root. Open this repository (or a subdirectory) as the Codex working directory, then select a skill through `/skills` or mention `$html-to-fmx`. To use these skills in another project, copy all three directories into that project's `.agents/skills/` and start Codex there. Restart Codex if newly copied skills do not appear. See the [official skill documentation](https://learn.chatgpt.com/docs/build-skills).

For example, from this repository in PowerShell:

```powershell
$skillDest = 'D:\Path\To\DelphiProject\.agents\skills'
New-Item -ItemType Directory -Force -Path $skillDest | Out-Null
Copy-Item -Path .\.agents\skills\* -Destination $skillDest -Recurse -Force
```

Example request after installing the skills in a Delphi project:

```text
$html-to-fmx

Convert docs/ui-dashboard.html to a native FMX dashboard frame.
Inspect the target project's Delphi version, frames, StyleBook, and assets.
Write the UI and style mappings to docs/fmx-mapping/ in the target project.
Keep fixed sections and controls editable in .fmx; use a reusable card frame
for variable transaction records. Build and inspect the result when the
toolchain is available, and report checks that could not be run.
```

The test input included here is [`docs/ui-dashboard.html`](docs/ui-dashboard.html). Copy that file into the target project or replace its path in the prompt. Output paths depend on the target Delphi project. More examples are in [PROMPTS.md](PROMPTS.md).

## Dashboard experiment

The NovaPOS HTML test page appeared like this in a browser:

![Browser rendering of the source dashboard](docs/result/UI-HTML.png)

The archive contains RAD Studio Structure/designer captures, initial application run captures, and run captures after refinement. The refined GPT results used GPT-6 Sol High. The DeepSeek results are **pure DeepSeek with a Codex harness** and have no GPT-6 Sol High refinement image. These images document individual attempts; they do not establish pixel parity, device coverage, or a controlled model benchmark.

| Attempt | Time noted | Design-time structure | Initial run | After refinement |
| --- | ---: | --- | --- | --- |
| GPT-5.6 Terra Light | 7m 21s | [View](docs/result/image-design-time/SSDT-GPT-5.6%20Terra%20Light.png) | [View](docs/result/image-run/before-enhance/SS-GPT-5.6%20Terra%20Light.png) | [View](docs/result/image-run/after-enhance/SSAF-GPT-5.6%20Terra%20Light.png) |
| GPT-5.6 Terra Medium | 12m 42s | [View](docs/result/image-design-time/SSDT-GPT-5.6%20Terra%20Medium.png) | [View](docs/result/image-run/before-enhance/SS-GPT-5.6%20Terra%20Medium.png) | [View](docs/result/image-run/after-enhance/SSAF-GPT-5.6%20Terra%20Medium.png) |
| GPT-5.6 Terra High | 13m 44s | [View](docs/result/image-design-time/SSDT-GPT-5.6%20Terra%20High.png) | [View](docs/result/image-run/before-enhance/SS-GPT-5.6%20Terra%20High.png) | [View](docs/result/image-run/after-enhance/SSAF-GPT-5.6%20Terra%20High.png) |
| GPT-6 Luna High | 21m 34s | [View](docs/result/image-design-time/SSDT-GPT-6%20Luna%20High.png) | [View](docs/result/image-run/before-enhance/SS-GPT-6%20Luna%20High.png) | [View](docs/result/image-run/after-enhance/SSAF-GPT-6%20Luna%20High.png) |
| GPT-6 Sol Light | 5m 34s | [View](docs/result/image-design-time/SSDT-GPT-6%20Sol%20Light.png) | [View](docs/result/image-run/before-enhance/SS-GPT-6%20Sol%20Light.png) | [View](docs/result/image-run/after-enhance/SSAF-GPT-6%20Sol%20Light.png) |
| GPT-6 Sol Medium | 13m 57s | [View](docs/result/image-design-time/SSDT-GPT-6%20Sol%20Medium.png) | [View](docs/result/image-run/before-enhance/SS-GPT-6%20Sol%20Medium.png) | [View](docs/result/image-run/after-enhance/SSAF-GPT-6%20Sol%20Medium.png) |
| GPT-6 Astra Light | 9m 48s | [View](docs/result/image-design-time/SSDT-GPT-6%20Astra%20Light.png) | [View](docs/result/image-run/before-enhance/SS-GPT-6%20Astra%20Light.png) | [View](docs/result/image-run/after-enhance/SSAF-GPT-6%20Astra%20Light.png) |
| GPT-6 Astra Medium | 12m 52s | [View](docs/result/image-design-time/SSDT-GPT-6%20Astra%20Medium.png) | [View](docs/result/image-run/before-enhance/SS-GPT-6%20Astra%20Medium.png) | [View](docs/result/image-run/after-enhance/SSAF-GPT-6%20Astra%20Medium.png) |
| DeepSeek V4 Pro High | 36m 29s | [View](docs/result/image-design-time/SSDT-Deepseek-V4-Pro%20High.png) | [View](docs/result/image-run/before-enhance/SS-Deepseek-v4-Pro%20High.png) | Pure DeepSeek; no refinement image |
| DeepSeek V4.1 Flash High | 24m 30s | [View](docs/result/image-design-time/SSDT-Deepseek-V4.1-Flash%20High.png) | [View](docs/result/image-run/before-enhance/SS-Deepseek-v4.1-Flash%20High.png) | Pure DeepSeek; no refinement image |

**Cost notes from these attempts:** DeepSeek V4.1 Flash High cost **US$0.34** and DeepSeek V4 Pro High cost **US$1.74** during peak hours. Exact GPT costs were not recorded. Based on Pro 5x usage percentages, the Astra attempts were estimated at about **US$1** and the other GPT attempts at **under US$1**. The GPT figures are rough estimates, not measured per-run charges or a controlled cost comparison.

Example from the GPT-6 Sol Medium attempt:

| Designer structure | Initial run | Run after GPT-6 Sol High refinement |
| --- | --- | --- |
| <img src="docs/result/image-design-time/SSDT-GPT-6%20Sol%20Medium.png" width="260" alt="RAD Studio designer and component structure"> | <img src="docs/result/image-run/before-enhance/SS-GPT-6%20Sol%20Medium.png" width="240" alt="Initial application run"> | <img src="docs/result/image-run/after-enhance/SSAF-GPT-6%20Sol%20Medium.png" width="240" alt="Application run after refinement"> |

The design-time captures show the editable frame hierarchy in RAD Studio. The run captures show one desktop rendering per attempt, at the stage indicated by its folder. The HTML preview loads Inter, Material Symbols, and Tailwind from external services; its intended local appearance needs network access.

## Repository contents

```text
.agents/skills/          Three portable skill directories
docs/ui-dashboard.html   HTML test input
docs/result/             Browser, designer, and application-run screenshots
PROMPTS.md               Copy-ready usage examples
README-ID.md             Indonesian documentation
SOURCES.md               Documentation and third-party references
```

The application project and generated conversion documents are not part of this public skill package. See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidance and [LICENSE](LICENSE) for the repository license. External fonts and CDN resources loaded by the HTML preview have their own terms and are not bundled here.
