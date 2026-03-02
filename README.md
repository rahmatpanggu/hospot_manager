# Hotspot Manager 🔥

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Windows](https://img.shields.io/badge/platform-Windows-brightgreen)
![License](https://img.shields.io/badge/license-MIT-green)

Aplikasi desktop untuk mengelola WiFi Hotspot di Windows dengan mudah. Dibangun menggunakan Flutter.

<div align="center"> <table> <tr> <td align="center"><b>Hotspot Mati (OFF)</b></td> <td align="center"><b>Hotspot Hidup (ON)</b></td> </tr> <tr> <td> <img width="486" height="690" alt="Hotspot Off" src="https://github.com/user-attachments/assets/0cec2372-9172-4c26-88ed-bec7a625152a" /> </td> <td> <img width="487" height="703" alt="Hotspot On" src="https://github.com/user-attachments/assets/a29cf7f5-46f9-4f6b-afdf-97aee9a581d5" /> </td> </tr> </table> </div>

## ✨ Fitur Lengkap

- ✅ **Nyalakan/Matikan Hotspot** - Dengan satu klik toggle
- ✅ **Ganti SSID & Password** - Sesuaikan nama jaringan dan password
- ✅ **Lihat Perangkat Terhubung** - Monitor siapa saja yang terkoneksi
- ✅ **Auto-save Konfigurasi** - Setting tersimpan otomatis
- ✅ **Admin Rights Check** - Peringatan jika tidak dijalankan sebagai admin

## 📥 Download

[![Download](https://img.shields.io/badge/Download-Installer-brightgreen)](https://github.com/rahmatpanggu/hotspot_manager/releases/latest/download/HotspotManager_Setup.exe)

**Klik di atas untuk download versi terbaru**

Atau kunjungi halaman [Releases](https://github.com/rahmatpanggu/hotspot_manager/releases)

## 🖥️ Persyaratan Sistem

- **OS**: Windows 10 atau Windows 11 (64-bit)
- **RAM**: Minimal 2GB
- **Storage**: 50MB free space
- **Network**: WiFi adapter yang mendukung hosted network

## 🎮 Cara Penggunaan

1. **Download** file installer dari halaman Releases
2. **Install** aplikasi dengan menjalankan `HotspotManager_Setup.exe`
3. **Jalankan** aplikasi dari Start Menu atau Desktop
4. **Klik kanan** → **Run as administrator** (WAJIB!)
5. **Atur SSID & Password** sesuai keinginan
6. **Klik tombol ON** untuk mengaktifkan hotspot
7. **Hubungkan perangkat** lain ke WiFi yang dibuat

> ⚠️ **Catatan Penting**: Aplikasi HARUS dijalankan sebagai Administrator agar bisa mengatur hotspot!

## 🔧 Troubleshooting

### Hotspot tidak bisa diaktifkan
- Pastikan aplikasi dijalankan sebagai **Administrator**
- Cek driver WiFi di Device Manager
- Jalankan perintah di CMD: `netsh wlan show drivers`
- Pastikan "Hosted network supported: Yes"

### Perangkat tidak bisa connect
- Pastikan password benar (minimal 8 karakter)
- Restart hotspot (OFF lalu ON)
- Restart laptop

## 🛠️ Build dari Source

```bash
# Clone repository
git clone https://github.com/rahmatpanggu/hotspot_manager.git
cd hotspot_manager

# Get dependencies
flutter pub get

# Build untuk Windows
flutter build windows --release

# File hasil ada di build\windows\x64\runner\Release\

📝 Lisensi
Distribusi menggunakan MIT License. Silakan lihat file LICENSE untuk detail.

📧 Kontak
GitHub: @rahmatpanggu

Email: rpanggu@gmail.com


## 💖 Dukung Karya Saya

Jika proyek ini bermanfaat, dukung saya untuk terus berkarya! 👇

[![Trakteer](https://img.shields.io/badge/Trakteer-Dukung%20Sekarang-f97316?style=for-the-badge&logo=trakteer)](https://teer.id/rpanggu)

*Dibuat dengan ❤️ oleh [@rpanggu](https://github.com/rahmatpanggu)*


