import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api-test/public';

  // 1. Connexion
  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/accounts/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('Email ou mot de passe incorrect');
  }

  // 2. Lister les membres
  static Future<List<dynamic>> getFamille() async {
    final response = await http.get(Uri.parse('$baseUrl/famille-membres'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'] ?? [];
    }
    throw Exception('Erreur lors du chargement de la famille');
  }

  // 3. Ajouter un membre (avec image optionnelle)
  static Future<void> addMembre({
    required String nom,
    required String postnom,
    required String prenom,
    required String lieuNaissance,
    required String dateNaissance,
    required String parente,
    File? image,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/famille-membres'));
    
    request.fields['nom'] = nom;
    request.fields['postnom'] = postnom;
    request.fields['prenom'] = prenom;
    request.fields['lieu_naissance'] = lieuNaissance;
    request.fields['date_naissance'] = dateNaissance;
    request.fields['parente'] = parente;

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    var response = await request.send();
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erreur lors de l\'ajout');
    }
  }

  // 4. Modifier un membre (avec image optionnelle)
  static Future<void> updateMembre({
    required int id,
    required String nom,
    required String postnom,
    required String prenom,
    required String lieuNaissance,
    required String dateNaissance,
    required String parente,
    File? image,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/famille-membres/$id'));
    
    // L'API utilise POST avec _method=PUT pour envoyer des fichiers en modification
    request.fields['_method'] = 'PUT'; 
    request.fields['nom'] = nom;
    request.fields['postnom'] = postnom;
    request.fields['prenom'] = prenom;
    request.fields['lieu_naissance'] = lieuNaissance;
    request.fields['date_naissance'] = dateNaissance;
    request.fields['parente'] = parente;

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la modification');
    }
  }

  // 5. Supprimer un membre
  static Future<void> deleteMembre(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/famille-membres/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la suppression');
    }
  }
}