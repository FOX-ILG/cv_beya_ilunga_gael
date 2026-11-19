import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _lancer(BuildContext context, Uri uri, String erreur) async {
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erreur)));
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erreur)));
      }
    }
  }

  Widget _contactCard(BuildContext context, {required IconData icon, required Color color, required String titre, required String sousTitre, required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      shadowColor: Colors.indigo.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(titre, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
        subtitle: Text(sousTitre, style: TextStyle(color: Colors.grey[700])),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Mes coordonnées', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
        const SizedBox(height: 16),

        _contactCard(context, 
          icon: Icons.phone, color: Colors.green, titre: 'Téléphone', sousTitre: '+243 850 156 227', 
          onTap: () => _lancer(context, Uri.parse('tel:+243850156227'), 'Impossible d\'appeler'),
        ),
        _contactCard(context, 
          icon: Icons.email, color: Colors.blue, titre: 'E-mail', sousTitre: 'gaelilunga08@icloud.com', 
          onTap: () => _lancer(context, Uri.parse('mailto:gaelilunga08@icloud.com'), 'Aucune application email'),
        ),
        _contactCard(context, 
          icon: Icons.location_on, color: Colors.red, titre: 'Adresse', sousTitre: 'Goma, RDC', 
          onTap: () => _lancer(context, Uri.parse('https://maps.google.com/?q=Goma'), 'Impossible d\'ouvrir la carte'),
        ),

        const SizedBox(height: 24),
        const Text('Réseaux sociaux', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
        const SizedBox(height: 16),

        _contactCard(context, 
          icon: Icons.work, color: Colors.blueAccent, titre: 'LinkedIn', sousTitre: 'linkedin.com/in/gael-ilunga', 
          onTap: () => _lancer(context, Uri.parse('https://www.linkedin.com/'), 'Impossible d\'ouvrir LinkedIn'),
        ),
        _contactCard(context, 
          icon: Icons.code, color: Colors.black87, titre: 'GitHub', sousTitre: 'github.com/FOX-ILG', 
          onTap: () => _lancer(context, Uri.parse('https://github.com/'), 'Impossible d\'ouvrir GitHub'),
        ),
        _contactCard(context,
         icon: Icons.message, color: Colors.purple, titre: 'Instagram', sousTitre: 'instagram.com/gael_ilg', 
         onTap: () => _lancer(context, Uri.parse('https://www.instagram.com/'), 'Impossible d\'ouvrir Instagram'),
         ),
      ],
    );
  }
}