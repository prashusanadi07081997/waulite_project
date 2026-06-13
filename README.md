# Flutter Signage Player

## Overview

This project is a simple Flutter-based Signage Player application developed as part of an assessment task.

The application reads a list of media items from a JSON source and displays them one at a time in a continuous loop. Both images and videos are supported. Each media item is displayed for exactly 10 seconds before automatically moving to the next item.

The application is designed with a minimal fullscreen UI, similar to a digital signage display.

---

## Features

* Display images from network URLs
* Play videos from network URLs
* Automatic media playback
* Automatic media switching every 10 seconds
* Infinite looping of content
* Fullscreen display
* Proper video controller disposal
* Basic error handling for network content

---

## Project Structure

```text
lib/
│
├── main.dart
├── models/
│   └── media_item.dart
│
├── services/
│   └── content_service.dart
│
└── screens/
    └── signage_player_screen.dart
```

### Structure Explanation

**models/**

* Contains the MediaItem model used to parse JSON data.

**services/**

* Responsible for providing media content to the application.

**screens/**

* Contains the main signage player screen and playback logic.

---

## Approach

I intentionally avoided using any state management solution such as Provider, Bloc, Riverpod, or GetX because the assignment explicitly restricted their usage.

Instead, the application uses:

* StatefulWidget
* Timer
* setState()
* VideoPlayerController

This keeps the implementation simple while satisfying all assignment requirements.

---

## Media Playback Flow

1. Load media list from JSON.
2. Display the first item.
3. Start a 10-second timer.
4. When the timer completes:

   * Dispose the current video controller (if applicable).
   * Load the next media item.
5. Repeat until the last item.
6. Restart from the first item.

This process runs continuously.

---

## Video Handling

For video content:

* VideoPlayerController.networkUrl() is used.
* Videos are initialized automatically.
* Playback starts automatically.
* Videos are stopped after 10 seconds regardless of their actual duration.
* Existing controllers are disposed before loading a new video.

This prevents memory leaks and unnecessary resource usage.

---

## Error Handling

The application includes basic error handling:

### Image Loading

* Displays a fallback message if image loading fails.

### Video Loading

* Video initialization is wrapped with error handling.
* Failed video loads do not crash the application.

### Data Loading

* JSON parsing is protected using try-catch blocks.

---

## Assumptions

The following assumptions were made during development:

1. Media URLs provided in the JSON are publicly accessible.
2. The content list remains static during application runtime.
3. Each media item must be displayed for exactly 10 seconds, even if a video duration is shorter or longer.
4. Network connectivity is available while the application is running.
5. The provided JSON source is valid.

---

## Packages Used

### video_player

Used for network video playback.

```yaml
dependencies:
  video_player: ^2.x.x
```

---

## How to Run

### 1. Clone the Repository

```bash
git clone <repository-url>
```

### 2. Navigate to Project

```bash
cd flutter_signage_player
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run Application

Android:

```bash
flutter run
```

Web:

```bash
flutter run -d chrome
```

Release APK:

```bash
flutter build apk --release
```

---

## Future Improvements

If this project were to be extended further, I would consider:

* API-based content fetching
* Content caching
* Offline support
* Playlist scheduling
* Content preloading
* Background media downloading
* Logging and analytics
* Remote content updates

---

## Author

Developed using Flutter as part of the Signage Player assessment.

The focus of this implementation was clean code structure, proper resource management, media playback handling, and adherence to the assignment constraints.
