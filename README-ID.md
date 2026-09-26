# Skill HTML ke Delphi FMX

Tiga skill untuk membantu coding agent memetakan HTML/CSS menjadi UI Delphi FireMonkey yang native dan dapat diedit di designer. Skill ini berisi instruksi dan contoh, bukan transpiler HTML otomatis. Hasilnya tetap perlu diperiksa pada project dan toolchain Delphi tujuan.

[English](README.md) · [Prompt siap pakai](PROMPTS.md) · [Referensi](SOURCES.md)

## Isi skill

| Skill | Kegunaan | Hasil |
| --- | --- | --- |
| [`html-to-fmx-mapping`](.agents/skills/html-to-fmx-mapping/SKILL.md) | Merencanakan region halaman, section, card, grid tetap, dan daftar data | Peta komponen Markdown |
| [`css-to-fmx-style`](.agents/skills/css-to-fmx-style/SKILL.md) | Memetakan peran CSS ke resource style FMX native | `.style` dan dokumen mapping style |
| [`html-to-fmx`](.agents/skills/html-to-fmx/SKILL.md) | Mengimplementasikan halaman HTML sebagai UI FMX native | Pasangan `.fmx`/`.pas`, frame card reusable, integrasi style, dan mapping UI |

`html-to-fmx` menggunakan dua skill lainnya dalam satu alur kerja. Simpan ketiga folder skill bersama. UI yang tetap dibuat design-time di `.fmx`; item daftar yang mengikuti data menggunakan card `TListBoxItem -> TFrame`. Agent harus memeriksa project Delphi tujuan dan melaporkan validasi yang benar-benar dijalankan.

## Pakai di Codex

Codex mencari `.agents/skills` dari direktori kerja sampai root repository. Buka repo ini atau subfoldernya sebagai direktori kerja Codex, lalu pilih skill lewat `/skills` atau sebut langsung `$html-to-fmx`. Untuk project lain, salin **ketiga** folder dari `.agents/skills/` ke `.agents/skills/` pada project tersebut, lalu jalankan Codex dari project tujuan. Jika skill baru belum muncul, mulai ulang sesi Codex. Lihat [dokumentasi resmi skill](https://learn.chatgpt.com/docs/build-skills).

Contoh dari folder repo ini di PowerShell:

```powershell
$skillDest = 'D:\Path\Ke\ProjectDelphi\.agents\skills'
New-Item -ItemType Directory -Force -Path $skillDest | Out-Null
Copy-Item -Path .\.agents\skills\* -Destination $skillDest -Recurse -Force
```

Contoh setelah skill dipasang pada project Delphi:

```text
$html-to-fmx

Konversi docs/ui-dashboard.html menjadi frame dashboard FMX native.
Periksa versi Delphi, frame, StyleBook, dan aset pada project tujuan.
Simpan mapping UI dan style di docs/fmx-mapping/ dalam project tujuan.
Pertahankan section dan kontrol tetap agar editable di designer .fmx;
gunakan card frame reusable untuk transaksi yang jumlahnya berubah.
Build dan periksa hasil jika toolchain tersedia. Laporkan pemeriksaan
yang tidak dapat dijalankan.
```

Halaman uji yang tersedia di repo ini adalah [`docs/ui-dashboard.html`](docs/ui-dashboard.html). Salin file ini ke project tujuan atau ganti path-nya pada prompt. Path output konversi mengikuti project Delphi tujuan. Contoh tugas terpisah ada di [PROMPTS.md](PROMPTS.md).

## Percobaan dashboard

Input pengujian adalah halaman HTML dashboard NovaPOS. Berikut tampilannya saat dibuka di browser:

![Tampilan dashboard HTML di browser](docs/result/UI-HTML.png)

Arsip hasil berisi screenshot Structure/designer RAD Studio, tampilan awal aplikasi saat run, serta tampilan saat run setelah dirapikan. Hasil GPT pada kolom setelah perapian menggunakan GPT-6 Sol High. Hasil DeepSeek adalah **pure DeepSeek dengan harness Codex** dan tidak memiliki gambar setelah perapian oleh GPT-6 Sol High. Gambar ini mencatat percobaan individual, bukan bukti kesetaraan piksel, cakupan perangkat, atau benchmark model yang terkontrol.

| Percobaan | Durasi dalam catatan | Struktur design time | Run awal | Setelah dirapikan |
| --- | ---: | --- | --- | --- |
| GPT-5.6 Terra Light | 7m 21s | [Lihat](docs/result/image-design-time/SSDT-GPT-5.6%20Terra%20Light.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-5.6%20Terra%20Light.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-5.6%20Terra%20Light.png) |
| GPT-5.6 Terra Medium | 12m 42s | [Lihat](docs/result/image-design-time/SSDT-GPT-5.6%20Terra%20Medium.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-5.6%20Terra%20Medium.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-5.6%20Terra%20Medium.png) |
| GPT-5.6 Terra High | 13m 44s | [Lihat](docs/result/image-design-time/SSDT-GPT-5.6%20Terra%20High.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-5.6%20Terra%20High.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-5.6%20Terra%20High.png) |
| GPT-6 Luna High | 21m 34s | [Lihat](docs/result/image-design-time/SSDT-GPT-6%20Luna%20High.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-6%20Luna%20High.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-6%20Luna%20High.png) |
| GPT-6 Sol Light | 5m 34s | [Lihat](docs/result/image-design-time/SSDT-GPT-6%20Sol%20Light.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-6%20Sol%20Light.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-6%20Sol%20Light.png) |
| GPT-6 Sol Medium | 13m 57s | [Lihat](docs/result/image-design-time/SSDT-GPT-6%20Sol%20Medium.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-6%20Sol%20Medium.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-6%20Sol%20Medium.png) |
| GPT-6 Astra Light | 9m 48s | [Lihat](docs/result/image-design-time/SSDT-GPT-6%20Astra%20Light.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-6%20Astra%20Light.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-6%20Astra%20Light.png) |
| GPT-6 Astra Medium | 12m 52s | [Lihat](docs/result/image-design-time/SSDT-GPT-6%20Astra%20Medium.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-6%20Astra%20Medium.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-6%20Astra%20Medium.png) |
| DeepSeek V4 Pro High | 36m 29s | [Lihat](docs/result/image-design-time/SSDT-Deepseek-V4-Pro%20High.png) | [Lihat](docs/result/image-run/before-enhance/SS-Deepseek-v4-Pro%20High.png) | Pure DeepSeek; tidak ada gambar hasil perapian |
| DeepSeek V4.1 Flash High | 24m 30s | [Lihat](docs/result/image-design-time/SSDT-Deepseek-V4.1-Flash%20High.png) | [Lihat](docs/result/image-run/before-enhance/SS-Deepseek-v4.1-Flash%20High.png) | Pure DeepSeek; tidak ada gambar hasil perapian |

Contoh dari percobaan GPT-6 Sol Medium:

| Struktur designer | Run awal | Run setelah dirapikan GPT-6 Sol High |
| --- | --- | --- |
| <img src="docs/result/image-design-time/SSDT-GPT-6%20Sol%20Medium.png" width="260" alt="Designer RAD Studio dan struktur komponen"> | <img src="docs/result/image-run/before-enhance/SS-GPT-6%20Sol%20Medium.png" width="240" alt="Tampilan awal aplikasi saat run"> | <img src="docs/result/image-run/after-enhance/SSAF-GPT-6%20Sol%20Medium.png" width="240" alt="Tampilan aplikasi setelah dirapikan"> |

Screenshot design time memperlihatkan hierarki frame yang dapat diedit di RAD Studio. Screenshot run memperlihatkan satu hasil desktop untuk setiap percobaan sesuai tahap pada nama folder. Preview HTML memuat Inter, Material Symbols, dan Tailwind dari layanan eksternal, sehingga tampilan yang dimaksud memerlukan akses jaringan saat dibuka lokal.

## Isi repository

```text
.agents/skills/          Tiga folder skill yang portabel
docs/ui-dashboard.html   Input HTML pengujian
docs/result/             Screenshot browser, designer, dan aplikasi saat run
PROMPTS.md               Contoh prompt siap pakai
README.md                Dokumentasi bahasa Inggris
SOURCES.md               Referensi dokumentasi dan pihak ketiga
```

Project aplikasi dan dokumen hasil konversi tidak termasuk paket skill publik ini. Panduan kontribusi ada di [CONTRIBUTING.md](CONTRIBUTING.md); lisensi repository ada di [LICENSE](LICENSE). Font dan resource CDN eksternal yang dipakai preview HTML memiliki ketentuan masing-masing dan tidak dibundel di repo ini.
