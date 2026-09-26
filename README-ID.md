# HTML ke Delphi FMX

![Delphi FMX](https://img.shields.io/badge/Delphi-FireMonkey-E62431?style=flat-square&logo=embarcadero&logoColor=white)
![Agent Skills](https://img.shields.io/badge/Agent%20Skills-3-1F6FEB?style=flat-square)
![Workflow](https://img.shields.io/badge/Workflow-Map%20%7C%20Style%20%7C%20Convert-0E8A16?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-F59E0B?style=flat-square)

[English](README.md) | Bahasa Indonesia

Ubah desain HTML/CSS menjadi **UI Delphi FireMonkey native yang dapat diedit** dengan tiga agent skill. Alurnya memetakan hierarki komponen, membuat resource style FMX, lalu mengimplementasikan frame `.fmx`/`.pas` pada project Delphi yang sudah ada.

Repository ini berisi instruksi skill dan dokumentasi percobaan dashboard. Skill bukan transpiler otomatis atau aplikasi Delphi lengkap. Implementasi dan validasi akhir mengikuti project serta toolchain Delphi tujuan.

## Skill yang tersedia

| Skill | Tanggung jawab | Hasil utama |
| --- | --- | --- |
| [`html-to-fmx-mapping`](.agents/skills/html-to-fmx-mapping/SKILL.md) | Memetakan region HTML ke section, card, grid tetap, dan daftar data FMX | Hierarki komponen dalam Markdown |
| [`css-to-fmx-style`](.agents/skills/css-to-fmx-style/SKILL.md) | Memetakan peran CSS ke resource style FMX native yang kompatibel | `.style` dan mapping style |
| [`html-to-fmx`](.agents/skills/html-to-fmx/SKILL.md) | Membangun UI FMX yang dapat diedit dan mengintegrasikan style | Pasangan `.fmx`/`.pas`, card reusable, dan mapping |

`html-to-fmx` menjalankan alur mapping dan styling dari dua skill lainnya. Simpan **ketiga folder skill bersama**. Struktur visual yang tetap dibuat di resource `.fmx` pada design time; record yang jumlahnya berubah menggunakan card `TFrame` reusable di dalam `TListBoxItem`.

## Mulai menggunakan

Codex mencari skill repository di `.agents/skills` dari direktori kerja sampai root repository. Buka repo ini di Codex untuk melihat skill, atau salin ketiga folder skill ke `.agents/skills/` pada project Delphi tujuan. Lihat [dokumentasi resmi skill Codex](https://learn.chatgpt.com/docs/build-skills).

Contoh menyalin dari folder repository ini melalui PowerShell:

```powershell
$skillDest = 'D:\Path\Ke\ProjectDelphi\.agents\skills'
New-Item -ItemType Directory -Force -Path $skillDest | Out-Null
Copy-Item -Path .\.agents\skills\* -Destination $skillDest -Recurse -Force
```

Jalankan Codex dari project tujuan, lalu panggil `$html-to-fmx`, `$html-to-fmx-mapping`, atau `$css-to-fmx-style`. Jika skill baru belum muncul di `/skills`, mulai ulang sesi Codex. Untuk mencoba dashboard dalam repo ini, salin [`docs/ui-dashboard.html`](docs/ui-dashboard.html) ke project tujuan atau gunakan path sebenarnya pada prompt.

```text
$html-to-fmx

Konversi docs/ui-dashboard.html menjadi frame dashboard FMX native.
Periksa project Delphi dan StyleBook yang sudah ada. Simpan mapping UI
dan style di docs/fmx-mapping/. Pertahankan kontrol tetap agar dapat
diedit di .fmx dan gunakan card TFrame reusable untuk record transaksi
yang jumlahnya berubah. Build dan periksa hasil jika toolchain tersedia.
```

[PROMPTS.md](PROMPTS.md) menyediakan prompt bahasa Inggris untuk mapping, styling, konversi penuh, dan perapian. Path output dalam contoh tersebut berada di **project tujuan**, bukan dalam repository skill ini.

## Ikon dan cakupan FMX native

Ikon dari HTML sumber sudah cukup sebagai titik awal. Agar lebih sesuai dengan tampilan aplikasi Anda, saya menyarankan memilih atau mencari ikon sendiri. Jika project Delphi Anda sudah menggunakan Skia, ikon juga dapat diganti dengan SVG melalui integrasi tersebut. Target repository ini adalah **pure Delphi FMX**: alur konversinya menggunakan komponen FMX native dan tidak mensyaratkan Skia.

## Percobaan dashboard

UI dashboard NovaPOS dibuat menggunakan **Google Stitch**, lalu diekspor menjadi kode HTML. Hasil ekspor yang digunakan sebagai input pengujian adalah [`docs/ui-dashboard.html`](docs/ui-dashboard.html). Berikut tampilan acuannya di browser:

<img src="docs/result/UI-HTML.png" width="320" alt="Dashboard NovaPOS dari source HTML saat dibuka di browser">

Contoh berikut memperlihatkan struktur designer GPT-6 Sol Medium dan tampilan aplikasi sebelum serta sesudah dirapikan dengan GPT-6 Sol High:

| Designer RAD Studio | Run awal | Run setelah dirapikan |
| --- | --- | --- |
| <img src="docs/result/image-design-time/SSDT-GPT-6%20Sol%20Medium.png" width="260" alt="Frame dashboard dan hierarki komponen yang dapat diedit di RAD Studio"> | <img src="docs/result/image-run/before-enhance/SS-GPT-6%20Sol%20Medium.png" width="230" alt="Tampilan awal aplikasi hasil GPT-6 Sol Medium"> | <img src="docs/result/image-run/after-enhance/SSAF-GPT-6%20Sol%20Medium.png" width="230" alt="Tampilan aplikasi setelah dirapikan GPT-6 Sol High"> |

### Seluruh percobaan

Arsip desktop berisi 10 screenshot designer, 10 screenshot run awal, dan 8 screenshot run setelah perapian. Delapan hasil GPT yang dirapikan menggunakan GPT-6 Sol High. Hasil DeepSeek adalah **pure DeepSeek dengan harness Codex**; keduanya tidak memiliki gambar hasil perapian oleh GPT.

| Percobaan | Durasi tercatat | Struktur designer | Run awal | Setelah dirapikan |
| --- | ---: | --- | --- | --- |
| GPT-5.6 Terra Light | 7m 21s | [Lihat](docs/result/image-design-time/SSDT-GPT-5.6%20Terra%20Light.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-5.6%20Terra%20Light.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-5.6%20Terra%20Light.png) |
| GPT-5.6 Terra Medium | 12m 42s | [Lihat](docs/result/image-design-time/SSDT-GPT-5.6%20Terra%20Medium.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-5.6%20Terra%20Medium.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-5.6%20Terra%20Medium.png) |
| GPT-5.6 Terra High | 13m 44s | [Lihat](docs/result/image-design-time/SSDT-GPT-5.6%20Terra%20High.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-5.6%20Terra%20High.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-5.6%20Terra%20High.png) |
| GPT-6 Luna High | 21m 34s | [Lihat](docs/result/image-design-time/SSDT-GPT-6%20Luna%20High.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-6%20Luna%20High.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-6%20Luna%20High.png) |
| GPT-6 Sol Light | 5m 34s | [Lihat](docs/result/image-design-time/SSDT-GPT-6%20Sol%20Light.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-6%20Sol%20Light.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-6%20Sol%20Light.png) |
| GPT-6 Sol Medium | 13m 57s | [Lihat](docs/result/image-design-time/SSDT-GPT-6%20Sol%20Medium.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-6%20Sol%20Medium.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-6%20Sol%20Medium.png) |
| GPT-6 Astra Light | 9m 48s | [Lihat](docs/result/image-design-time/SSDT-GPT-6%20Astra%20Light.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-6%20Astra%20Light.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-6%20Astra%20Light.png) |
| GPT-6 Astra Medium | 12m 52s | [Lihat](docs/result/image-design-time/SSDT-GPT-6%20Astra%20Medium.png) | [Lihat](docs/result/image-run/before-enhance/SS-GPT-6%20Astra%20Medium.png) | [Lihat](docs/result/image-run/after-enhance/SSAF-GPT-6%20Astra%20Medium.png) |
| DeepSeek V4 Pro High | 36m 29s | [Lihat](docs/result/image-design-time/SSDT-Deepseek-V4-Pro%20High.png) | [Lihat](docs/result/image-run/before-enhance/SS-Deepseek-v4-Pro%20High.png) | Pure DeepSeek |
| DeepSeek V4.1 Flash High | 24m 30s | [Lihat](docs/result/image-design-time/SSDT-Deepseek-V4.1-Flash%20High.png) | [Lihat](docs/result/image-run/before-enhance/SS-Deepseek-v4.1-Flash%20High.png) | Pure DeepSeek |

### Hasil run Android

Arsip ini juga berisi 10 screenshot run Android, satu untuk setiap percobaan setelah alur akhirnya selesai. Varian GPT telah dirapikan dengan GPT-6 Sol High; dua screenshot DeepSeek tetap merupakan hasil murni DeepSeek meskipun nama foldernya `mobile-after-enhance`.

| Hasil visual terbaik: GPT-6 Astra Light + GPT-6 Sol High | Nilai terbaik: GPT-6 Sol Medium + GPT-6 Sol High |
| --- | --- |
| <img src="docs/result/image-run/mobile-after-enhance/Mobile-GPT-6%20Astra%20Light.jpg" width="260" alt="Hasil run Android GPT-6 Astra Light setelah dirapikan GPT-6 Sol High"> | <img src="docs/result/image-run/mobile-after-enhance/Mobile-GPT-6%20Sol%20Medium.jpg" width="260" alt="Hasil run Android GPT-6 Sol Medium setelah dirapikan GPT-6 Sol High"> |

| Percobaan | Screenshot Android | Percobaan | Screenshot Android |
| --- | --- | --- | --- |
| GPT-5.6 Terra Light | [Lihat](docs/result/image-run/mobile-after-enhance/Mobile-GPT-5.6%20Terra%20Light.jpg) | GPT-5.6 Terra Medium | [Lihat](docs/result/image-run/mobile-after-enhance/Mobile-GPT-5.6%20Terra%20Medium.jpg) |
| GPT-5.6 Terra High | [Lihat](docs/result/image-run/mobile-after-enhance/Mobile-GPT-5.6%20Terra%20High.jpg) | GPT-6 Luna High | [Lihat](docs/result/image-run/mobile-after-enhance/Mobile-GPT-6%20Luna%20High.jpg) |
| GPT-6 Sol Light | [Lihat](docs/result/image-run/mobile-after-enhance/Mobile-GPT-6%20Sol%20Light.jpg) | GPT-6 Sol Medium | [Lihat](docs/result/image-run/mobile-after-enhance/Mobile-GPT-6%20Sol%20Medium.jpg) |
| GPT-6 Astra Light | [Lihat](docs/result/image-run/mobile-after-enhance/Mobile-GPT-6%20Astra%20Light.jpg) | GPT-6 Astra Medium | [Lihat](docs/result/image-run/mobile-after-enhance/Mobile-GPT-6%20Astra%20Medium.jpg) |
| DeepSeek V4 Pro High | [Lihat](docs/result/image-run/mobile-after-enhance/Mobile-Deepseek-V4-Pro%20High.jpg) | DeepSeek V4.1 Flash High | [Lihat](docs/result/image-run/mobile-after-enhance/Mobile-Deepseek-V4.1-Flash%20High.jpg) |

### Catatan waktu dan biaya

Durasi di atas berasal dari catatan tiap percobaan. Biaya DeepSeek berikut dicatat penulis saat peak hours:

| Percobaan | Biaya tercatat |
| --- | ---: |
| DeepSeek V4.1 Flash High | **US$0.34** |
| DeepSeek V4 Pro High | **US$1.74** |

Biaya GPT yang tepat tidak dicatat. Berdasarkan persentase penggunaan Pro 5x, penulis memperkirakan setiap percobaan Astra sekitar **1%** dan percobaan GPT lainnya **di bawah 1%**. Angka tersebut merupakan perkiraan pribadi. Kondisi percobaan berbeda, sehingga hasil ini bukan benchmark kecepatan, biaya, atau kualitas yang terkontrol.

## Kesimpulan penulis

- **Biaya lebih rendah, lebih banyak perapian manual:** DeepSeek V4.1 Flash High cocok sebagai titik awal jika hasilnya akan dirapikan sendiri.
- **Hasil langsung yang kuat:** DeepSeek V4 Pro High memberikan hasil sangat baik, tetapi percobaan saat peak hours lebih mahal dan lebih lama. Penulis memperkirakan biayanya lebih rendah di luar peak hours; perkiraan itu belum diukur dalam percobaan ini.
- **Hasil visual terbaik:** GPT-6 Astra Light yang dilanjutkan dengan perapian GPT-6 Sol High memberikan hasil paling bagus menurut penulis.
- **Nilai terbaik:** Hasil awal GPT-6 Sol Medium sudah bagus dan GPT-6 Sol High membuatnya lebih rapi. Ini adalah pilihan penulis untuk keseimbangan hasil dan biaya. Berdasarkan penggunaan Pro 5x, perapian hasil yang sudah ada tampak lebih murah daripada mengulang konversi dari awal, tetapi biaya GPT yang tepat tidak dicatat.
- **Alternatif lain:** GPT-5.6 Terra yang dilanjutkan dengan perapian GPT-6 Sol High juga memberikan hasil bagus.
- **Struktur designer:** Hierarki komponen yang dihasilkan relatif mirip antarpercobaan.

Pilih **GPT-6 Astra Light → GPT-6 Sol High** jika kualitas visual menjadi prioritas utama. Pilih **GPT-6 Sol Medium → GPT-6 Sol High** untuk keseimbangan biaya dan hasil yang paling baik menurut penulis. **DeepSeek V4 Pro High** juga layak dipertimbangkan di luar peak hours jika biayanya turun sesuai perkiraan.

## Struktur repository

```text
.agents/skills/          Tiga agent skill dan file pendukungnya
docs/ui-dashboard.html   Input HTML pengujian
docs/result/             Screenshot browser, designer, desktop, dan run Android
PROMPTS.md               Prompt siap pakai dalam bahasa Inggris
README.md                Dokumentasi bahasa Inggris
SOURCES.md               Referensi dokumentasi dan pihak ketiga
LICENSE                  Lisensi MIT
CONTRIBUTING.md          Panduan kontribusi
```

## Batas validasi

Screenshot mencatat tampilan designer serta hasil run desktop dan Android tertentu. Gambar tersebut menunjukkan hasil visual dari percobaan itu; gambar tidak memvalidasi konversi baru, perilaku interaksi, berbagai perangkat, atau versi Delphi lain. Setiap penggunaan skill tetap memerlukan pemeriksaan project tujuan, integrasi style, serta validasi build, designer, dan runtime yang tersedia pada toolchain-nya.

Preview HTML memuat Inter, Material Symbols, dan Tailwind dari layanan eksternal. Tampilan yang dimaksud membutuhkan koneksi jaringan saat dibuka secara lokal. Project aplikasi dan dokumen hasil konversi tidak disertakan dalam repository ini.

## Lisensi dan kontribusi

Repository ini menggunakan [Lisensi MIT](LICENSE). Lihat [CONTRIBUTING.md](CONTRIBUTING.md) untuk panduan kontribusi dan [SOURCES.md](SOURCES.md) untuk referensi dokumentasi serta pihak ketiga.
