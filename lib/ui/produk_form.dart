import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk ?? '';
        _namaProdukTextboxController.text = widget.produk!.namaProduk ?? '';
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk?.toString() ?? '';
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(judul, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _kodeProdukTextField(),
                    const SizedBox(height: 20),
                    _namaProdukTextField(),
                    const SizedBox(height: 20),
                    _hargaProdukTextField(),
                    const SizedBox(height: 30),
                    _buttonSubmit()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGETS ---
  InputDecoration _inputDecor(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: _inputDecor("Kode Produk", Icons.qr_code),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) return "Kode Produk harus diisi";
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: _inputDecor("Nama Produk", Icons.inventory_2),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) return "Nama Produk harus diisi";
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: _inputDecor("Harga", Icons.monetization_on),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) return "Harga harus diisi";
        if (int.tryParse(value) == null) return "Harga harus berupa angka";
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(tombolSubmit,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate && !_isLoading) {
            if (widget.produk != null) {
              ubah();
            } else {
              simpan();
            }
          }
        },
      ),
    );
  }

  // --- LOGIC ---

  simpan() {
    setState(() { _isLoading = true; });
    
    Produk createProduk = Produk(id: null);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);

    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      _showWarning("Simpan gagal, silahkan coba lagi");
    });
    
    if (mounted) setState(() { _isLoading = false; });
  }

  ubah() {
    setState(() { _isLoading = true; });

    // SAFETY CHECK: Pastikan ID tidak null
    if (widget.produk!.id == null) {
        _showWarning("ID Produk tidak ditemukan!");
        setState(() { _isLoading = false; });
        return;
    }

    Produk updateProduk = Produk(id: widget.produk!.id!);
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);

    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      _showWarning("Permintaan ubah data gagal, silahkan coba lagi");
    });

    if (mounted) setState(() { _isLoading = false; });
  }

  void _showWarning(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) => WarningDialog(description: msg),
    );
  }
}