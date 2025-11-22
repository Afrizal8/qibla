import 'package:flutter/material.dart';
import 'register_page.dart';
import 'navigation_root.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorText = "";

  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => errorText = "Email dan password harus diisi!");
      return;
    }

    if (!email.contains("@")) {
      setState(() => errorText = "Format email tidak valid!");
      return;
    }

    if (password.length < 6) {
      setState(() => errorText = "Password minimal 6 karakter!");
      return;
    }

    // Jika lolos validasi → Masuk Home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NavigationRoot()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),

              const SizedBox(height: 10),
              Text(errorText, style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: const Text("Masuk")),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
                child: const Text("Belum punya akun? Daftar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
