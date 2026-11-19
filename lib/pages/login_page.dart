import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passController = TextEditingController();

  bool _masquer = true;
  String? _erreur;

  static const String _idValide = 'gael';
  static const String _mdpValide = '1234';

  @override
  void dispose() {
    _idController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _seConnecter() {
    if (!_formKey.currentState!.validate()) return;

    if (_idController.text.trim() == _idValide &&
        _passController.text.trim() == _mdpValide) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _erreur = 'Identifiant ou mot de passe incorrect';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE8EAF6), Colors.white], // Dégradé du bleu clair vers le blanc
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.account_circle, size: 90, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(height: 24),
                    Text('Connexion', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.indigo)),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _idController,
                      decoration: const InputDecoration(
                        labelText: 'Identifiant',
                        prefixIcon: Icon(Icons.person, color: Colors.indigo),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Entrez votre identifiant' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passController,
                      obscureText: _masquer,
                      onFieldSubmitted: (_) => _seConnecter(),
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        prefixIcon: const Icon(Icons.lock, color: Colors.indigo),
                        suffixIcon: IconButton(
                          icon: Icon(_masquer ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                          onPressed: () => setState(() => _masquer = !_masquer),
                        ),
                      ),
                      validator: (v) => (v == null || v.isEmpty) ? 'Entrez votre mot de passe' : null,
                    ),
                    if (_erreur != null) ...[
                      const SizedBox(height: 16),
                      Text(_erreur!, style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold)),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                        ),
                        onPressed: _seConnecter,
                        child: const Text('Se connecter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}