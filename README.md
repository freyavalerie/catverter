# Catverter 🐾🎬

A cute, dead-simple **FFmpeg GUI** — OLED-black, pride-rainbow, and fast. Convert videos, rip audio,
make GIFs, and download from YouTube & friends, with hardware-accelerated (NVENC) encoding under the
hood. No command line, no settings soup.

![OLED dark + RGB](src-tauri/icons/icon.png)

## Download

**[⬇ Get the latest installer](https://github.com/freyavalerie/catverter/releases/latest)** — grab
`Catverter_x.x.x_x64-setup.exe`, run it, done. Windows 10/11, 64-bit.

> Windows SmartScreen may say "unknown publisher" (the app isn't code-signed with a paid certificate).
> Click **More info → Run anyway**. It updates itself from then on.

FFmpeg is fetched automatically on first run (into `%LOCALAPPDATA%\Catverter\bin`), so there's nothing
else to install.

## Features

- **Convert** to MP4 (H.265) or WebM — quality presets or a target file size (great for Discord limits)
- **NVENC hardware encoding** with automatic CPU fallback — fast, and it leaves your CPU free
- **Audio** extraction (MP3 / M4A / WAV) and **GIF** export with a quality slider
- **Frame-precise trimming** with a live preview
- **Download** from YouTube, TikTok, X, Twitch and more (yt-dlp, keeps itself updated)
- **Queue / batch** — drop a whole folder, one set of settings, walk away
- **Delete original** — recycle the source and keep a clean `name_Catverter.mp4`
- **Quality check** — a one-click VMAF score, so you know how close the output looks to the source
- **Self-updating** — new versions install from inside the app

## Building from source (developer)

No Node required — a plain [Tauri 2](https://tauri.app) app. You need the
[Rust toolchain](https://rustup.rs) and the Tauri CLI:

```sh
cargo install tauri-cli --version "^2"
cd src-tauri
cargo tauri dev      # run it (dev, keeps a console for logs)
cargo tauri build    # optimized build + installer
```

```
Catverter/
├─ ui/                 vanilla HTML/CSS/JS frontend (all the OLED + RGB design)
├─ src-tauri/          Rust backend: ffmpeg/yt-dlp, convert, self-update
├─ scripts/release.ps1 one-command signed release → GitHub
└─ README.md
```

The Rust side spawns a real `ffmpeg` and streams `-progress` back to the UI as Tauri events. Because
`app.js` has a mock layer, you can also open the `ui/` folder in a browser to play with the design
without compiling.

## Shipping an update (maintainer)

Updates are signed with a private key kept **outside** this repo (`~/.catverter/updater.key`) — back it
up; losing it means existing installs can't trust new updates. The public half lives in
`src-tauri/tauri.conf.json`.

One command builds, signs, writes the update manifest, and publishes a GitHub Release:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\release.ps1 -Version 0.2.0 -Notes "What changed"
```

Installed copies check `releases/latest/download/latest.json` and offer the update within a few hours
(or on next launch).

---

Made with 🐾 by [Freya](https://github.com/freyavalerie).
