# Prompt siap pakai

Gunakan prompt ini di Codex setelah menaruh ketiga folder skill di `.agents/skills/` project tujuan. Sesuaikan path output dengan struktur project Delphi Anda. `$nama-skill` adalah penyebutan skill di prompt Codex, bukan perintah PowerShell.

## 1. Buat mapping tanpa implementasi

```text
$html-to-fmx-mapping

Source: docs/ui-dashboard.html
Target project: periksa project Delphi FMX saat ini.
Output: docs/fmx-mapping/UI_CONVERSION_MAPPING.md

Petakan region halaman, section dan card yang berdiri sendiri, grid tetap,
daftar record yang jumlahnya berubah, serta interaksi. Sertakan hierarki FMX
dan kepemilikan design-time/runtime. Hasilkan dokumen mapping saja.
```

## 2. Konversi styling CSS saja

```text
$css-to-fmx-style

Source: CSS dan visual token yang dipakai docs/ui-dashboard.html
Output style: assets/styles/Dashboard.style
Output mapping: docs/fmx-mapping/FMX_STYLE_MAPPING.md

Periksa versi Delphi dan resource StyleBook yang sudah ada. Petakan setiap
peran CSS yang dipakai ke kontrol dan style FMX. Pertahankan style existing
yang kompatibel. Laporkan perilaku CSS tanpa padanan langsung di FMX dan
validasi yang benar-benar dijalankan. Jangan ubah .pas, .fmx, .dpr, atau
.dproj aplikasi.
```

## 3. Konversi halaman lengkap menjadi FMX native

```text
$html-to-fmx

Source: docs/ui-dashboard.html
Target page: tentukan path frame sesuai struktur project Delphi saat ini.
Output mapping: docs/fmx-mapping/
Output style: gunakan lokasi style yang sudah berlaku di project.

Periksa project, versi Delphi, aset, dan StyleBook existing. Jalankan alur
html-to-fmx-mapping lalu css-to-fmx-style sesuai instruksi skill ini.
Implementasikan section dan kontrol tetap di resource .fmx design-time.
Gunakan satu TFrame card reusable untuk record transaksi yang berubah.
Integrasikan style ke host, compile jika memungkinkan, periksa hasil aktual,
dan pisahkan pemeriksaan yang selesai dari yang belum dapat dijalankan.
```

## 4. Rapikan hasil konversi yang sudah ada

```text
$html-to-fmx

Bandingkan dashboard FMX saat ini dengan docs/ui-dashboard.html dan
screenshot acuan browser docs/result/UI-HTML.png. Periksa hierarki .fmx,
card frame, handler Pascal, aset, mapping style, dan integrasi StyleBook.
Perbaiki hanya perbedaan layout atau interaksi yang terbukti. Periksa
struktur designer dan tampilan aplikasi saat run jika tersedia. Laporkan
perbedaan yang tersisa dan bukti setiap tahap validasi.
```

Screenshot di `docs/result/` adalah hasil percobaan sebelumnya, bukan pengganti pemeriksaan pada project baru. Bila skill dipasang di project lain, salin HTML uji ke sana atau ganti `docs/ui-dashboard.html` dengan path source yang diinginkan.
