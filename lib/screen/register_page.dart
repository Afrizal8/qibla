import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  String errorText = "";

  void _register() {
    String email = emailController.text.trim();
    String pass = passController.text.trim();
    String confirm = confirmPassController.text.trim();

    if (!email.contains("@")) {
      setState(() => errorText = "Email tidak valid!");
      return;
    }

    if (pass.length < 6) {
      setState(() => errorText = "Password minimal 6 karakter!");
      return;
    }

    if (pass != confirm) {
      setState(() => errorText = "Konfirmasi password tidak sama!");
      return;
    }

    Navigator.pop(context); // kembali ke login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            TextField(
              controller: confirmPassController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Konfirmasi Password",
              ),
            ),

            const SizedBox(height: 10),
            Text(errorText, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: const Text("Daftar")),
          ],
        ),
      ),
    );
  }
}
