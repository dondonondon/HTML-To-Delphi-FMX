# HTML-FMX V2 healthcare study website

An English static case-study website based on the 26-slide English presentation and the author's recorded experiment. No build step, package installation, backend, external font, or CDN is required.

## Preview

Open `index.html` directly in a browser. Alternatively, serve this directory with any static web server. From this directory, with Python installed:

```powershell
python -m http.server 8080 --bind 127.0.0.1
```

Then open `http://127.0.0.1:8080`.

## Publish

Upload the contents of this directory to the desired website directory. Keep `assets/`, `styles.css`, and `script.js` beside `index.html`. Bundled asset and download links are relative, so the site works at a domain root or in a subdirectory. The closing section also links to the hosted study, source archive, and Android demo APK:

- Study and prompts: https://docs.blangkon.net/htmltofmx/v2/
- Source code archive: https://docs.blangkon.net/htmltofmx/files/sources/source-code.v.2.0.0.rar
- Android demo APK: https://docs.blangkon.net/htmltofmx/files/HTMLToFMX.apk

The site includes the original wireframe, eight runtime/Designer screenshots, the V1 NovaPOS reference, the English PowerPoint deck, and a text prompt guide. Publication and domain configuration are not part of this local build.

## Files and editing

- `index.html`: complete English content, timings, and refined prompt templates.
- `styles.css`: responsive layouts and print styling.
- `script.js`: mobile menu, screenshot-view switch, image viewer, and copy buttons.
- `assets/images/`: original experiment images copied without modification.
- `assets/downloads/`: English PPTX and a plain-text prompt guide.

If a prompt changes, update its text in `index.html` and the corresponding section in `assets/downloads/healthcare-prompt-guide.txt`. If the presentation changes, replace the bundled English PPTX.

The core article, screenshot links, prompt text, and downloads remain usable without JavaScript. Screenshot labels remain as captured in the original experiment.

## Study boundaries

The approximately 90% hierarchy similarity is the author's observational estimate. Timings are specific to this experiment and include the follow-up card/dummy-data work. Method 4's additional DESIGN.md instruction is a proposed refinement, without newly tested results. No API, device, or performance acceptance is implied.
