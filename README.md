#  Projet : music_app

## Mathis GUILLOU & Mathis BOSSARD

## Description
Une application Flutter pour découvrir et explorer la musique en utilisant l'API Discogs.

## Fonctionnalités
- Recherche d'artistes en temps réel
- Interface utilisateur iOS native (style Cupertino)
- Exploration des sorties d'artistes
- Lecture de vidéos pour les sorties
- Historique des recherches récentes
- Affichage des images de couverture des artistes

## Stack Technique
- Flutter
- Bloc/Cubit pour la gestion d'état
- API Discogs
- SharedPreferences
- Provider pour l'injection de dépendances

## Environnement de Développement
- Flutter : 3.27.1 (Canal stable)
- Xcode : 16.1
- Android SDK : 35.0.0
- Android Studio : 2024.2
- VS Code : 1.96.2
- IntelliJ IDEA Ultimate : 2024.3.1.1
- OS : macOS 14.5 (darwin-arm64)

## Prérequis
- Flutter SDK (3.27.1+)
- Xcode 16.1+ pour le développement iOS
- Android Studio ou VS Code avec les extensions Flutter/Dart
- Clé API Discogs

## Installation
```bash
# Cloner le dépôt
git clone https://github.com/msbduno/music_app.git
cd music_app

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
```

## Structure du Projet
```
music_app/
├── lib/
│   ├── blocs/       # Cubits pour la gestion d'état
│   ├── models/      # Modèles de données
│   ├── repositories/# Appels API
│   ├── services/    # Services métier
│   ├── states/      # États des Cubits
│   └── ui/
│       ├── screens/ # Écrans principaux
│       └── widgets/ # Composants réutilisables
```

## Écrans Principaux
- `HomeScreen` : Affichage des recherches récentes
- `SearchView` : Interface de recherche d'artistes
- `ReleasesView` : Liste des sorties d'artistes
- `VideosView` : Lecteur vidéo pour les sorties


## Résumé Flutter Doctor
```
[✓] Flutter (Canal stable, 3.27.1, sur macOS 14.5 23F79 darwin-arm64, locale fr-FR)
[✓] Chaîne d'outils Android - développement pour appareils Android (version SDK Android 35.0.0)
[✓] Xcode - développement pour iOS et macOS (Xcode 16.1)
[✗] Chrome - développement pour le web
[✓] Android Studio (version 2024.2)
[✓] IntelliJ IDEA Ultimate Edition (version 2024.3.1.1)
[✓] VS Code (version 1.96.2)
[✓] Appareil connecté (3 disponibles)
[✓] Ressources réseau
```
## Visuels 
### Home Page
![IMG_2708](https://github.com/user-attachments/assets/79893597-9d94-459f-b6c0-0b84694175af)
### Search Page
![IMG_2711](https://github.com/user-attachments/assets/2fd59c43-dc04-4bd4-9c9a-2b3fbca81dca)
### Release Page 
![IMG_2710](https://github.com/user-attachments/assets/7ba6190f-6c1a-4581-8152-a69d715d7cc7)
### Videos Page
![IMG_2709](https://github.com/user-attachments/assets/d09ed602-244f-420d-acd3-9190ecafe924)



