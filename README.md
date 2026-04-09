# Flutter Text Spinner

A Flutter app that renders user text in a 3D spinning animation with a modern, dark-themed UI.

## Overview

`Flutter Text Spinner` lets users enter text on a landing screen and view it animated in a rotating 3D ring. The app uses custom transitions, gradient text styling, and smooth motion to create a kinetic text effect.

## Features

- Animated home screen with fade-in, staggered reveals, and glow effects
- Input-driven spinner experience (minimum 6 characters required)
- 3D rotating text ring built with `Matrix4` transforms and `vector_math`
- Clean architecture split into `models`, `viewmodels`, `views/components`, and `views/screens`
- Custom typography using `google_fonts`
- Portrait-only orientation for consistent presentation

## Tech Stack

- Flutter
- Dart
- `google_fonts`
- `vector_math`

## Getting Started

### Prerequisites

- Flutter SDK installed
- A connected device, simulator, or emulator

### Run Locally

```bash
git clone https://github.com/talh-a13/Flutter-Text-Spinner.git
cd Flutter-Text-Spinner
flutter pub get
flutter run
```

## Project Structure

```text
lib/
  main.dart
  models/
    spinner_model.dart
  viewmodels/
    home_viewmodel.dart
    spinner_viewmodel.dart
  views/
    components/
      spintext_widget.dart
      torch_overlay.dart
    screens/
      home_screen.dart
      spinner_screen.dart
```

## How It Works

1. Enter text on the home screen.
2. Tap **Spin Text** (enabled when input length is at least 6).
3. The app navigates to the spinner screen and animates your text in a continuous 3D loop.

## Credits

- Tutorial inspiration: https://www.youtube.com/watch?v=cJFWEZ3FVpo&t=2565s
- Related article: https://fidev.io/kinetic-poster/

## License

This project is available for learning and experimentation.
