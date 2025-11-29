
````markdown
# 📘 **TUGAS 9 (Pertemuan 11) — CRUD & BLoC Pattern**

### 🚀 **Pengembangan Aplikasi Mobile TokoKita**
**Integrasi Flutter dengan REST API CodeIgniter 4**

---

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.16-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![CodeIgniter](https://img.shields.io/badge/CodeIgniter-4.0-EF4223?style=for-the-badge&logo=codeigniter&logoColor=white)
![BLoC](https://img.shields.io/badge/Architecture-BLoC-orange?style=for-the-badge)

</div>

---

# 👤 **Identitas Mahasiswa**

| Atribut | Detail Data |
| :--- | :--- |
| **Nama** | Defit Bagus Saputra |
| **NIM** | H1D023036 |
| **Kelas** | Pemrograman Mobile (Shift C/F) |
| **Topik** | Implementasi Full Stack CRUD Mobile |

---

# 📂 **Struktur Folder & Arsitektur**

Aplikasi ini menerapkan **Pemisahan Concern (SoC)** yang jelas antara UI dan Logic menggunakan pattern BLoC.

```plaintext
lib/
├── 🧠 bloc/                # BUSINESS LOGIC (Pengelola State & API)
├── 🛠️ helpers/             # UTILITIES (Fungsi Bantuan & Token)
├── 📦 model/               # DATA MODELS (Representasi JSON)
├── 📱 ui/                  # USER INTERFACE (Tampilan)
└── 🧩 widget/              # REUSABLE WIDGETS (Dialog)
````

-----

# 📸 **Dokumentasi & Alur Aplikasi**

Berikut adalah dokumentasi langkah demi langkah penggunaan aplikasi TokoKita mulai dari Registrasi, Login, hingga proses CRUD Produk.

## 1️⃣ **Proses Registrasi**

Langkah pertama bagi pengguna baru adalah mendaftarkan akun agar datanya tercatat di database server.

### **a. Mengisi Form Registrasi**

Pengguna menginputkan **Nama**, **Email**, **Password**, dan **Konfirmasi Password**.

  * *Validasi:* Email harus format valid, Password minimal 6 karakter.

### **b. Registrasi Berhasil**

Sistem mengirim data via API. Jika sukses, muncul popup konfirmasi dan user diarahkan untuk Login.

-----

## 2️⃣ **Proses Login**

Setelah memiliki akun, pengguna masuk ke sistem untuk mendapatkan **Token Akses**.

### **a. Mengisi Kredensial**

Pengguna memasukkan Email dan Password yang telah didaftarkan sebelumnya.

### **b. Login Berhasil**

Jika data benar, server memberikan respon kode `200` beserta Token. Aplikasi menyimpan token ini dan mengarahkan pengguna ke halaman utama (List Produk).

-----

## 3️⃣ **Proses Tambah Data (Create)**

Menambahkan inventaris produk baru ke toko.

### **a. Form Tambah Produk**

User menekan tombol **(+)** di halaman utama. Form terbuka dalam keadaan kosong (Mode Tambah). User mengisi Kode, Nama, dan Harga Produk.

### **b. Data Berhasil Disimpan**

Data dikirim ke server via method `POST`. Jika sukses, user dikembalikan ke halaman list dan data baru langsung tampil.

-----

## 4️⃣ **Proses Edit Data (Update)**

Memperbarui informasi produk yang salah atau berubah.

### **a. Membuka Form Edit (Pre-filled)**

Dari halaman detail produk, user menekan tombol **EDIT**. Form terbuka dan kolom isian **terisi otomatis** dengan data produk yang dipilih (tidak perlu mengetik ulang dari awal).

### **b. Melakukan Perubahan**

User mengubah data yang diinginkan (Contoh: Mengubah Harga produk).

### **c. Edit Berhasil**

Aplikasi mengirim data perubahan ke server menggunakan method `PUT` dengan format JSON. Data di list diperbarui sesuai inputan terakhir.

-----

## 5️⃣ **Proses Hapus Data (Delete)**

Menghapus produk yang sudah tidak dijual.

### **a. Konfirmasi Penghapusan**

User menekan tombol **DELETE** di halaman detail. Muncul dialog konfirmasi *"Yakin ingin menghapus data ini?"* untuk mencegah ketidaksengajaan.

### **b. Hapus Berhasil**

Jika user menekan "Ya", aplikasi mengirim request `DELETE` ke server. Produk dihapus dari database dan hilang dari tampilan list.

-----

# 🛠️ **Konfigurasi Teknis**

Aplikasi ini dikonfigurasi untuk berjalan di jaringan lokal (LAN/WiFi).

  * **API Base URL:** Diatur di `helpers/api_url.dart`.
  * **Backend Server:** Dijalankan dengan perintah `php spark serve --host [IP_LAPTOP] --port 8080`.
  * **Keamanan:** Menggunakan `Bearer Token` pada setiap request API (kecuali Login/Register).

-----

**© 2025 Defit Bagus Saputra**

```