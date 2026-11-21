import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class AjouterMembrePage extends StatefulWidget {
  final Map<String, dynamic>? membre;
  const AjouterMembrePage({super.key, this.membre});

  @override
  State<AjouterMembrePage> createState() => _AjouterMembrePageState();
}

class _AjouterMembrePageState extends State<AjouterMembrePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nom;
  late TextEditingController _postnom;
  late TextEditingController _prenom;
  late TextEditingController _lieu;
  late TextEditingController _date;
  late TextEditingController _parente;
  
  File? _imageFile; // Pour stocker l'image choisie

  @override
  void initState() {
    super.initState();
    _nom = TextEditingController(text: widget.membre?['nom'] ?? '');
    _postnom = TextEditingController(text: widget.membre?['postnom'] ?? '');
    _prenom = TextEditingController(text: widget.membre?['prenom'] ?? '');
    _lieu = TextEditingController(text: widget.membre?['lieu_naissance'] ?? '');
    _date = TextEditingController(text: widget.membre?['date_naissance'] ?? '');
    _parente = TextEditingController(text: widget.membre?['parente'] ?? '');
  }

  // Fonction pour choisir une image
  Future<void> _choisirImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _sauvegarder() async {
    if (!_formKey.currentState!.validate()) return;
    
    try {
      if (widget.membre == null) {
        await ApiService.addMembre(
          nom: _nom.text, postnom: _postnom.text, prenom: _prenom.text,
          lieuNaissance: _lieu.text, dateNaissance: _date.text, parente: _parente.text,
          image: _imageFile,
        );
      } else {
        await ApiService.updateMembre(
          id: widget.membre!['id'],
          nom: _nom.text, postnom: _postnom.text, prenom: _prenom.text,
          lieuNaissance: _lieu.text, dateNaissance: _date.text, parente: _parente.text,
          image: _imageFile,
        );
      }
      
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.membre != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Modifier un membre' : 'Ajouter un membre')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Le sélecteur d'image
              Center(
                child: GestureDetector(
                  onTap: _choisirImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                    child: _imageFile == null 
                        ? const Icon(Icons.camera_alt, size: 40, color: Colors.white) 
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(child: Text("Appuyez pour ajouter une photo (Optionnel)", style: TextStyle(color: Colors.grey, fontSize: 12))),
              const SizedBox(height: 16),
              
              TextFormField(controller: _nom, decoration: const InputDecoration(labelText: 'Nom'), validator: (v) => v!.isEmpty ? 'Requis' : null),
              TextFormField(controller: _postnom, decoration: const InputDecoration(labelText: 'Postnom'), validator: (v) => v!.isEmpty ? 'Requis' : null),
              TextFormField(controller: _prenom, decoration: const InputDecoration(labelText: 'Prénom'), validator: (v) => v!.isEmpty ? 'Requis' : null),
              TextFormField(controller: _lieu, decoration: const InputDecoration(labelText: 'Lieu de naissance'), validator: (v) => v!.isEmpty ? 'Requis' : null),
              TextFormField(controller: _date, decoration: const InputDecoration(labelText: 'Date (AAAA-MM-JJ)', hintText: '1990-01-01'), validator: (v) => v!.isEmpty ? 'Requis' : null),
              TextFormField(controller: _parente, decoration: const InputDecoration(labelText: 'Parenté (Père, Mère...)'), validator: (v) => v!.isEmpty ? 'Requis' : null),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sauvegarder, 
                child: Text(isEdit ? 'Enregistrer les modifications' : 'Ajouter le membre')
              ),
            ],
          ),
        ),
      ),
    );
  }
}