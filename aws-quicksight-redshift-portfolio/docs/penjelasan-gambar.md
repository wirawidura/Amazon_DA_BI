# Penjelasan Mendalam Setiap Gambar

Dokumen sumber berisi delapan halaman. Penjelasan di bawah membedakan **yang terlihat pada screenshot** dengan **interpretasi teknis yang wajar**. Detail yang tidak terlihat tidak dianggap sebagai fakta proyek.

## Gambar 1 — Pengujian SQL dan koneksi Redshift ke QuickSight

### A. Testing dan debugging query di Amazon Redshift
Screenshot pertama memperlihatkan editor/query SQL dan hasil eksekusi. Caption menyatakan bahwa query baru diuji dan di-debug, termasuk SQL tuning.

**Tujuan:** memastikan query yang menjadi sumber laporan menghasilkan data yang benar, konsisten, dan cukup efisien untuk digunakan dashboard.

**Alur kerja yang relevan:**
1. Jalankan query dalam lingkungan pengembangan.
2. Periksa error sintaks, nama tabel/kolom, tipe data, filter, dan kondisi join.
3. Validasi hasil terhadap sampel atau laporan pembanding yang dipercaya.
4. Tinjau potensi duplikasi akibat join, nilai NULL, rentang tanggal, dan agregasi.
5. Jika performa menjadi masalah, periksa query plan dan ukuran data yang dipindai; ubah query hanya setelah hasilnya divalidasi ulang.

**Nilai bisnis:** mengurangi risiko dashboard menampilkan angka salah atau lambat.

**Yang belum dapat dipastikan dari gambar:** teks query tidak cukup terbaca untuk merekonstruksi SQL asli; tidak ada angka runtime atau hasil tuning sebelum/sesudah.

### B. Menghubungkan QuickSight ke Redshift
Screenshot kedua memperlihatkan pemilihan koneksi/sumber data untuk Redshift.

**Tujuan:** membuat jalur data dari warehouse ke lapisan BI dengan cluster/database yang benar.

**Pemeriksaan teknis:** endpoint dan database yang benar, jaringan yang mengizinkan koneksi, kredensial yang aman, izin baca minimum yang diperlukan, serta akses ke schema dan tabel yang dipakai.

**Validasi setelah koneksi:** jalankan query uji kecil, pastikan kolom dan tipe data terbaca benar, lalu cocokkan beberapa nilai dengan Redshift.

**Nilai bisnis:** menyediakan akses analitik tanpa perlu menyalin data secara manual setiap kali laporan dibuka.

**Batas bukti:** screenshot tidak mengungkap hostname, metode autentikasi, nama cluster, atau konfigurasi jaringan. Jangan menaruh informasi tersebut di repository publik.

---

## Gambar 2 — Semantic model dengan custom SQL dan KPI dashboard

### A. Membuat semantic model/dataset
Screenshot atas diberi caption pembuatan semantic model atau tabel baru di QuickSight menggunakan custom SQL.

**Makna:** custom SQL dapat membentuk dataset analitik dengan memilih kolom yang dibutuhkan, menerapkan filter, menggabungkan tabel, atau mengagregasi data sebelum dipakai visualisasi.

**Praktik yang disarankan:**
- Tetapkan grain dataset, misalnya satu baris per item penerimaan atau per kombinasi tanggal dan kategori. Grain sebenarnya harus dikonfirmasi.
- Gunakan nama kolom yang mudah dipahami pengguna bisnis.
- Definisikan metrik secara konsisten dan dokumentasikan rumusnya.
- Hindari membawa kolom sensitif yang tidak diperlukan.
- Uji apakah join meningkatkan jumlah baris secara tidak sengaja.

**Manfaat:** dashboard memakai struktur data yang lebih stabil dan lebih mudah dipahami daripada query ad hoc yang berbeda-beda.

### B. Dashboard KPI
Screenshot bawah memperlihatkan dashboard bertema **Hazmat Item Received Monitoring Dashboard**. Terlihat tabel terperinci dan beberapa grafik tren.

**Cara membaca secara umum:**
- Tabel memberi rincian operasional untuk pemeriksaan record.
- Grafik garis membantu melihat perubahan nilai dari waktu ke waktu.
- Kombinasi ringkasan dan rincian memungkinkan pengguna melihat pola lalu menelusuri data pendukung.

**Pertanyaan bisnis yang dapat didukung, bergantung pada definisi metrik:** apakah volume penerimaan berubah, kapan terjadi lonjakan/penurunan, dan detail mana yang perlu diperiksa lebih lanjut.

**Catatan:** nama metrik, satuan, periode, dan rumus persisnya tidak dapat dipastikan dari screenshot. Jangan menebak angka atau definisi KPI.

---

## Gambar 3 — Data governance

Screenshot halaman ini menampilkan konfigurasi QuickSight yang diberi caption **Managed data governance**.

**Tujuan governance:** memastikan dataset dapat dipakai oleh orang yang tepat, dengan definisi dan penggunaan data yang konsisten serta risiko paparan data yang terkendali.

**Area yang layak didokumentasikan dalam proyek:**
1. **Akses:** siapa yang dapat melihat, mengedit, atau membagikan dataset dan dashboard.
2. **Least privilege:** hak akses hanya sebatas kebutuhan tugas.
3. **Definisi metrik:** definisi KPI, satuan, grain, filter, dan aturan pengecualian.
4. **Kualitas data:** pemeriksaan duplikasi, NULL, rentang tanggal, dan rekonsiliasi total.
5. **Privasi:** sembunyikan atau batasi data pegawai/sensitif sesuai kebijakan.
6. **Ownership:** pemilik dataset, kontak dukungan, dan proses perubahan.
7. **Audit dan perubahan:** catat perubahan definisi, sumber, serta akses sesuai kemampuan platform dan kebijakan organisasi.

**Nilai bisnis:** mengurangi perbedaan angka antarlaporan dan membantu menjaga data tetap digunakan sesuai otorisasi.

**Batas bukti:** gambar tidak cukup terbaca untuk menyebutkan pengaturan keamanan spesifik yang dipilih. Daftar di atas adalah kerangka governance yang disarankan, bukan klaim konfigurasi aktual.

---

## Gambar 4 — Jadwal refresh dan awal migrasi data source

### A. Membuat refresh schedule
Screenshot atas memperlihatkan dialog penjadwalan refresh.

**Tujuan:** memperbarui dataset agar laporan mengikuti perubahan data sumber tanpa proses manual berulang.

**Keputusan yang perlu dibuat:** seberapa sering sumber berubah, kapan dashboard dibutuhkan, durasi pemrosesan, serta toleransi keterlambatan data.

**Validasi operasional:**
- Pastikan jadwal dan zona waktu sesuai kebutuhan.
- Periksa status refresh terakhir dan kegagalan.
- Bandingkan jumlah baris/totals setelah refresh.
- Dokumentasikan siapa yang menangani kegagalan.
- Bedakan perilaku refresh untuk dataset SPICE dan query langsung, sesuai mode yang benar-benar digunakan.

**Batas bukti:** screenshot tidak menyatakan frekuensi refresh atau mode dataset secara pasti.

### B. Migrasi data source
Screenshot bawah menunjukkan proses migrasi/penggantian sumber data dalam analisis QuickSight.

**Tujuan:** memindahkan analisis ke sumber data lain atau koneksi baru tanpa merusak dashboard.

**Risiko utama:** kolom berubah nama, tipe data berubah, field kalkulasi gagal, filter tidak cocok, atau total berubah akibat perbedaan grain dan isi data.

**Praktik aman:** lakukan mapping field, cek tipe data, uji visual dan filter, rekonsiliasi metrik penting, lalu publikasikan setelah disetujui.

---

## Gambar 5 — Mapping field setelah migrasi

Screenshot menunjukkan layar **Update field mapping** dengan pasangan field sumber dan field tujuan.

**Apa yang dilakukan:** mencocokkan field dari sumber lama dengan field yang sesuai pada sumber baru. Mapping yang benar membantu QuickSight mempertahankan keterkaitan field dengan visualisasi dan kalkulasi yang sudah ada.

**Checklist:**
- Nama yang sama belum tentu memiliki makna atau satuan yang sama.
- Pastikan tipe data kompatibel, terutama tanggal, angka, dan teks.
- Pastikan field kategori tidak tertukar dengan field nilai.
- Periksa calculated fields, filter, sort, parameter, dan level agregasi.
- Setelah mapping, buka setiap visual dan bandingkan nilai dengan baseline.
- Simpan bukti pengujian dan siapkan rollback bila hasil berbeda.

**Hasil yang diharapkan:** dashboard tetap berfungsi dengan sumber baru dan tidak mengalami perubahan metrik yang tidak disengaja.

**Batas bukti:** nama field dan detail pemetaan pada screenshot tidak cukup terbaca untuk dituliskan sebagai mapping spesifik.

---

## Gambar 6 — Supply Chain Received Inventory for Hazmat Items

Screenshot menampilkan dashboard **Hazmat Item Received Monitoring Dashboard**, dengan tabel operasional dan beberapa grafik tren.

**Tujuan laporan:** memantau penerimaan inventory untuk item Hazmat (hazardous materials) dan membantu pengguna mengidentifikasi pola pada data penerimaan.

**Komponen visual yang terlihat:**
- Tabel bagian atas untuk ringkasan/rincian data.
- Beberapa grafik garis untuk membandingkan pola tren.
- Tabel detail di bagian bawah untuk inspeksi lebih lanjut.

**Cara memakai laporan:**
1. Mulai dari ringkasan untuk memahami keadaan umum.
2. Periksa grafik untuk menemukan perubahan atau pola yang tidak biasa.
3. Telusuri baris detail yang terkait.
4. Validasi anomali dengan sumber operasional sebelum mengambil tindakan.

**Contoh pertanyaan analitik:** apakah jumlah penerimaan berubah sepanjang periode; apakah kategori tertentu menunjukkan tren berbeda; detail record mana yang menjelaskan lonjakan.

**Penting:** screenshot tidak memberikan rumus KPI, rentang waktu lengkap, ambang batas, atau kesimpulan operasional. Pertanyaan di atas adalah contoh penggunaan, bukan temuan dari data.

---

## Gambar 7 — Supply Chain Received Inventory for ATAC Items

Screenshot dashboard bertema **ATAC ASIN**. Terlihat beberapa angka ringkasan, grafik tren area, dan tabel data.

**Tujuan laporan:** memberikan ringkasan dan detail untuk pemantauan inventory received yang terkait dengan item ATAC.

**Komponen yang terlihat:**
- Kartu/angka ringkasan di bagian atas.
- Grafik area/garis untuk perubahan dari waktu ke waktu.
- Tabel di bawah grafik untuk meninjau detail terkait.

**Alur interpretasi:** gunakan ringkasan untuk orientasi, grafik untuk melihat arah dan variasi tren, lalu tabel untuk menginvestigasi detail. Pastikan filter, periode, dan satuan dipahami sebelum membandingkan angka.

**Batas bukti:** angka yang terlihat di screenshot tidak cukup untuk menjelaskan arti setiap metrik secara akurat. Istilah ASIN tampak pada tampilan, tetapi definisi bisnis ATAC dan rumus KPI harus dikonfirmasi dari pemilik proses atau dokumentasi sumber.

**Nilai bisnis:** menyatukan indikator ringkas dan data detail dalam satu tampilan untuk mendukung pemantauan supply chain.

---

## Gambar 8 — Employee compliance hours dan PPR hours monitoring

Halaman ini memperlihatkan dua tampilan dashboard.

### A. Employee compliance hours
Dashboard atas menggunakan matriks/tabel dengan pewarnaan hijau dan merah untuk membedakan status atau nilai.

**Interpretasi visual:** pewarnaan kondisional dapat membantu pengguna mengenali area yang perlu diperhatikan tanpa membaca setiap nilai satu per satu.

**Penggunaan yang mungkin:** memantau jam kepatuhan per pegawai atau periode, membandingkan status antarindividu, dan menelusuri nilai yang perlu ditinjau. Makna pasti warna hijau/merah harus mengikuti legenda dan aturan bisnis asli.

**Pertimbangan privasi:** data pegawai dapat bersifat sensitif. Pastikan hak akses, pembatasan distribusi, dan penyamaran identitas diterapkan sebelum dashboard dibagikan secara luas.

### B. PPR hours monitoring dashboard
Dashboard bawah memperlihatkan tabel, visual lingkaran/ring, dan grafik proporsi.

**Tujuan umum:** menyajikan pemantauan jam PPR dengan kombinasi tabel dan ringkasan visual.

**Cara membaca:** tabel mendukung pemeriksaan detail, sedangkan visual ringkasan membantu membandingkan komposisi atau proporsi. Makna kategori, angka, dan target tidak boleh diasumsikan tanpa definisi sumber.

**Nilai bisnis:** membantu pemantauan kepatuhan dan jam kerja melalui satu laporan terstruktur, dengan syarat definisi, akses, dan kualitas data terjaga.

---

## Ringkasan alur end-to-end

1. **Query layer:** uji dan validasi SQL di Redshift.
2. **Connectivity:** hubungkan QuickSight ke sumber yang benar.
3. **Semantic layer:** bentuk dataset dengan custom SQL dan definisi field yang konsisten.
4. **Visualization:** bangun dashboard KPI, tabel, dan tren.
5. **Governance:** kelola akses, definisi, dan perlindungan data.
6. **Operations:** jadwalkan refresh dan pantau keberhasilannya.
7. **Change management:** migrasikan sumber data, mapping field, lalu regresi-test visual.
8. **Business reporting:** sajikan laporan inventory Hazmat, inventory ATAC, dan employee compliance/PPR hours.

## Narasi singkat untuk wawancara

“Saya mendokumentasikan alur BI dari validasi query SQL di Amazon Redshift, integrasi ke Amazon QuickSight, pembentukan dataset/semantic layer menggunakan custom SQL, hingga pembuatan dashboard KPI. Saya juga meninjau aspek governance, penjadwalan refresh, dan proses migrasi data source termasuk field mapping. Contoh output yang didokumentasikan mencakup laporan penerimaan inventory Hazmat dan ATAC serta employee compliance/PPR hours. Untuk menjaga akurasi, definisi KPI dan detail konfigurasi yang tidak tampak pada bukti proyek perlu dikonfirmasi sebelum dinyatakan sebagai implementasi spesifik.”
