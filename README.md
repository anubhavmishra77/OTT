# FlickTV - OTT App Prototype

A Flutter-based OTT (Over-the-Top) video streaming application with a Netflix-style interface and reels-style video player interaction.

## Features

- **Netflix-style Home Page**: Vertically scrolling interface with multiple horizontally scrolling carousels
- **Reels-style Video Player**: Full-screen video player with vertical swipe navigation
- **Clean UI**: Modern, dark theme with intuitive user interface
- **GetX State Management**: Efficient state management using GetX
- **Better Player Plus**: High-quality video playback with customizable controls
- **Cached Network Images**: Optimized image loading with caching

## Screenshots

### Home Page
- Multiple categories with horizontal scrolling video thumbnails
- Netflix-style layout with ratings and duration
- Clean, modern dark theme

### Video Player
- Full-screen video playback
- Vertical swipe navigation (like reels/shorts)
- Video information overlay
- Play/pause, next/previous controls
- Share and favorite functionality

## Technical Stack

- **Framework**: Flutter (Latest stable version)
- **State Management**: GetX
- **Video Player**: Better Player Plus
- **Image Caching**: Cached Network Image
- **Architecture**: GetX Pattern (Controller-View-Binding)

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── routes/
│   └── app_routes.dart      # Route configuration
├── controllers/
│   ├── home_controller.dart # Home page logic
│   └── video_player_controller.dart # Video player logic
├── views/
│   ├── home_view.dart       # Netflix-style home page
│   └── video_player_view.dart # Reels-style video player
├── models/
│   ├── video.dart          # Video data model
│   └── category.dart       # Category data model
├── services/
│   └── data_service.dart   # Data loading service
├── bindings/
│   ├── home_binding.dart   # Home page dependency injection
│   └── video_player_binding.dart # Video player dependency injection
└── assets/
    └── data/
        └── mock_data.json  # Mock video data
```

## Setup Instructions

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio or VS Code with Flutter extensions
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flicktv_assignment
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building APK

To build a release APK:

```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/flutter-apk/app-release.apk`

## Data Source

The app uses a local JSON file (`assets/data/mock_data.json`) containing mock video data with:
- Multiple categories (Trending, Action, Comedy, Drama, Sci-Fi)
- Video metadata (title, description, thumbnail, video URL, duration, rating)
- High-quality thumbnail images from Unsplash
- Sample video URLs from Google's test video repository

## Key Features Implementation

### Home Page (Netflix-style)
- Vertical scrolling main container
- Horizontal scrolling carousels for each category
- Video thumbnails with metadata overlay
- Pull-to-refresh functionality
- Error handling and loading states

### Video Player (Reels-style)
- Full-screen video playback
- Vertical PageView for swipe navigation
- Auto-play functionality
- Video information overlay
- Play/pause, next/previous controls
- Share and favorite buttons
- Smooth transitions between videos

### State Management
- GetX reactive state management
- Proper controller lifecycle management
- Efficient memory usage
- Clean separation of concerns

## Customization

### Adding New Videos
Edit `assets/data/mock_data.json` to add new categories or videos:

```json
{
  "categories": [
    {
      "id": 1,
      "name": "Your Category",
      "videos": [
        {
          "id": 1,
          "title": "Video Title",
          "description": "Video description",
          "thumbnail": "thumbnail URL",
          "videoUrl": "video URL",
          "duration": "duration",
          "rating": 8.5
        }
      ]
    }
  ]
}
```

### Theme Customization
Modify the theme in `lib/main.dart` to customize colors, fonts, and other UI elements.

## Performance Considerations

- **Lazy Loading**: Videos are loaded only when needed
- **Memory Management**: Proper disposal of video controllers
- **Image Caching**: Efficient image loading with caching
- **State Optimization**: Reactive state updates only when necessary

## Known Issues

- Video loading may take time depending on network connection
- Some video URLs may not work due to CORS restrictions
- Better Player Plus may have compatibility issues with certain video formats

## Future Enhancements

- Search functionality
- User authentication
- Offline video download
- Push notifications
- Social sharing integration
- Advanced video player controls
- Content recommendations

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  get: ^4.6.6
  better_player_plus: ^1.0.8
  http: ^1.1.0
  cached_network_image: ^3.3.1
```

## License

This project is developed as part of a Flutter assignment and is for educational purposes.

## Support

For any issues or questions, please create an issue in the repository or contact the development team.
