# StreamStreak

StreamStreak is a Flutter application for managing live streams. It allows users to create, edit, and delete live streams, and provides features such as metadata fetching and thumbnail uploading.

## Features

- Create new live streams with metadata fetching
- Edit existing live streams
- Delete live streams
- Search for streams by name
- Shimmer effect while searching
- User authentication and management
- Cloudinary integration for image uploads
- Firebase integration for data storage

## Screenshots

<p align="center">
  <img src="ScreenShots/Live Stream 1.png" alt="Live Stream Page" width="300" />
  <img src="ScreenShots/Live Straeam 2 (OverLay).png" alt="Stream Overlay" width="300" />
  <img src="ScreenShots/Lve Streeam 4 (Home Page).png" alt="Home Page" width="300" />
  <img src="ScreenShots/Live Stream 3 (CreateStream).png" alt="Create Stream Page" width="300" />
  <img src="ScreenShots/Live Stream (Edit Stream).png" alt="Edit Stream Page" width="300" />
  <img src="ScreenShots/Live Stream (Swipe to delete).png" alt="Swipe to Delete" width="300" />
  <img src="ScreenShots/Live Stream (Search).png" alt="Search Stream" width="300" />
</p>

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Firebase account
- Cloudinary account

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/streamstreak.git
    cd streamstreak
    ```

2. Install dependencies:
    ```sh
    flutter pub get
    ```

3. Set up Firebase:
   - Follow the instructions to add Firebase to your Flutter project: [Firebase Setup](https://firebase.flutter.dev/docs/overview)
   - Add your `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) to the respective directories.

4. Set up Cloudinary:
   - Create a `lib/Config/Keys.dart` file with your Cloudinary credentials:
    ```dart
    final String cloudinaryUrl = "https://api.cloudinary.com/v1_1/YOUR_CLOUD_NAME/image/upload";
    final String uploadPreset = "YOUR_UPLOAD_PRESET";
    const cloudName = "YOUR_CLOUD_NAME";
    ```

### Running the App

1. Run the app on an emulator or physical device:
    ```sh
    flutter run
    ```

## Usage

- **Create Stream**: Tap the "+" button on the homepage to create a new stream.
- **Edit Stream**: Tap on an existing stream to edit its details.
- **Delete Stream**: Swipe left on a stream to delete it.
- **Search Stream**: Use the search bar to filter streams by name.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Cloudinary](https://cloudinary.com/)
- [GetX](https://pub.dev/packages/get)
- [Shimmer](https://pub.dev/packages/shimmer)
