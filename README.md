# Location Tracking Module – PickMyTask Flutter Intern Assessment

This Flutter app implements a location tracking module using **MVVM** architecture and **Provider** for state management.

## Features

- Location permission handling (coarse/fine)
- Show current coordinates (lat/lng), city, state, pincode
- Auto-updates when user moves
- Location history with timestamps
- In-memory state (no DB)
- Google Geocoding API for reverse geocoding
- Optional map view with marker (Google Maps)

## Tech Stack

- Flutter, Dart
- MVVM + Provider (`ChangeNotifier`)
- `geolocator` + `permission_handler` for location & permissions
- `google_maps_flutter` for map view
- Google Geocoding API via `http`

## How My Experience Helped

I’ve previously worked with Flutter, REST APIs, and state management in production-like apps (event apps, IoT app). That experience helped in:
- Structuring the app with MVVM and clean folder separation
- Handling async APIs and location streams
- Designing a clean and responsive UI suitable for real users
