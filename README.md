# cv_beya_ilunga_gael

Application mobile Flutter présentant mon CV, ma famille et mes coordonnées, avec authentification.

## Fonctionnalités

- Page de connexion (identifiant + mot de passe masqué)
- Page CV complet (photo, formation, expériences, compétences, langues, intérêts)
- Page famille (photo, nom, lien de parenté, profession)
- Page contact (téléphone, email, adresse, LinkedIn, GitHub — cliquables)
- Navigation par `BottomNavigationBar` + `Drawer`
- Déconnexion

## Vidéo de démonstration (TP2)

https://youtu.be/a8UbZL6BNFA

## Pour lancer le projet:
-Demarrer **XAMPP** (Appache + MySQL)
-Avoir le projet "api-test" dans le pc
-Avoir importer la BD "api.sql" dans MySQL
-Lancer l'appli avec "flutter dans vscode

## Identifiants de démo

- Identifiant : `gael@gmail.com`
- Mot de passe : `123456`

## Technologies

- Flutter / Dart
- Material 3
- `url_launcher`

## Captures d'écran

### Page de connexion
![Login](captures/login1.png/login2.png)

### Page CV (accueil)
![CV](captures/home1.png/home2.png/home3.png/home4.png/home5.png)

### Page Famille
![Famille](captures/famille1.png/famille2.png)

### Page Contact
![Contact](captures/contact1.png/contact2.png)

### Menu Drawer
![Drawer](captures/drawer.png)

## Installation

```bash
git clone https://github.com/TON_USERNAME/cv_beya_ilunga_gael.git
cd cv_beya_ilunga_gael
flutter pub get
flutter run