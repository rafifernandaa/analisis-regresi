# Aplikasi Analisis Data Interaktif 📊

[![Lisensi: MIT](https://img.shields.io/badge/Lisensi-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shiny](https://img.shields.io/badge/Made%20with-Shiny-blue.svg)](https://shiny.posit.co/)

Aplikasi web berbasis R Shiny yang dirancang untuk melakukan analisis data secara interaktif. Pengguna dapat mengunggah dataset mereka sendiri dalam format CSV, melakukan pembersihan data, menjalankan analisis statistik seperti ANOVA, serta menguji asumsi statistik dasar.

![Tangkapan Layar Aplikasi](https://i.imgur.com/gKkQZpT.png) 
*(Anda bisa mengganti link di atas dengan tangkapan layar aplikasi Anda sendiri)*

---

### ✨ Fitur Utama

-   **📤 Unggah Data**: Unggah dataset Anda dengan mudah dalam format `.csv` dengan pilihan encoding.
-   **🧹 Pembersihan Data**: Hapus baris yang mengandung nilai `NA` (missing values) dengan sekali klik.
-   **🔄 Reset Data**: Kembalikan data ke kondisi aslinya setelah proses pembersihan.
-   **📈 Statistik Ringkas**: Dapatkan ringkasan statistik deskriptif dari variabel dependen dan independen.
-   **🔬 Uji ANOVA**: Lakukan analisis varians (ANOVA) untuk melihat pengaruh variabel independen terhadap variabel dependen.
-   **✅ Uji Asumsi**:
    -   **Uji Normalitas**: Menggunakan uji Shapiro-Wilk dan Anderson-Darling.
    -   **Uji Homoskedastisitas**: Menggunakan Levene's Test.
-   **🎨 Visualisasi Data**: Tampilkan data dalam bentuk plot garis atau diagram batang.

---

### 📂 Struktur Proyek

```
/proyek-analisis-data/
├── .gitignore          # File yang diabaikan oleh Git
├── app.R               # Kode utama aplikasi Shiny (UI & Server)
├── data/
│   └── contoh_data.csv # Contoh dataset untuk demo
├── LICENSE             # Lisensi proyek (MIT)
├── README.md           # File dokumentasi ini
└── www/
    └── styles.css      # File CSS untuk kustomisasi tampilan
```

---

### 🚀 Instalasi dan Menjalankan Aplikasi

Untuk menjalankan aplikasi ini di komputer lokal Anda, ikuti langkah-langkah berikut:

**1. Prasyarat:**
-   Pastikan Anda telah menginstal **R** dan **RStudio** di komputer Anda.

**2. Clone Repositori:**
```bash
git clone [https://github.com/nama-anda/proyek-analisis-data.git](https://github.com/nama-anda/proyek-analisis-data.git)
cd proyek-analisis-data
```

**3. Instal Paket yang Dibutuhkan:**
Buka RStudio, lalu jalankan perintah berikut di konsol untuk menginstal semua paket yang diperlukan:

```R
install.packages(c(
  "shiny", "bslib", "shinydashboard", "DT", "dplyr", 
  "ggplot2", "car", "nortest", "readr", "stringr", "shinyWidgets"
))
```

**4. Jalankan Aplikasi:**
-   Buka file `app.R` di RStudio.
-   Klik tombol **"Run App"** yang muncul di bagian atas editor.
-   Atau, jalankan perintah `shiny::runApp()` di konsol R.

---

### 📝 Cara Menggunakan Aplikasi

1.  **Unggah File**: Klik tombol "Browse" atau "Upload CSV File" dan pilih file `.csv` Anda. Anda juga bisa menggunakan file `data/contoh_data.csv` yang sudah disediakan.
2.  **Pembersihan Data**: Jika data Anda memiliki nilai `NA`, klik tombol "Clean Data" untuk menghapusnya.
3.  **Reset Data**: Jika Anda ingin kembali ke data asli, klik "Reset Data".
4.  **Pilih Variabel**: Di sidebar, pilih variabel dependen (Y) dan independen (X) yang akan dianalisis.
5.  **Hasilkan Analisis**: Klik tombol "Generate Analysis" untuk memperbarui hasil statistik dan visualisasi di semua tab.

---

### 📜 Lisensi

Proyek ini dilisensikan di bawah Lisensi MIT. Lihat file [LICENSE](LICENSE) untuk detail lebih lanjut.
