# Aplikasi Analisis Regresi Interaktif 📊

[![Shiny](https://img.shields.io/badge/Made%20with-Shiny-blue.svg)](https://shiny.posit.co/)

Aplikasi web berbasis R Shiny yang dirancang untuk melakukan analisis data secara interaktif. Pengguna dapat mengunggah dataset mereka sendiri dalam format CSV, melakukan pembersihan data, menjalankan analisis statistik seperti ANOVA, serta menguji asumsi statistik dasar.

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
├── rshiny-analisis-regresi.R               # Kode utama aplikasi Shiny (UI, Server, & CSS)
├── data/
│   └── epl_results_2022-23_missing.csv # Contoh dataset dengan missing value untuk demo
│   └── epl_results_2022-23.csv # Contoh dataset tanpa missing value untuk demo
├── README.md           # File dokumentasi ini
```

---

### 🚀 Instalasi dan Menjalankan Aplikasi

Untuk menjalankan aplikasi ini di komputer lokal Anda, ikuti langkah-langkah berikut:

**1. Prasyarat:**
-   Pastikan Anda telah menginstal **R** dan **RStudio** di komputer Anda.

**2. Clone Repositori:**
```bash
git clone [https://github.com/rafifernanda/analisis-regresi.git](https://github.com/rafifernandaa/analisis-regresi.git)
cd analisis-regresi
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

1.  **Unggah File**: Klik tombol "Browse" atau "Upload CSV File" dan pilih file `.csv` Anda. Anda juga bisa menggunakan file `data/epl_results_2022-23_missing.csv.csv` atau `data/epl_results_2022-23.csv.csv`yang sudah disediakan.
2.  **Pembersihan Data**: Jika data Anda memiliki nilai `NA`, klik tombol "Clean Data" untuk menghapusnya.
3.  **Reset Data**: Jika Anda ingin kembali ke data asli, klik "Reset Data".
4.  **Pilih Variabel**: Di sidebar, pilih variabel dependen (Y) dan independen (X) yang akan dianalisis.
5.  **Hasilkan Analisis**: Klik tombol "Generate Analysis" untuk memperbarui hasil statistik dan visualisasi di semua tab.

---
