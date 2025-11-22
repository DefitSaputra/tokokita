
# 🎯 **README.md — TUGAS 8 (Pertemuan 10)**

### 🚀 *Praktikum Pemrograman Mobile — CRUD Produk Flutter + CodeIgniter 4*

---

<div align="center">

# 🛒 **Aplikasi CRUD Produk Flutter**

### *Dengan Action Bar menggunakan nama panggilan — Defit*

![Flutter](https://img.shields.io/badge/Flutter-3.16-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.2-blue?logo=dart)
![Mobile](https://img.shields.io/badge/Mobile%20App-Praktikum-green)
![Status](https://img.shields.io/badge/Tugas-Selesai-success)

</div>

---

# 👤 **Identitas Mahasiswa**

| Keterangan        | Data                            |
| ----------------- | ------------------------------- |
| **Nama**          | Defit Bagus Saputra             |
| **NIM**           | H1D023036                       |
| **Kelas / Shift** | Shift C (Awal) / Shift F (Baru) |
| **Mata Kuliah**   | Praktikum Pemrograman Mobile    |

---

# 📱 **Deskripsi Aplikasi**

Aplikasi ini merupakan implementasi UI CRUD Produk sesuai Modul Pertemuan 10.
Semua **Action Bar sudah memakai nama panggilan "Defit"**, seperti:

* **Login Defit**
* **Registrasi Defit**
* **List Produk Defit**
* **Tambah Produk Defit**
* **Ubah Produk Defit**
* **Detail Produk Defit**

Aplikasi ini dibuat dengan Flutter dan nantinya akan dihubungkan ke REST API CodeIgniter 4.

---

# 🧩 **Struktur Folder**

```
lib/
 ├── main.dart
 ├── model/
 │    ├── produk.dart
 │    ├── login.dart
 │    └── registrasi.dart
 └── ui/
      ├── login_page.dart
      ├── registrasi_page.dart
      ├── produk_page.dart
      ├── produk_form.dart
      └── produk_detail.dart
```

---

# 🖼️ **Tampilan Aplikasi**

| Halaman          | Screenshot                                 |
| ---------------- | ------------------------------------------ |
| 🔐 Login         | ![Login](screenshots/login.jpeg)           |
| 📝 Registrasi    | ![Registrasi](screenshots/registrasi.jpeg) |
| 📋 List Produk   | ![List](screenshots/list.jpeg)             |
| ➕ Tambah Produk  | ![Tambah](screenshots/tambah.jpeg)         |
| 🔍 Detail Produk | ![Detail](screenshots/detail.jpeg)         |

Folder screenshot:
📂 **/screenshots/**

---

# 🧠 **Penjelasan Detail Setiap Halaman**

---

## 🔐 **1. Halaman Login — `login_page.dart`**

### 🎯 Tujuan:

* Input email & password
* Validasi form
* Navigasi ke halaman Registrasi

### 🌟 Komponen UI:

| Komponen        | Fungsi                      |
| --------------- | --------------------------- |
| Email Field     | Input email                 |
| Password Field  | Input password              |
| Tombol Login    | Validasi form               |
| Link Registrasi | Pergi ke halaman registrasi |

### 🧾 Contoh AppBar:

```dart
AppBar(
  backgroundColor: Colors.blue,
  title: const Text("Login Defit"),
)
```

---

## 📝 **2. Halaman Registrasi — `registrasi_page.dart`**

### 🎯 Tujuan:

* Registrasi pengguna baru
* Validasi email, password, konfirmasi password

### 🌟 Komponen:

* Nama
* Email
* Password
* Konfirmasi Password
* Tombol Registrasi

### AppBar:

```dart
title: const Text("Registrasi Defit")
```

---

## 📋 **3. List Produk — `produk_page.dart`**

### 🎯 Tujuan:

Menampilkan daftar produk dalam bentuk card.

### 🌟 Fitur:

* List produk statis
* Drawer menu (Logout)
* Tombol tambah (+) → menuju form tambah produk
* Klik item → buka detail produk

### AppBar:

```dart
title: const Text("List Produk Defit")
```

---

## ➕ **4. Tambah / Edit Produk — `produk_form.dart`**

### 🎯 Tujuan:

Halaman serbaguna untuk:

✔ Tambah produk
✔ Edit produk

### 🌟 Mode Otomatis:

Jika `widget.produk != null` → mode edit.
Jika null → mode tambah.

### 🧾 Contoh penentuan mode:

```dart
if (widget.produk != null) {
  judul = "UBAH PRODUK Defit";
} else {
  judul = "TAMBAH PRODUK Defit";
}
```

### Komponen:

* TextField Kode Produk
* TextField Nama Produk
* TextField Harga
* Tombol Ubah / Simpan

---

## 🔍 **5. Detail Produk — `produk_detail.dart`**

### 🎯 Tujuan:

Menampilkan detail lengkap:

* Kode Produk
* Nama Produk
* Harga Produk

Termasuk tombol:

* **Edit Produk** → membuka `produk_form.dart`
* **Hapus Produk** → (siap dihubungkan API)

### AppBar:

```dart
title: const Text("Detail Produk Defit")
```

---

# 🚀 **Cara Menjalankan Aplikasi**

### 1. Install dependency:

```
flutter pub get
```

### 2. Jalankan aplikasi:

```
flutter run
```

### 3. Halaman pertama yang tampil:

👉 **Login Defit**

---

# 📌 *Catatan Penting*

* Data produk masih **statis**, belum terhubung API.
* UI mengikuti modul pertemuan 10.
* Action Bar sudah memakai nama panggilan **Defit** sesuai instruksi dosen.

---
