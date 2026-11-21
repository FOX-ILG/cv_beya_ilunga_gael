import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'ajouter_membre_page.dart';

class FamillePage extends StatefulWidget {
  const FamillePage({super.key});

  @override
  State<FamillePage> createState() => _FamillePageState();
}

class _FamillePageState extends State<FamillePage> {
  late Future<List<dynamic>> _familleFuture;

  @override
  void initState() {
    super.initState();
    _chargerFamille();
  }

  void _chargerFamille() {
    setState(() {
      _familleFuture = ApiService.getFamille();
    });
  }

  void _supprimer(int id) async {
    await ApiService.deleteMembre(id);
    _chargerFamille();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Membre supprimé')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _familleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          
          final membres = snapshot.data ?? [];
          if (membres.isEmpty) {
            return const Center(child: Text('Aucun membre'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: membres.length,
            itemBuilder: (context, i) {
              final m = membres[i];
              
              // Gestion de l'image (si l'API renvoie un chemin)
              String? imageUrl;
              if (m['image'] != null && m['image'].toString().isNotEmpty) {
                // On suppose que l'API renvoie le chemin de l'image
                imageUrl = '${ApiService.baseUrl.replaceAll('/api-test/public', '')}/api-test/public/uploads/${m['image']}'; 
              }

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.indigo.withValues(alpha: 0.1),
                    backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                    child: imageUrl == null ? const Icon(Icons.person, color: Colors.indigo) : null,
                  ),
                  title: Text(
                    '${m['nom']} ${m['postnom']} ${m['prenom']}', 
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  subtitle: Text('${m['parente']} · ${m['lieu_naissance']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AjouterMembrePage(membre: m),
                            ),
                          );
                          if (result == true) _chargerFamille();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _supprimer(m['id']),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AjouterMembrePage()),
          );
          if (result == true) _chargerFamille();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}