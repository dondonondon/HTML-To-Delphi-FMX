# Official reference notes

Documentation originally checked on 2026-09-17 and Codex skill discovery rechecked
on 2026-09-26. These references
explain the technical basis; the target Delphi installation remains authoritative
for exact published properties and component contracts. No vendor style bundle,
font file, or proprietary framework source is redistributed here.

## Codex skill packaging and discovery

- OpenAI, Build skills: https://learn.chatgpt.com/docs/build-skills
  Covers SKILL.md, progressive disclosure, `.agents/skills` discovery, symlink support,
  explicit invocation with `$` / `/skills`, and optional `agents/openai.yaml`.

The `.codex` storage plus per-skill Windows junction arrangement is this package's
installer design. It is not a claim that OpenAI mandates `.codex/skills` as the current
repository discovery path. Skill composition here is implemented by instructions
that read the sibling SKILL.md, not a documented skill-to-skill dependencies YAML field.

## FireMonkey

- Embarcadero, FireMonkey Component Design:
  https://docwiki.embarcadero.com/RADStudio/en/FireMonkey_Component_Design
  Describes primitive-based TPanel styling and why component style contracts matter.
- Embarcadero, TRectangle properties:
  https://docwiki.embarcadero.com/Libraries/Athens/en/FMX.Objects.TRectangle_Properties
  Distinguishes primitive properties, including StyleName, from StyleLookup consumers.
- Embarcadero, StyleLookup documentation (inherited TStyledControl behavior):
  https://docwiki.embarcadero.com/Libraries/XE5/en/FMX.StdCtrls.TButton.StyleLookup
  Explains selecting resources and the importance of StyleBook availability/lifetime.
- Embarcadero, TCornerButton properties:
  https://docwiki.embarcadero.com/Libraries/Athens/en/FMX.StdCtrls.TCornerButton_Properties
  Search-index content was available, but the direct page intermittently returned 403.

Some DocWiki pages could not be fetched directly. Do not use this reference list as
proof that a particular generated resource, event signature or target application
was loaded or compiled. That validation must occur on the actual Delphi environment.

## Dashboard HTML preview

The public test input at `docs/ui-dashboard.html` requests these resources at runtime;
the repository does not contain local copies of them:

- [Inter via Google Fonts](https://fonts.google.com/specimen/Inter)
- [Material Symbols via Google Fonts](https://fonts.google.com/icons)
- [Tailwind CSS v3 Play CDN](https://v3.tailwindcss.com/docs/installation/play-cdn)

The screenshot gallery is historical result material. Model names and durations come
from the local experiment notes, not a repeatable benchmark suite.
