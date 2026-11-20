# BitFlow Web

[English Version](/documents/en.md) | **中文文档**

<div align="center">

<img src="assets/icon.png" width="120px" alt="BitFlow Logo">

[![License](https://img.shields.io/badge/License-MIT-dark_green.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.41.6-blue.svg)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Web%20%2F%20PWA-orange.svg)](https://zhoucheng133.github.io/BitFlow-Web/)

一个基于 Flutter 开发的现代多协议下载管理客户端 Web 版本，完美支持 PWA（渐进式网页应用）。

</div>

---

## 🌟 项目简介

BitFlow Web 是 [BitFlow](https://github.com/Zhoucheng133/BitFlow) 的 Web 分支版本。它旨在提供一个美观、响应式且功能强大的下载管理器前端，支持连接并管理多种主流下载工具。

## ✨ 核心特性

- **多下载引擎支持**：全面支持 **qBittorrent**、**Aria2** 以及 **Transmission**。
- **响应式多端设计**：针对桌面端（Desktop）与移动端（Mobile）进行了精细的 UI 适配与优化。
- **PWA 支持**：可作为渐进式网页应用安装至桌面或手机主屏幕，获得原生应用般的体验。
- **国际化（i18n）**：内置简体中文、繁体中文、英语、日语、韩语、俄语、法语、德语、西班牙语、葡萄牙语等多种语言支持。
- **主题与外观**：支持亮色/暗色模式切换及个性化主题配置。
- **现代美观的 UI**：采用 Flutter Material Design，界面简洁流畅，交互高效。

## 🚀 在线体验

你可以直接访问托管在 GitHub Pages 上的演示页面：
👉 [BitFlow Web Online](https://zhoucheng133.github.io/BitFlow-Web/)

## 📦 部署指南

你可以将 `flutter build web` 构建出的静态文件部署到任意静态托管服务（如 GitHub Pages、Cloudflare Pages、Vercel、Nginx 等）。

> [!IMPORTANT]
> **关于跨域（CORS）与 qBittorrent 的特别说明：**
> - **qBittorrent** 默认不支持直接跨域访问 Web API。如果你使用 Web 版本连接自建的 qBittorrent，通常需要配置**反向代理**（如 Nginx、Caddy）来处理跨域请求头，或者在代理中转发 API。
> - **Aria2** 与 **Transmission** 通常可以通过配置正确的 RPC 密钥和允许跨域的 RPC 设置（如 Aria2 的 `--rpc-allow-origin-all`）直接连接，一般没有跨域问题。

## 🛠️ 本地开发与构建

如果你希望在本地进行开发或自行构建：

1. **环境准备**
   确保已安装 Flutter（本项目推荐使用版本 **`3.41.6`** 或兼容的 Flutter 3.x 版本），详见 [Flutter 官方安装文档](https://docs.flutter.dev/get-started/install)。

2. **克隆仓库并安装依赖**
   ```bash
   git clone https://github.com/Zhoucheng133/BitFlow-Web.git
   cd BitFlow-Web
   flutter pub get
   ```

3. **本地调试运行**
   ```bash
   flutter run -d chrome
   ```

4. **构建生产版本**
   ```bash
   flutter build web --release
   ```
   若需部署到指定子路径（如 GitHub Pages 的 `/BitFlow-Web/`），请在构建时指定 `--base-href`：
   ```bash
   flutter build web --base-href /BitFlow-Web/
   ```

## 📄 开源协议

本项目基于 [MIT License](LICENSE) 开源。
