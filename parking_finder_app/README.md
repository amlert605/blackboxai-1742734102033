# Parking Finder App

A Flutter application that helps users find nearby parking spots using real-time location tracking and Google Maps integration.

## Features

- User Authentication (Sign up/Login)
- Real-time Location Tracking
- Interactive Map with Parking Spots
- Detailed Parking Information
- Modern Material Design UI

## Prerequisites

Before running the application, make sure you have:

1. Flutter SDK installed (latest version)
2. Firebase project set up
3. Google Maps API key
4. Android Studio or VS Code with Flutter extensions

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd parking_finder_app
```

### 2. Firebase Setup

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Add an Android app to your Firebase project
3. Download the `google-services.json` file and place it in `android/app/`
4. Enable Email/Password authentication in Firebase Console

### 3. Google Maps Setup

1. Get a Google Maps API key from [Google Cloud Console](https://console.cloud.google.com)
2. Replace `YOUR_GOOGLE_MAPS_API_KEY` in `android/app/src/main/AndroidManifest.xml` with your actual API key

### 4. Install Dependencies

```bash
flutter pub get
```

### 5. Run the App

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart
├── models/
│   └── parking.dart
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   └── map_screen.dart
├── services/
│   ├── auth_service.dart
│   └── location_service.dart
└── widgets/
    ├── loading_indicator.dart
    └── parking_detail_dialog.dart
```

## Dependencies

- `firebase_core`: Firebase initialization
- `firebase_auth`: User authentication
- `google_maps_flutter`: Google Maps integration
- `geolocator`: Location services
- `provider`: State management
- `cloud_firestore`: Database (optional)

## Contributing

1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter Team
- Firebase
- Google Maps Platform

## Support

For support, email support@parkingfinder.com or create an issue in the repository.