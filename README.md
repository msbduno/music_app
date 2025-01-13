# music_app

# Music App

## Description
A Flutter application for discovering and exploring music using the Discogs API.

## Features
- Real-time artist search
- iOS native UI (Cupertino style)
- Artist releases exploration
- Video playback for releases
- Recent search history
- Artist cover image display

## Tech Stack
- Flutter
- Bloc/Cubit for state management
- Discogs API
- SharedPreferences
- Provider for dependency injection

## Development Environment
- Flutter: 3.27.1 (Channel stable)
- Xcode: 16.1
- Android SDK: 35.0.0
- Android Studio: 2024.2
- VS Code: 1.96.2
- IntelliJ IDEA Ultimate: 2024.3.1.1
- OS: macOS 14.5 (darwin-arm64)

## Prerequisites
- Flutter SDK (3.27.1+)
- Xcode 16.1+ for iOS development
- Android Studio or VS Code with Flutter/Dart extensions
- Discogs API key

## Installation
```bash
# Clone the repository
git clone https://github.com/msbduno/music_app.git
cd music_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## Project Structure
```
music_app/
├── lib/
│   ├── blocs/       # Cubits for state management
│   ├── models/      # Data models
│   ├── repositories/# API calls
│   ├── services/    # Business services
│   ├── states/      # Cubit states
│   └── ui/
│       ├── screens/ # Main screens
│       └── widgets/ # Reusable components
```

## Main Screens
- `HomeScreen`: Recent searches display
- `SearchView`: Artist search interface
- `ReleasesView`: Artist releases list
- `VideosView`: Video player for releases


## Flutter Doctor Summary
```
[✓] Flutter (Channel stable, 3.27.1, on macOS 14.5 23F79 darwin-arm64, locale fr-FR)
[✓] Android toolchain - develop for Android devices (Android SDK version 35.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 16.1)
[✗] Chrome - develop for the web
[✓] Android Studio (version 2024.2)
[✓] IntelliJ IDEA Ultimate Edition (version 2024.3.1.1)
[✓] VS Code (version 1.96.2)
[✓] Connected device (3 available)
[✓] Network resources
```