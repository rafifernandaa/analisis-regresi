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
    /* Optional: enhance close button in fullscreen */
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
