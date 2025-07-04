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
    -   **Uji Normalitas Residual**: Menggunakan Histogram, uji Shapiro-Wilk, dan uji Anderson-Darling.
    -   **Uji Multikolinearitas**: Menggunakan VIF (Variance Inflation Factor).
    -   **4-Plot Diagnostic**: Menggunakan Run Sequence Plot, Lag Plot, HIstogram of Residuals, dan Normal Probability Plot.  
-   **🎨 Visualisasi Data**: Tampilkan data dalam bentuk plot garis atau diagram batang.
-   **📄 Ekspor Hasil Analisis**: Hasil Analisis diekspor ke dalam bentuk pdf.

---

### 📂 Struktur Proyek

```
/proyek-analisis-data/
├── data/
│   └── epl_results_2022-23_missing.csv # Contoh dataset dengan missing value untuk demo
│   └── epl_results_2022-23.csv # Contoh dataset tanpa missing value untuk demo
├── README.md           # File dokumentasi ini
├── report.Rmd            # File template untuk ekspor hasil analisis
├── rshiny-analisis-regresi.R               # Kode utama aplikasi Shiny (UI, Server, & CSS)
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

**Catatan:**
Pastikan file report.Rmd berada dalam folder yang sama dengan file `app.R` untuk melakukan ekspor hasil analisis data ke dalam bentuk pdf. 

---

### 📝 Cara Menggunakan Aplikasi

1.  **Unggah File**: Klik tombol "Browse" atau "Upload CSV File" dan pilih file `.csv` Anda. Anda juga bisa menggunakan file `data/epl_results_2022-23_missing.csv` atau `data/epl_results_2022-23.csv`yang sudah disediakan.
2.  **Pembersihan Data**: Jika data Anda memiliki nilai `NA`, klik tombol "Bersihkan Data (Hapus NA)" untuk menghapusnya.
3.  **Reset Data**: Jika Anda ingin kembali ke data asli, klik "Kemablikan ke Data Mentah".
4.  **Pilih Variabel**: Di sidebar, pilih variabel dependen (Y) dan independen (X) yang akan dianalisis.

---
