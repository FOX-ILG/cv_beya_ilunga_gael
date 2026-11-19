import 'package:flutter/material.dart';

class FamillePage extends StatelessWidget {
  const FamillePage({super.key});

  static const List<Map<String, String>> _membres = [
    {'nom': 'ILUNGA NKITA Jules', 'lien': 'Père', 'profession': 'Logisticien', 'image': 'assets/images/papa.jpg'},
    {'nom': 'Angel MBOMBO MWANZA', 'lien': 'Mère', 'profession': 'Commerçante', 'image': 'assets/images/maman.jpg'},
    {'nom': 'Jonathan MUTAMBAYI', 'lien': 'Frère', 'profession': 'Étudiant', 'image': 'assets/images/frere.jpg'},
    {'nom': 'Prisca NTUMBA', 'lien': 'Sœur', 'profession': 'Secrétaire', 'image': 'assets/images/soeur.jpg'},
    {'nom': 'Pascaline MISENGA', 'lien': 'Sœur', 'profession': 'Étudiante', 'image': 'assets/images/soeur2.jpg'},
    {'nom': 'Christivie MBOMBO', 'lien': 'Sœur', 'profession': 'Élève', 'image': 'assets/images/soeur3.jpg'}
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _membres.length,
      itemBuilder: (context, i) {
        final m = _membres[i];
        return Card(
          elevation: 2,
          shadowColor: Colors.indigo.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.indigo, width: 2), // Bordure sur les photos
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: AssetImage(m['image']!),
                    onBackgroundImageError: (_, __) {},
                    child: const Icon(Icons.person, size: 35, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m['nom']!, 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)
                      ),
                      const SizedBox(height: 4),
                      // CORRECTION ICI : suppression du "const" sur le TextStyle
                      Text(
                        '${m['lien']} · ${m['profession']}', 
                        style: TextStyle(color: Colors.grey[700], fontSize: 15)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}