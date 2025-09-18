Legal_AI Flutter project

This is a minimal Flutter project scaffold created to match the original web app design and functionality.
It includes:
 - Splash screen with logo
 - Home screen to send queries to local FastAPI backend and display multiple answers
 - History screen (saved locally with shared_preferences)
 - About screen

How to run:
1. Install Flutter SDK and Android Studio (with Flutter & Dart plugins).
2. Open this folder in Android Studio (Open an existing Flutter project).
3. Run: flutter pub get
4. Update the API_BASE_URL in lib/config.dart to point to your PC IP, example: http://192.168.1.50:8000
5. Run the app on an emulator or device.
