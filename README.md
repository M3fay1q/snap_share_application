# SnapShare Application

SnapShare is a Flutter application that allows users to register, log in, and share images. It integrates Firebase for authentication, storage, and Firestore for data management. Users can upload images, view them in a grid, and zoom in/out for a detailed view.

## Features

- **Sign Up & Login:** Firebase Authentication for user management.
- **Image Management:** Upload, view, and share images.
- **Image Compression:** Compress images before uploading.
- **Image Viewing:** Full-screen view with zoom functionality.
- **Shimmer Effect:** Loading state with shimmer effect on the grid.

## Screens

- **Sign Up Screen:** For user registration.
- **Sign In Screen:** For user login.
- **Home Screen:** Displays uploaded images in a grid view.
- **Photo View Screen:** Full-screen image view with zoom and pan capabilities.

## Installation

1. **Clone the Repository:**
    ```bash
    git clone https://github.com/your-username/snapshare-application.git
    ```
2. **Navigate to the Project Directory:**
    ```bash
    cd snapshare-application
    ```
3. **Install Dependencies:**
    Make sure you have Flutter installed. Run:
    ```bash
    flutter pub get
    ```

4. **Set Up Firebase:**
    - Go to the [Firebase Console](https://console.firebase.google.com/).
    - Create a new project or use an existing one.
    - Add Firebase Authentication, Firestore, and Firebase Storage to your project.
    - Download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) and place them in the respective directories:
      - Android: `android/app/`
      - iOS: `ios/Runner/`

5. **Configure Firebase in Your App:**
    - Ensure you have the necessary configuration for Firebase in your `android/app/build.gradle` and `ios/Podfile`.

## Usage

1. **Run the App:**
    ```bash
    flutter run
    ```

2. **Sign Up:**
    - Enter your email and password to register a new account.

3. **Sign In:**
    - Use your registered email and password to log in.

4. **Upload Images:**
    - Use the floating action button or the bottom sheet to pick an image from the gallery or camera.
    - Images will be uploaded to Firebase Storage and displayed in the grid on the Home Screen.

5. **View Images:**
    - Tap on an image in the grid to view it in full-screen mode.
    - Use pinch-to-zoom and pan gestures to interact with the image.

6. **Share Images:**
    - Tap on the share icon on an image to share it using the Share functionality.

7. **Logout:**
    - Use the logout option to sign out of the application.

## Packages Used

- `get: ^4.6.6`
- `firebase_core: ^3.4.1`
- `firebase_auth: ^5.2.1`
- `firebase_storage: ^12.3.0`
- `cloud_firestore: ^5.4.1`
- `image_picker: ^1.1.2`
- `flutter_image_compress: ^2.3.0`
- `photo_view: ^0.15.0`
- `share_plus: ^7.0.0`
- `path_provider: ^2.1.4`
- `shimmer: ^3.0.0`



