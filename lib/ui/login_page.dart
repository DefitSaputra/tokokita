import 'package:flutter/material.dart';
import 'package:tokokita/bloc/login_bloc.dart';
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Icon(
                  Icons.storefront,
                  size: 100,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 20),
                const Text(
                  "TokoKita",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                const SizedBox(height: 40),
                _emailTextField(),
                const SizedBox(height: 20),
                _passwordTextField(),
                const SizedBox(height: 30),
                _buttonLogin(),
                const SizedBox(height: 30),
                _menuRegistrasi()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Dekorasi Input
  InputDecoration _inputDecor(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: _inputDecor("Email", Icons.email),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: _inputDecor("Password", Icons.lock),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonLogin() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text("LOGIN",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) _submit();
          }
        },
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ProdukPage()));
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const WarningDialog(
                  description: "Login gagal, silahkan coba lagi",
                ));
      }
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login gagal, silahkan coba lagi",
              ));
    });

    setState(() {
      _isLoading = false;
    });
  }

  Widget _menuRegistrasi() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Belum punya akun? ", style: TextStyle(color: Colors.grey)),
          InkWell(
            child: const Text(
              "Registrasi",
              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrasiPage()));
            },
          ),
        ],
      ),
    );
  }
}