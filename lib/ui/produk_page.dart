import 'package:flutter/material.dart';
import 'package:tokokita/bloc/logout_bloc.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/login_page.dart';
import 'package:tokokita/ui/produk_detail.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Latar belakang abu-abu muda
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent, // Warna Biru Modern
        title: const Text(
          'List Produk',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add_circle_outline, size: 30.0),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProdukForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              accountName: Text("Admin Toko"),
              accountEmail: Text("admin@tokokita.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.blue),
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout, color: Colors.red),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListProduk(list: snapshot.data)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List? list;
  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10), // Jarak luar list
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemProduk(produk: list![i]);
        });
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;
  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProdukDetail(produk: produk)));
      },
      child: Card(
        elevation: 3, // Memberi efek bayangan
        margin: const EdgeInsets.symmetric(vertical: 8), // Jarak antar kartu
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.inventory_2, color: Colors.blueAccent),
          ),
          title: Text(
            produk.namaProduk!,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          subtitle: Text(
            "Rp. ${produk.hargaProduk.toString()}",
            style: const TextStyle(
                fontSize: 16, color: Colors.green, fontWeight: FontWeight.w600),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ),
      ),
    );
  }
}