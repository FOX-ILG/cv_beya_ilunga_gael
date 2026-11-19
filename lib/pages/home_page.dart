import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.indigo, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.transparent,
              backgroundImage: const AssetImage('assets/images/profil.jpg'),
              onBackgroundImageError: (_, __) {},
              child: const Icon(Icons.person, size: 60),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Gael BEYA ILUNGA', textAlign: TextAlign.center, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.indigo)),
        Text('Etudiant en informatique, LIC4-LGL', textAlign: TextAlign.center, style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[700], fontWeight: FontWeight.w500)),
        const SizedBox(height: 24),

        _section(theme, 'Profil', const Text('Développeur mobile et web passionné, spécialisé en Flutter. J\'aime concevoir des interfaces propres, performantes et accessibles.', style: TextStyle(height: 1.5))),
        const SizedBox(height: 12),

        _section(theme, 'Formation', Column(
          children: [
            const ListTile(
              leading: Icon(Icons.school, color: Colors.indigo),
              title: Text('Licence Informatique', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Institut Superieur d\'Informatique et de Gestio — 2023 à aujourd\'hui'),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.school_outlined, color: Colors.indigo),
              title: Text('Baccalauréat scientifique', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Institut Mwanga — 2023'),
            ),
          ],
        )),
        const SizedBox(height: 12),

        _section(theme, 'Expériences', Column(
          children: [
            const ListTile(
              leading: Icon(Icons.work, color: Colors.indigo),
              title: Text('Développeur Flutter — Stage', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Cours de Programmation Mobile'),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.work_outline, color: Colors.indigo),
              title: Text('Projet : App de gestion de stock', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Projet personnel réalisé avec Flutter et Firebase'),
            ),
            // CORRECTION ICI : j'ai ajouté la virgule manquante ci-dessous
            const Divider(), 
            const ListTile(
              leading: Icon(Icons.work_outline, color: Colors.indigo),
              title: Text('Stage : Creation d\'application', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Stage de 15 jours chez Afrix, développement d\'une application mobile pour la gestion des tâches'),
            ),
          ],
        )),
        const SizedBox(height: 12),

        _section(theme, 'Compétences techniques', Wrap(
          spacing: 8, runSpacing: 8,
          children: const [
            Chip(label: Text('Flutter'), backgroundColor: Color(0xFFE8EAF6), labelStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)), 
            Chip(label: Text('Python'), backgroundColor: Color(0xFFE8EAF6), labelStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)), 
            Chip(label: Text('C++'), backgroundColor: Color(0xFFE8EAF6), labelStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
            Chip(label: Text('Git / GitHub'), backgroundColor: Color(0xFFE8EAF6), labelStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)), 
            Chip(label: Text('UI/UX'), backgroundColor: Color(0xFFE8EAF6), labelStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)), 
            Chip(label: Text('REST API'), backgroundColor: Color(0xFFE8EAF6), labelStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
          ],
        )),
        const SizedBox(height: 12),

        _section(theme, 'Langues', Column(
          children: [
            const ListTile(leading: Icon(Icons.language, color: Colors.indigo), title: Text('Français', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('Langue maternelle')),
            const ListTile(leading: Icon(Icons.language, color: Colors.indigo), title: Text('Anglais', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('Intermédiaire')),
            const ListTile(leading: Icon(Icons.language, color: Colors.indigo), title: Text('Lingala', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('Courant')),
            const ListTile(leading: Icon(Icons.language, color: Colors.indigo), title: Text('Swahili', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('Courant')),
            const ListTile(leading: Icon(Icons.language, color: Colors.indigo), title: Text('Tshiluba', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('Langue maternelle')),
          ],
        )),
        const SizedBox(height: 24),

        _section(theme, 'Centres d\'intérêt', Wrap(
          spacing: 8, runSpacing: 8,
          children: const [
            Chip(label: Text('Programmation'), backgroundColor: Color(0xFFE8EAF6), labelStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)), 
            Chip(label: Text('Musique'), backgroundColor: Color(0xFFE8EAF6), labelStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
            Chip(label: Text('Basketball'), backgroundColor: Color(0xFFE8EAF6), labelStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)), 
            Chip(label: Text('Lecture'), backgroundColor: Color(0xFFE8EAF6), labelStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
          ],
        )),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _section(ThemeData theme, String titre, Widget contenu) {
    return Card(
      elevation: 2,
      shadowColor: Colors.indigo.withValues(alpha: 0.2), 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titre, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.indigo)),
            const SizedBox(height: 12),
            contenu,
          ],
        ),
      ),
    );
  }
}