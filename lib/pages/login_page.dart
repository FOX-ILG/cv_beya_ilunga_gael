import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _chargement = false;
  String? _erreur;

  Future<void> _seConnecter() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _chargement = true; _erreur = null; });

    try {
      await ApiService.login(_emailController.text.trim(), _passController.text.trim());
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() {
        _chargement = false;
        _erreur = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.account_circle, size: 100, color: Colors.indigo),
                const SizedBox(height: 24),
                const Text('Connexion', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo)),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
                  validator: (v) => v!.isEmpty ? 'Entrez l\'email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Mot de passe', prefixIcon: Icon(Icons.lock)),
                  validator: (v) => v!.isEmpty ? 'Entrez le mot de passe' : null,
                ),
                if (_erreur != null) ...[
                  const SizedBox(height: 16),
                  Text(_erreur!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _chargement ? null : _seConnecter,
                    child: _chargement ? const CircularProgressIndicator() : const Text('Se connecter'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}