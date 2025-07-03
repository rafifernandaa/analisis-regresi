
library(shiny)
library(bslib)
library(shinydashboard)
library(DT)
library(dplyr)
library(ggplot2)
library(car)
library(nortest)
library(readr)
library(stringr)
library(shinyWidgets)
library(rmarkdown)
library(tinytex)

custom_theme <- bs_theme(
  version = 5,
  bg = "#ffffff",
  fg = "#333",
  primary = "#ff6200",
  secondary = "#666",
  base_font = font_google("Roboto"),
  heading_font = font_google("Montserrat")
) %>%
  bs_add_rules('
  /* Navbar glass effect */
  .navbar {
    background-color: rgba(255, 255, 255, 0.3);
    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.05);
  }

  /* Sidebar with glassmorphism */
  .sidebar {
    background-color: rgba(255, 255, 255, 0.3);
    border-right: 1px solid rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
  }

  /* Scrollbar minimalis di sidebar */
  .sidebar ::-webkit-scrollbar {
    width: 6px;
  }

  .sidebar ::-webkit-scrollbar-track {
    background: transparent;
  }

  .sidebar ::-webkit-scrollbar-thumb {
    background: rgba(200, 200, 200, 0.4);
    border-radius: 10px;
    border: 1px solid rgba(255, 255, 255, 0.3);
  }

  .sidebar ::-webkit-scrollbar-thumb:hover {
    background: rgba(160, 160, 160, 0.6);
  }

  /* Perhalus transisi */
  .sidebar, .sidebar * {
    transition: all 0.3s ease;
  }

  /* Tombol lebih lembut saat diklik */
  .btn {
    transition: all 0.2s ease-in-out;
  }

  .btn:active {
    transform: scale(0.97);
  }

  /* Card style */
  .card {
    background: #ffffff;
    border: none;
    box-shadow: 2px 2px 5px rgba(0,0,0,0.05), -2px -2px 5px rgba(255,255,255,0.8);
    border-radius: 12px;
    overflow: hidden;
    position: relative;
  }

  /* Fullscreen card overlay style */
  .card.fullscreen-enabled.card-fullscreen,
  .card.card-fullscreen {
    background: rgba(255, 255, 255, 0.2) !important;
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-radius: 24px;
    border: 2px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 90%;
    height: 90%;
    z-index: 1050;
    display: flex;
    flex-direction: column;
  }

  /* Highlight title bar of fullscreen card */
  .card.fullscreen-enabled.card-fullscreen .card-header,
  .card.card-fullscreen .card-header {
    background: linear-gradient(to right, #ff7f2a, #ff6200);
    color: white;
    font-weight: bold;
    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    border-top-left-radius: 20px;
    border-top-right-radius: 20px;
    padding: 12px 20px;
    font-size: 18px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  /* Navigation buttons inspired by the image */
  .card.fullscreen-enabled.card-fullscreen .nav-btn,
  .card.card-fullscreen .nav-btn {
    background: rgba(200, 200, 200, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.5);
    border-radius: 50%;
    width: 40px;
    height: 40px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin: 5px;
    cursor: pointer;
    transition: all 0.2s ease;
  }

  .card.fullscreen-enabled.card-fullscreen .nav-btn:hover,
  .card.card-fullscreen .nav-btn:hover {
    background: rgba(160, 160, 160, 0.4);
  }

  .card.fullscreen-enabled.card-fullscreen .nav-btn.active,
  .card.card-fullscreen .nav-btn.active {
    background: #ff6200;
    color: white;
  }

  .card.fullscreen-enabled.card-fullscreen .card-header .btn-close,
  .card.card-fullscreen .card-header .btn-close {
    filter: invert(1);
  }

  /* Modal notification style */
  .modal-content {
    background: rgba(255, 255, 255, 0.2) !important;
    backdrop-filter: blur(15px);
    color: #333;
    -webkit-backdrop-filter: blur(15px);
    border-radius: 15px;
    border: 1px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
  }

  .modal-header {
    background: linear-gradient(to right, #ff7f2a, #ff6200);
    color: white;
    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    border-top-left-radius: 14px;
    border-top-right-radius: 14px;
    padding: 10px 15px;
  }

  .modal-footer {
    border-top: 1px solid rgba(255, 255, 255, 0.2);
  }

  /* Notification style */
  .shiny-notification {
    background: rgba(255, 255, 255, 0.2) !important;
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    border: 1px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    color: #333;
    border-radius: 10px;
    padding: 10px 15px;
  }

  .btn-primary {
    background: linear-gradient(145deg, #ff7f2a, #ff6200);
    box-shadow: 5px 5px 15px #e0e0e0, -5px -5px 15px #ffffff;
    border: none;
    color: white;
    padding: 10px 20px;
    font-size: 16px;
  }

  .btn-primary:hover {
    background: linear-gradient(145deg, #ff6200, #ff7f2a);
    box-shadow: 2px 2px 5px #e0e0e0, -2px -2px 5px #ffffff;
  }

  body {
    background: #ffffff;
  }

  .content {
    overflow: auto;
    -webkit-overflow-scrolling: touch;
    height: auto;
  }

  .form-group {
    margin-bottom: 15px;
  }

  /* Ensure DT table fills fullscreen card and retains pagination */
  .card.fullscreen-enabled.card-fullscreen .dataTables_scrollBody,
  .card.card-fullscreen .dataTables_scrollBody {
    flex-grow: 1;
    overflow: auto;
  }

  .dataTables_paginate {
    display: flex;
    justify-content: flex-end;
    margin-top: 10px;
  }

  .dataTables_paginate .paginate_button {
    background: #fff;
    border: 1px solid #ddd;
    padding: 5px 10px;
    margin: 0 2px;
    border-radius: 3px;
    cursor: pointer;
  }

  .dataTables_paginate .paginate_button:hover {
    background: #f0f0f0;
  }

  .dataTables_paginate .paginate_button.current {
    background: #ff6200;
    color: white;
    border: 1px solid #ff6200;
  }
  ')

# --- UI (User Interface) ---
ui <- page_navbar(
  title = "Data Analysis App",
  theme = custom_theme,
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  nav_spacer(),
  sidebar = sidebar(
    width = 300,
    h5("1. Upload Data"),
    fileInput("file", "Pilih File CSV", accept = ".csv", buttonLabel = "Cari..."),
    selectInput("encoding", "File Encoding", choices = c("UTF-8", "Latin1", "ASCII")),
    hr(),
    h5("2. Pembersihan Data (Opsional)"),
    actionButton("clean", "Bersihkan Data (Hapus NA)", icon = icon("broom"), class = "btn-block"),
    actionButton("reset", "Kembalikan ke Data Mentah", icon = icon("undo"), class = "btn-block btn-secondary"),
    hr(),
    h5("3. Pengaturan Analisis"),
    uiOutput("data_source_ui"),
    selectInput("plot_type", "Pilih Tipe Plot", choices = c("Garis" = "Line", "Batang" = "Bar")),
    hr(),
    actionButton("help", "Bantuan", icon = icon("question-circle"), class = "btn-block"),
    uiOutput("var_select_ui"),
    hr(),
    downloadButton(
      "export_pdf", 
      "Ekspor Hasil ke PDF", 
      icon = icon("file-pdf"),
      class = "btn-primary btn-block"
    )
  ),
  tabPanel(
    title = "Home",
    icon = icon("house"),
    fluidPage(
      div(
        style = "padding: 50px 80px;",
        h1("📊 Aplikasi Analisis Regresi", style = "text-align: center;"),
        br(),
        h4("Selamat datang!", style = "text-align: left;"),
        p(
          "Aplikasi ini dirancang untuk memudahkan pengguna khususnya pelajar, peneliti, maupun praktisi dalam melakukan analisis regresi secara cepat, interaktif, dan tetap dapat dipahami hasilnya secara mendalam.",
          style = "text-align: justify;"
        ),
        p(
          "Analisis regresi merupakan salah satu metode statistik yang digunakan untuk memahami dan memprediksi hubungan antara variabel dependen (target) dengan satu atau lebih variabel independen (prediktor). Model ini sangat berguna dalam berbagai bidang seperti ekonomi, teknik, kesehatan, dan ilmu sosial.",
          style = "text-align: justify;"
        ),
        p(
          "Dengan tampilan antarmuka yang ramah pengguna, Anda tidak perlu menulis kode untuk melakukan perhitungan, namun tetap dapat melihat hasil regresi dalam bentuk persamaan matematis, ringkasan statistik, serta pengujian asumsi-asumsi dasar regresi.",
          style = "text-align: justify;"
        )
      )
    )
  ),
  nav_panel(
    "Pengolahan Data",
    layout_columns(
      col_widths = c(12),
      card(full_screen = TRUE, card_header("Pratinjau Data Mentah"), DTOutput("raw_table")),
      card(full_screen = TRUE, card_header("Pratinjau Data Bersih"), DTOutput("cleaned_table_preview"))
    )
  ),
  nav_panel(
    "Ringkasan & Visualisasi",
    tabsetPanel(
      type = "pills",
      tabPanel("Statistik Ringkas", card(full_screen = TRUE, card_header("Ringkasan Data"), valueBoxOutput("value1", width = 4), verbatimTextOutput("summary"))),
      tabPanel("Hasil ANOVA", 
               card(
                 full_screen = TRUE,
                 card_header("ANOVA"),
                 verbatimTextOutput("anova_results"),
                 hr(),
                 # Fitur interpretasi Anda dipertahankan
                 selectInput(
                   "anova_interpretation",
                   "Pilih Interpretasi ANOVA",
                   choices = c("F-Statistik" = "f_stat", "R-Squared" = "r_squared", "Koefisien" = "coefficients"),
                   selected = "f_stat"
                 ),
                 htmlOutput("anova_interpretation_text")
               )
      ),
      tabPanel("Visualisasi", card(full_screen = TRUE, card_header("Plot Data"), plotOutput("data_plot", height = "400px"))),
      tabPanel("Model Akhir", 
               card(
                 full_screen = TRUE, 
                 card_header("Model Regresi Linear"),
                 h5("Ringkasan Model (Model Summary)"),
                 verbatimTextOutput("model_summary"),
                 hr(),
                 h5("Persamaan Model Akhir"),
                 uiOutput("model_equation"),
                 hr(),
                 h5("Interpretasi Koefisien"),
                 verbatimTextOutput("model_interpretation")
               )
      )
    )
  ),
  nav_panel(
    "Uji Asumsi",
    tabsetPanel(
      type = "pills",
      tabPanel(
        "Uji Normalitas",
        card(
          full_screen = TRUE,
          card_header("Uji Shapiro-Wilk & Anderson-Darling"),
          verbatimTextOutput("normality_results"),
          htmlOutput("normality_interpretation")
        )
      ),
      tabPanel(
        "Uji Homoskedastisitas",
        card(
          full_screen = TRUE,
          card_header("Uji Levene"),
          verbatimTextOutput("levene_results"),
          htmlOutput("levene_interpretation")
        )
      ),
      tabPanel("Uji Normalitas Residual", card(full_screen = TRUE, card_header("Histogram & Uji Normalitas Residual"), plotOutput("residual_plot"), verbatimTextOutput("residual_test"))),
      tabPanel("Uji Multikolinearitas", card(full_screen = TRUE, card_header("Uji Multikolinearitas dengan VIF"), verbatimTextOutput("vif_output"))),
      tabPanel("4-Plot Diagnostic",
               card(full_screen = TRUE,
                    card_header("EDA Residual Diagnostics (4-Plot)"),
                    fluidRow(
                      column(6, plotOutput("resid_runseq")),
                      column(6, plotOutput("resid_lag"))
                    ),
                    fluidRow(
                      column(6, plotOutput("resid_hist")),
                      column(6, plotOutput("resid_qq"))
                    ),
                    fluidRow(
                      column(12,
                             hr(),
                             h4("Interpretasi 4-Plot Diagnostik"),
                             p("Gunakan keempat plot di atas untuk menguji asumsi-asumsi penting pada residual model Anda. Residual adalah selisih antara nilai aktual dan nilai prediksi model."),
                             tags$ul(
                               tags$li(
                                 tags$strong("1. Run Sequence Plot:"),
                                 " Plot ini membantu memeriksa asumsi 'lokasi' dan 'variasi' yang tetap. Idealnya, plot akan menunjukkan titik-titik data yang tersebar secara acak di sekitar garis tengah (nol) tanpa ada tren naik atau turun (menandakan lokasi tetap), dan dengan sebaran vertikal yang konsisten di sepanjang plot (menandakan variasi tetap)."
                               ),
                               tags$li(
                                 tags$strong("2. Lag Plot:"),
                                 " Plot ini digunakan untuk menguji keacakan (randomness) residual. Jika residual benar-benar acak, plot ini akan terlihat seperti sebaran titik tanpa pola atau struktur yang jelas (misalnya, tidak membentuk garis atau kurva)."
                               ),
                               tags$li(
                                 tags$strong("3. Histogram:"),
                                 " Plot ini menunjukkan distribusi dari residual. Jika asumsi normalitas terpenuhi, histogram akan memiliki bentuk seperti lonceng (bell-shaped) yang simetris, yang mengindikasikan distribusi mendekati normal."
                               ),
                               tags$li(
                                 tags$strong("4. Normal Probability Plot (Q-Q Plot):"),
                                 " Ini adalah tes visual yang paling umum untuk asumsi normalitas. Jika residual berdistribusi normal, titik-titik data akan mengikuti garis lurus diagonal berwarna merah."
                               )
                             ),
                             p(tags$strong("Kesimpulan:"), " Jika keempat asumsi di atas terpenuhi, maka proses atau model yang dianalisis dapat dikatakan berada dalam 'kontrol statistik' (in statistical control), yang berarti model tersebut valid dan dapat diandalkan.")
                      )
                    )
               )
      )
    )
  )
)

# --- SERVER (Logic) ---
server <- function(input, output, session) {
  
  rv <- reactiveValues(
    raw_data = NULL,      # Untuk menyimpan data asli
    cleaned_data = NULL,  # Untuk menyimpan data yang sudah dibersihkan
    is_cleaned = FALSE    # Flag untuk menandai apakah pembersihan sudah dilakukan
  )
  
  # 1. Saat file diunggah, reset semua state
  observeEvent(input$file, {
    req(input$file)
    df <- tryCatch({
      read_csv(input$file$datapath, locale = locale(encoding = input$encoding))
    }, error = function(e) {
      showNotification(paste("Gagal membaca file:", e$message), type = "error", duration = 10)
      return(NULL)
    })
    
    if (!is.null(df)) {
      rv$raw_data <- df
      rv$cleaned_data <- NULL
      rv$is_cleaned <- FALSE
      showNotification("File berhasil diunggah.", type = "message")
    }
  })
  
  # 2. Logika untuk membersihkan data
  observeEvent(input$confirm_clean, {
    removeModal()
    
    df_cleaned <- rv$raw_data[complete.cases(rv$raw_data), ]
    
    if (nrow(df_cleaned) == 0) {
      showNotification("Peringatan: Semua baris mengandung NA dan telah dihapus.", type = "warning", duration = 10)
    } else {
      rows_removed <- nrow(rv$raw_data) - nrow(df_cleaned)
      showNotification(paste(rows_removed, "baris dengan NA berhasil dihapus."), type = "message")
    }
    
    rv$cleaned_data <- df_cleaned
    rv$is_cleaned <- TRUE
  })
  
  # 3. Tombol Reset: mengembalikan state ke kondisi awal
  observeEvent(input$reset, {
    req(rv$raw_data)
    rv$cleaned_data <- NULL
    rv$is_cleaned <- FALSE
    updateRadioButtons(session, "data_source_selector", selected = "raw")
    showNotification("Data telah dikembalikan ke kondisi mentah.", type = "default")
  })
  
  # UI dinamis untuk memilih sumber data analisis
  output$data_source_ui <- renderUI({
    req(rv$raw_data)
    choices <- c("Data Mentah" = "raw")
    if (rv$is_cleaned) {
      choices <- c(choices, "Data Bersih" = "clean")
    }
    radioButtons(
      "data_source_selector",
      label = "Pilih Sumber Data untuk Analisis:",
      choices = choices,
      selected = "raw"
    )
  })
  
  # Reactive utama yang menyediakan data untuk SEMUA analisis
  analysis_data <- reactive({
    req(rv$raw_data, input$data_source_selector)
    
    if (input$data_source_selector == "clean" && rv$is_cleaned) {
      return(rv$cleaned_data)
    } else {
      return(rv$raw_data)
    }
  })
  
  # Model Reaktif untuk REGRESI LINEAR (memastikan variabel numerik)
  model_fit <- reactive({
    # Menggunakan pemilih variabel utama dari sidebar
    req(analysis_data(), input$dep_var, input$ind_vars)
    df <- analysis_data()
    
    df_for_lm <- df
    # Paksa variabel menjadi numerik untuk regresi
    tryCatch({
      df_for_lm[[input$dep_var]] <- as.numeric(as.character(df_for_lm[[input$dep_var]]))
      for(var in input$ind_vars) {
        df_for_lm[[var]] <- as.numeric(as.character(df_for_lm[[var]]))
      }
    }, error = function(e) { return(NULL) })
    
    df_for_lm <- df_for_lm[complete.cases(df_for_lm[, c(input$dep_var, input$ind_vars)]),]
    if(nrow(df_for_lm) < 2 || length(input$ind_vars) < 1) return(NULL)
    
    formula <- as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse = "+")))
    lm(formula, data = df_for_lm)
  })
  
  # Model Reaktif untuk ANOVA (mengubah variabel independen menjadi faktor)
  anova_model_summary <- reactive({
    req(analysis_data(), input$dep_var, input$ind_vars)
    df <- analysis_data()
    
    # --- VALIDASI PENTING DITAMBAHKAN ---
    for(var in input$ind_vars) {
      # Hitung jumlah level/grup unik
      unique_levels <- length(unique(df[[var]]))
      
      # Beri peringatan jika variabel numerik dan punya terlalu banyak grup (>15)
      # Angka 15 ini bisa Anda sesuaikan
      if(is.numeric(df[[var]]) && unique_levels > 15) {
        showNotification(
          paste("Peringatan: Variabel '", var, "' memiliki", unique_levels, "nilai unik. ANOVA memperlakukannya sebagai grup terpisah. Analisis ini lebih cocok untuk variabel kategorikal dengan sedikit grup."),
          type = "warning",
          duration = 15 # Tampilkan notifikasi lebih lama
        )
      }
    }
    
    # Sisa kode tetap sama
    for(var in input$ind_vars) {
      df[[var]] <- as.factor(df[[var]])
    }
    
    formula <- as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse = "+")))
    model <- lm(formula, data = df)
    summary(model)
  })
  # --- Output dan Analisis menggunakan `analysis_data()` ---
  
  output$raw_table <- renderDT({
    req(rv$raw_data)
    datatable(rv$raw_data, options = list(scrollX = TRUE, scrollY = "300px", pageLength = 10), caption = "Data asli yang diunggah.")
  })
  
  output$cleaned_table_preview <- renderDT({
    if (!rv$is_cleaned || is.null(rv$cleaned_data)) {
      return(datatable(data.frame(Status = "Data belum dibersihkan atau tidak ada data bersih."), options = list(dom = 't')))
    }
    datatable(rv$cleaned_data, options = list(scrollX = TRUE, scrollY = "300px", pageLength = 10), caption = "Hasil setelah penghapusan baris dengan nilai NA.")
  })
  
  output$var_select_ui <- renderUI({
    df <- analysis_data()
    req(df)
    if (nrow(df) > 0) {
      tagList(
        hr(),
        h5("4. Pemilihan Variabel"),
        selectInput("dep_var", "Variabel Dependen (Y)", choices = names(df), selected = names(df)[1]),
        selectInput("ind_vars", "Variabel Independen (X)", choices = names(df), multiple = TRUE, selected = names(df)[2])
      )
    }
  })
  
  output$value1 <- renderValueBox({
    df <- analysis_data()
    req(df)
    count <- nrow(df)
    source_text <- if (input$data_source_selector == "clean") "Data Bersih" else "Data Mentah"
    valueBox(count, paste("Jumlah Baris di", source_text), icon = icon("list"))
  })
  
  output$summary <- renderPrint({
    df <- analysis_data()
    req(df, input$dep_var, input$ind_vars)
    if (nrow(df) == 0) return("Data kosong.")
    
    source_text <- if (input$data_source_selector == "clean") "Data Bersih" else "Data Mentah"
    list(
      "Ringkasan berdasarkan" = source_text,
      "Variabel Dependen (Y)" = summary(df[[input$dep_var]]),
      "Variabel Independen (X)" = summary(df[, input$ind_vars, drop = FALSE])
    )
  })
  
  output$data_plot <- renderPlot({
    df <- analysis_data()
    req(df, input$plot_type, input$dep_var)
    if (nrow(df) == 0) return(NULL)
    
    df_sample <- df
    x_var <- seq_len(nrow(df_sample))
    y_val <- df_sample[[input$dep_var]]
    
    p <- ggplot(data.frame(Index = x_var, Y = y_val), aes(x = Index, y = Y))
    
    if (input$plot_type == "Line") {
      p + geom_line(color = "#007bff") + geom_smooth(color = "#6c757d", se = FALSE) + labs(title = paste("Plot dari", input$dep_var), x = "Indeks", y = input$dep_var) + theme_minimal()
    } else {
      p + geom_bar(stat = "identity", fill = "#28a745") + labs(title = paste("Plot dari", input$dep_var), x = "Indeks", y = input$dep_var) + theme_minimal()
    }
  })
  
  output$anova_var_ui <- renderUI({
    df <- analysis_data()
    req(df)
    if(nrow(df) > 0){
      tagList(
        selectInput("dep_var_anova", "Variabel Dependen (Y)", choices=names(df), selected = isolate(input$dep_var)),
        selectInput("ind_vars_anova", "Variabel Independen (X)", choices=names(df), multiple=TRUE, selected = isolate(input$ind_vars))
      )
    }
  })
  
  output$anova_results <- renderPrint({
    req(anova_model_summary())
    model_summary <- anova_model_summary()
    
    # Hapus komponen 'call' dari objek summary
    model_summary$call <- NULL
    
    # Cetak objek yang sudah dimodifikasi
    print(model_summary)
  })
  
  output$anova_interpretation_text <- renderUI({
    req(anova_model_summary(), input$anova_interpretation)
    model_summary <- anova_model_summary() # Menggunakan model reaktif
    
    # Sisa kode Anda untuk interpretasi di sini sudah benar dan bisa dipertahankan
    # Pastikan variabel inputnya sesuai dengan yang ada di UI, yaitu "anova_interpretation"
    f_stat <- model_summary$fstatistic
    f_value <- f_stat[["value"]]
    f_pvalue <- pf(f_stat[["value"]], f_stat[["numdf"]], f_stat[["dendf"]], lower.tail = FALSE)
    r_squared <- model_summary$r.squared
    adj_r_squared <- model_summary$adj.r.squared
    coef_summary <- model_summary$coefficients
    
    interpretation <- switch(input$anova_interpretation,
                             "f_stat" = paste0(
                               "<h4>F-Statistik</h4>",
                               "<p>Nilai F = ", round(f_value, 3), ", p-value = ", format.pval(f_pvalue, digits=3), ".</p>",
                               if(f_pvalue < 0.05) {
                                 "<p>Model secara keseluruhan signifikan secara statistik (p < 0.05), menunjukkan bahwa setidaknya satu variabel independen memiliki pengaruh signifikan terhadap variabel dependen.</p>"
                               } else {
                                 "<p>Model tidak signifikan secara statistik (p >= 0.05), menunjukkan bahwa variabel independen secara kolektif tidak memiliki pengaruh signifikan terhadap variabel dependen.</p>"
                               }
                             ),
                             "r_squared" = paste0(
                               "<h4>R-Squared</h4>",
                               "<p>Nilai R-Squared = ", round(r_squared, 3), ".</p>",
                               "<p>Ini menunjukkan bahwa ", round(r_squared * 100, 1), "% variasi dalam variabel dependen (", input$dep_var_anova, ") dapat dijelaskan oleh variabel independen dalam model.</p>"
                             ),
                             "adj_r_squared" = paste0(
                               "<h4>Adjusted R-Squared</h4>",
                               "<p>Nilai Adjusted R-Squared = ", round(adj_r_squared, 3), ".</p>",
                               "<p>Nilai ini menyesuaikan R-Squared untuk jumlah variabel dalam model, memberikan ukuran yang lebih akurat tentang goodness-of-fit. Nilai yang lebih tinggi menunjukkan model yang lebih baik.</p>"
                             ),
                             "coefficients" = {
                               coef_text <- "<h4>Koefisien dan Signifikansi</h4><ul>"
                               for(i in 1:nrow(coef_summary)) {
                                 var_name <- rownames(coef_summary)[i]
                                 coef_val <- coef_summary[i, "Estimate"]
                                 p_val <- coef_summary[i, "Pr(>|t|)"]
                                 coef_text <- paste0(coef_text, "<li>", var_name, ": Koefisien = ", round(coef_val, 3), ", p-value = ", format.pval(p_val, digits=3), "<br>")
                                 coef_text <- paste0(coef_text, if(p_val < 0.05) {
                                   paste0("Variabel ini signifikan secara statistik (p < 0.05), menunjukkan bahwa ", var_name, " memiliki pengaruh signifikan terhadap ", input$dep_var_anova, ".")
                                 } else {
                                   paste0("Variabel ini tidak signifikan secara statistik (p >= 0.05), menunjukkan bahwa ", var_name, " tidak memiliki pengaruh signifikan terhadap ", input$dep_var_anova, ".")
                                 }, "</li>")
                               }
                               paste0(coef_text, "</ul>")
                             }
    )
    HTML(interpretation)
  })
  
  output$model_summary <- renderPrint({
    req(model_fit())
    summary(model_fit())
  })
  
  output$model_equation <- renderUI({
    model <- model_fit()
    req(model)
    coefs <- coef(model)
    
    # Membangun string persamaan
    eq_str <- paste0(input$dep_var, " = ", round(coefs[1], 4))
    if(length(coefs) > 1) {
      for(i in 2:length(coefs)) {
        sign <- ifelse(coefs[i] >= 0, " + ", " - ")
        eq_str <- paste0(eq_str, sign, round(abs(coefs[i]), 4), " * ", names(coefs)[i])
      }
    }
    tags$p(style="font-size:1.1em; background-color:#f5f5f5; border-radius:5px; padding:10px;", tags$code(eq_str))
  })
  
  output$model_interpretation <- renderPrint({
    model <- model_fit()
    req(model)
    coefs <- coef(model)
    
    cat(paste0("Intercept (", round(coefs[1], 4), "):\n"))
    cat(paste0("  Nilai prediksi '", input$dep_var, "' ketika semua variabel independen bernilai nol.\n\n"))
    
    if(length(coefs) > 1) {
      for(i in 2:length(coefs)) {
        var_name <- names(coefs)[i]
        value <- round(coefs[i], 4)
        cat(paste0("Koefisien '", var_name, "' (", value, "):\n"))
        cat(paste0("  Setiap kenaikan 1 unit pada '", var_name, "', akan merubah '", input$dep_var, "' sebesar ", value, " satuan, asumsi variabel lain konstan.\n\n"))
      }
    }
  })
  
  output$normality_results <- renderPrint({
    df <- analysis_data()
    req(df, input$dep_var)
    if(nrow(df) == 0) return("Tidak bisa melakukan uji normalitas pada data kosong.")
    y <- df[[input$dep_var]]
    if(!is.numeric(y)){
      "Uji normalitas memerlukan variabel dependen numerik."
    } else {
      list(
        "Uji Shapiro-Wilk" = shapiro.test(y),
        "Uji Anderson-Darling" = ad.test(y)
      )
    }
  })
  
  output$normality_interpretation <- renderUI({
    df <- analysis_data()
    req(df, input$dep_var)
    if(nrow(df) == 0) return(HTML("<p>Tidak ada data untuk diinterpretasikan.</p>"))
    y <- df[[input$dep_var]]
    if(!is.numeric(y)){
      HTML("<p>Uji normalitas memerlukan variabel dependen numerik.</p>")
    } else {
      shapiro_result <- shapiro.test(y)
      ad_result <- ad.test(y)
      
      interpretation <- paste0(
        "<h4>Interpretasi Uji Normalitas</h4>",
        "<h5>Uji Shapiro-Wilk</h5>",
        "<p>p-value = ", format.pval(shapiro_result$p.value, digits=3), ": ",
        if(shapiro_result$p.value < 0.05) {
          "Data tidak berdistribusi normal (p < 0.05). Ini menunjukkan bahwa asumsi normalitas untuk ANOVA mungkin tidak terpenuhi."
        } else {
          "Tidak ada bukti bahwa data tidak berdistribusi normal (p >= 0.05). Asumsi normalitas untuk ANOVA mungkin terpenuhi."
        }, "</p>",
        "<h5>Uji Anderson-Darling</h5>",
        "<p>p-value = ", format.pval(ad_result$p.value, digits=3), ": ",
        if(ad_result$p.value < 0.05) {
          "Data tidak berdistribusi normal (p < 0.05). Ini mendukung temuan bahwa asumsi normalitas mungkin tidak terpenuhi."
        } else {
          "Tidak ada bukti bahwa data tidak berdistribusi normal (p >= 0.05). Asumsi normalitas mungkin terpenuhi."
        }, "</p>"
      )
      
      HTML(interpretation)
    }
  })
  
  output$levene_results <- renderPrint({
    df <- analysis_data()
    req(df, input$dep_var, input$ind_vars)
    if(nrow(df) == 0) return("Tidak bisa melakukan Uji Levene pada data kosong.")
    y <- df[[input$dep_var]]
    if(!is.numeric(y)){
      "Uji Levene memerlukan variabel dependen numerik."
    } else {
      for(var in input$ind_vars){
        df[[var]] <- as.factor(df[[var]])
      }
      formula <- as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse="*")))
      leveneTest(formula, data=df)
    }
  })
  
  output$levene_interpretation <- renderUI({
    df <- analysis_data()
    req(df, input$dep_var, input$ind_vars)
    if(nrow(df) == 0) return(HTML("<p>Tidak ada data untuk diinterpretasikan.</p>"))
    y <- df[[input$dep_var]]
    if(!is.numeric(y)){
      HTML("<p>Uji Levene memerlukan variabel dependen numerik.</p>")
    } else {
      for(var in input$ind_vars){
        df[[var]] <- as.factor(df[[var]])
      }
      formula <- as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse="*")))
      levene_result <- leveneTest(formula, data=df)
      p_val <- levene_result$"Pr(>F)"[1]
      
      interpretation <- paste0(
        "<h4>Interpretasi Uji Homoskedastisitas (Levene)</h4>",
        "<p>p-value = ",
        if(is.na(p_val)) {
          "tidak tersedia (mungkin karena data tidak memadai)."
        } else {
          format.pval(p_val, digits=3)
        }, ": ",
        if(is.na(p_val)) {
          "Interpretasi tidak dapat dilakukan karena data tidak memadai."
        } else if(p_val < 0.05) {
          "Variansi antar kelompok tidak sama (p < 0.05). Asumsi homoskedastisitas untuk ANOVA tidak terpenuhi, sehingga hasil ANOVA mungkin tidak valid."
        } else {
          "Tidak ada bukti bahwa variansi antar kelompok berbeda (p >= 0.05). Asumsi homoskedastisitas untuk ANOVA mungkin terpenuhi."
        }, "</p>"
      )
      
      HTML(interpretation)
    }
  })
  
  output$residual_plot <- renderPlot({
    df <- analysis_data()
    req(df, input$dep_var, input$ind_vars)
    
    formula <- as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse = "+")))
    model <- lm(formula, data = df)
    resid <- residuals(model)
    
    hist(resid, col = "#00c2cb", main = "Histogram Residual", xlab = "Nilai Residual", breaks = 20)
  })
  
  output$residual_test <- renderPrint({
    df <- analysis_data()
    req(df, input$dep_var, input$ind_vars)
    
    formula <- as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse = "+")))
    model <- lm(formula, data = df)
    resid <- residuals(model)
    
    cat("Uji Normalitas Residual:\n\n")
    shapiro <- shapiro.test(resid)
    ad <- ad.test(resid)
    
    cat("Shapiro-Wilk:\n")
    print(shapiro)
    cat("Interpretasi: Berdasarkan Uji Shapiro-Wilk dengan taraf signifikansi 5%, \n")
    if (shapiro$p.value < 0.05) {
      cat("Residual tidak berdistribusi normal pada tingkat kepercayaan 95% (p-value < 0.05)\n")
    } else {
      cat("Residual berdistribusi normal pada tingkat kepercayaan 95% (p-value ≥ 0.05)\n")
    }
    
    cat("\nAnderson-Darling:\n")
    print(ad)
    cat("Interpretasi: Berdasarkan Uji Anderson-Darling dengan taraf signifikansi 5%, \n")
    if (ad$p.value < 0.05) {
      cat("Residual tidak berdistribusi normal pada tingkat kepercayaan 95% (p-value < 0.05)\n")
    } else {
      cat("Residual berdistribusi normal pada tingkat kepercayaan 95% (p-value ≥ 0.05)\n")
    }
  })
  
  output$vif_output <- renderPrint({
    df <- analysis_data()
    req(df, input$dep_var, input$ind_vars)
    
    formula <- as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse = "+")))
    model <- lm(formula, data = df)
    
    vif_values <- vif(model)
    
    cat("VIF (Variance Inflation Factor):\n")
    
    interpretations <- sapply(vif_values, function(val) {
      if (val > 10) { "Multikolinearitas sangat tinggi (VIF > 10)"} 
      else if (val > 5) { "Terdapat indikasi multikolinearitas (VIF > 5)" } 
      else { "Tidak ada indikasi multikolinearitas" }
    })
    
    output_df <- data.frame(
      VIF = round(unname(vif_values), 4),
      Keterangan = interpretations
    )
    
    print(output_df, row.names = FALSE)
  })
  
  output$resid_runseq <- renderPlot({
    req(analysis_data(), input$dep_var, input$ind_vars)
    df <- analysis_data()
    model <- lm(as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse = "+"))), data = df)
    resid <- resid(model)
    
    plot(resid, type = "o", col = "#007bff", main = "Run Sequence Plot", xlab = "Observation Index", ylab = "Residuals")
    abline(h = 0, col = "red", lty = 2)
  })
  
  output$resid_lag <- renderPlot({
    req(analysis_data(), input$dep_var, input$ind_vars)
    df <- analysis_data()
    model <- lm(as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse = "+"))), data = df)
    resid <- resid(model)
    
    plot(head(resid, -1), tail(resid, -1), main = "Lag Plot", xlab = "Residual[t]", ylab = "Residual[t+1]", col = "#28a745")
    abline(h = 0, v = 0, col = "gray", lty = 2)
  })
  
  output$resid_hist <- renderPlot({
    req(analysis_data(), input$dep_var, input$ind_vars)
    df <- analysis_data()
    model <- lm(as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse = "+"))), data = df)
    resid <- resid(model)
    
    hist(resid, main = "Histogram of Residuals", xlab = "Residuals", col = "darkgreen", border = "white", breaks = 20)
  })
  
  output$resid_qq <- renderPlot({
    req(analysis_data(), input$dep_var, input$ind_vars)
    df <- analysis_data()
    model <- lm(as.formula(paste(input$dep_var, "~", paste(input$ind_vars, collapse = "+"))), data = df)
    resid <- resid(model)
    
    qqnorm(resid, main = "Normal Probability Plot")
    qqline(resid, col = "red", lty = 2)
  })
  
  # Bagian modal konfirmasi dan bantuan
  observeEvent(input$clean, {
    req(rv$raw_data)
    has_missing <- any(is.na(rv$raw_data))
    showModal(modalDialog(
      title = "Konfirmasi Pembersihan Data",
      if (has_missing) "Lanjutkan dengan menghapus baris yang mengandung NA?" else "Tidak ada nilai NA yang ditemukan.",
      footer = if (has_missing) tagList(actionButton("confirm_clean", "Ya", class = "btn-primary"), modalButton("Batal")) else modalButton("OK")
    ))
  })
  
  output$export_pdf <- downloadHandler(
    filename = function() {
      paste("Laporan-Analisis-", Sys.Date(), ".pdf", sep = "")
    },
    
    content = function(file) {
      # Pengecekan awal
      if (is.null(model_fit()) || is.null(anova_model_summary())) {
        showNotification("Gagal: Model belum siap. Lakukan analisis terlebih dahulu.", type = "error", duration = 10)
        return(NULL)
      }
      
      # Notifikasi proses berjalan
      id <- showNotification("Sedang mempersiapkan laporan PDF...", duration = NULL, type = "message")
      on.exit(removeNotification(id))
      
      # --- Menyiapkan semua objek dan teks interpretasi ---
      model_obj <- model_fit()
      anova_summary_obj <- anova_model_summary()
      summary_data_obj <- summary(analysis_data())
      
      model_equation_str <- {
        coefs <- coef(model_obj)
        eq <- paste0(input$dep_var, " = ", round(coefs[1], 4))
        if(length(coefs) > 1) {
          for(i in 2:length(coefs)) {
            eq <- paste0(eq, ifelse(coefs[i] >= 0, " + ", " - "), round(abs(coefs[i]), 4), " * ", names(coefs)[i])
          }
        }
        eq
      }
      
      vif_results_obj <- {
        if(length(input$ind_vars) > 1) as.data.frame(vif(model_obj)) else "VIF memerlukan >1 variabel independen."
      }
      
      residual_normality_obj <- shapiro.test(residuals(model_obj))
      
      main_plot_obj <- {
        df <- analysis_data()
        p <- ggplot(df, aes(x = .data[[input$ind_vars[1]]], y = .data[[input$dep_var]]))
        if (input$plot_type == "Line") p <- p + geom_line(aes(group=1), color="#007bff") + geom_point(color="#ff6200")
        else p <- p + geom_bar(stat="summary", fun="mean", fill="#28a745")
        p + labs(title = paste("Plot", input$dep_var, "vs", input$ind_vars[1])) + theme_minimal(base_size = 12)
      }
      
      anova_interpretation_str <- {
        # Logika ini untuk membuat rangkuman di PDF, tetap dipertahankan
        f_stat <- anova_summary_obj$fstatistic
        f_value <- f_stat[["value"]]; f_pvalue <- pf(f_stat[["value"]], f_stat[["numdf"]], f_stat[["dendf"]], lower.tail = FALSE)
        r_squared <- anova_summary_obj$r.squared
        coef_summary <- anova_summary_obj$coefficients
        f_stat_text <- paste0("<h4>F-Statistik</h4><p>Nilai F = ", round(f_value, 3), ", p-value = ", format.pval(f_pvalue, digits=3), ".</p>", if(f_pvalue < 0.05) "<p>Model signifikan.</p>" else "<p>Model tidak signifikan.</p>")
        r_squared_text <- paste0("<h4>R-Squared</h4><p>Nilai R-Squared = ", round(r_squared, 3), ".</p><p>", round(r_squared * 100, 1), "% variasi Y dapat dijelaskan.</p>")
        coef_text <- "<h4>Koefisien Signifikan (p < 0.05)</h4>"
        significant_coeffs_found <- FALSE
        list_items <- ""
        for(i in 1:nrow(coef_summary)) {
          p_val <- coef_summary[i, "Pr(>|t|)"]
          if (!is.na(p_val) && p_val < 0.05) {
            var_name <- rownames(coef_summary)[i]
            list_items <- paste0(list_items, "<li><b>", var_name, "</b>: Signifikan.</li>")
            significant_coeffs_found <- TRUE
          }
        }
        if (significant_coeffs_found) { coef_text <- paste0(coef_text, "<ul>", list_items, "</ul>")
        } else { coef_text <- paste0(coef_text, "<p>Tidak ada koefisien signifikan.</p>") }
        paste(f_stat_text, r_squared_text, coef_text, sep="<hr>")
      }
      
      # === BLOK KODE YANG HILANG DAN SEKARANG DITAMBAHKAN KEMBALI ===
      residual_normality_interpretation_str <- {
        shapiro_res <- residual_normality_obj
        p_val <- shapiro_res$p.value
        paste0("<p>Uji Shapiro-Wilk pada residual: p-value = ", format.pval(p_val, digits=3), ". ",
               if(p_val < 0.05) "Ini menunjukkan bahwa residual **tidak** berdistribusi normal (asumsi tidak terpenuhi)."
               else "Tidak ada bukti bahwa residual tidak berdistribusi normal (asumsi terpenuhi)."
        )
      }
      
      vif_interpretation_str <- {
        if(length(input$ind_vars) <= 1) {
          "<p>Interpretasi VIF tidak tersedia.</p>"
        } else {
          vif_values <- vif(model_obj)
          interp_text <- "<ul>"
          for(i in 1:length(vif_values)) {
            var_name <- names(vif_values)[i]
            val <- vif_values[i]
            ket <- if (val > 10) {"Multikolinearitas sangat tinggi."} else if (val > 5) {"Ada indikasi multikolinearitas."} else {"Tidak ada indikasi multikolinearitas."}
            interp_text <- paste0(interp_text, "<li><b>", var_name, "</b>: VIF = ", round(val, 2), ". ", ket, "</li>")
          }
          paste0(interp_text, "</ul>")
        }
      }
      
      model_equation_interpretation_str <- {
        coefs <- coef(model_obj)
        interp_text <- "<ul>"
        interp_text <- paste0(interp_text, "<li><b>(Intercept)</b>: Saat semua variabel independen nol, nilai prediksi '", input$dep_var, "' adalah ", round(coefs[1], 4), ".</li>")
        if(length(coefs) > 1) {
          for(i in 2:length(coefs)) {
            var_name <- names(coefs)[i]
            value <- round(coefs[i], 4)
            arah <- ifelse(value >= 0, "menaikkan", "menurunkan")
            interp_text <- paste0(interp_text, "<li><b>", var_name, "</b>: Kenaikan 1 satuan '", var_name, "' akan ", arah, " nilai prediksi '", input$dep_var, "' sebesar ", abs(value), ".</li>")
          }
        }
        paste0(interp_text, "</ul>")
      }
      
      # Menyiapkan file dan parameter list LENGKAP
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      
      params_list <- list(
        summary_data = summary_data_obj, anova_summary = anova_summary_obj,
        model_summary = summary(model_obj), reg_model = model_obj,
        model_equation = model_equation_str, vif_results = vif_results_obj,
        residual_normality = residual_normality_obj, main_plot = main_plot_obj,
        anova_interpretation = anova_interpretation_str,
        residual_normality_interpretation = residual_normality_interpretation_str, # Variabel ini sekarang sudah ada
        vif_interpretation = vif_interpretation_str,
        model_equation_interpretation = model_equation_interpretation_str
      )
      
      rmarkdown::render(tempReport, output_file = file, params = params_list, envir = new.env(parent = globalenv()))
    }
  )
  
  observeEvent(input$help, {
    showModal(modalDialog(
      title = "Bantuan: Aplikasi Analisis Data",
      "Aplikasi ini memungkinkan Anda untuk:",
      tags$ul(
        tags$li("Mengunggah file CSV untuk dianalisis."),
        tags$li("Membersihkan data dengan menghapus baris NA (opsional)."),
        tags$li("Memilih antara data mentah atau data bersih untuk dianalisis."),
        tags$li("Menghasilkan statistik ringkas dan hasil ANOVA."),
        tags$li("Melakukan uji asumsi"),
        tags$li("Memvisualisasikan data dengan plot."),
        tags$li("Ekspor hasil analisis dalam bentuk pdf.")
      ),
      easyClose = TRUE
    ))
  })
}

# Jalankan Aplikasi
shinyApp(ui, server)
