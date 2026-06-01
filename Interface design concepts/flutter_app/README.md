# Donation & Emergency Aid - Flutter Mobile App

A complete Flutter mobile application for the Donation & Emergency Aid system.

## Features

### For Donors
- **Home Screen**: View nearby emergency requests with real-time updates
- **Map View**: Interactive map showing emergencies with color-coded urgency levels
- **Notifications**: Real-time alerts for emergency requests and achievements
- **Profile**: Manage donor profile, view statistics, and track impact

### For Requesters
- **Home Screen**: Quick access to emergency SOS button and request history
- **Emergency Form**: Multi-step form to submit emergency requests
- **Request Tracking**: Track active requests with donor ETA and QR verification

## Project Structure

```
lib/
├── main.dart                           # App entry point
├── screens/
│   ├── platform_selection_screen.dart  # Choose Mobile/Desktop
│   ├── role_selection_screen.dart      # Choose Donor/Requester
│   ├── donor/
│   │   ├── donor_main_screen.dart      # Donor bottom navigation
│   │   ├── donor_home_screen.dart      # Donor home with requests
│   │   ├── donor_map_screen.dart       # Interactive map view
│   │   ├── donor_notifications_screen.dart  # Alerts & notifications
│   │   └── donor_profile_screen.dart   # Profile & settings
│   └── requester/
│       ├── requester_main_screen.dart  # Requester bottom navigation
│       ├── requester_home_screen.dart  # Requester home
│       └── emergency_form_screen.dart  # Emergency request form
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Install dependencies:
```bash
cd flutter_app
flutter pub get
```

2. Run the app:
```bash
flutter run
```

### Build for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Design System

### Colors
- **Primary Red**: `#DC2626` - Emergency actions, critical alerts
- **Secondary Orange**: `#EA580C` - High priority requests
- **Amber**: `#D97706` - Medium urgency
- **Green**: `#16A34A` - Success, completed requests
- **Blue**: `#2563EB` - Information, navigation

### Typography
- **Headers**: Bold, 20-24px
- **Body**: Regular, 14-16px
- **Captions**: 12px

## Key Screens

1. **Platform Selection**: Choose between Mobile App or Desktop View
2. **Role Selection**: Select Donor or Requester role
3. **Donor Dashboard**: Real-time emergency feed with match scores
4. **Emergency Map**: Interactive map with distance rings and pins
5. **Notifications**: Categorized alerts with action buttons
6. **Profile**: User info, stats, and settings
7. **Emergency Form**: Step-by-step emergency request submission

## Future Enhancements
- Firebase integration for real-time data
- Google Maps SDK for actual mapping
- Push notifications
- QR code scanning
- Offline mode support
- Multi-language support (Arabic/English)

## Credits
Future University in Egypt × Parsam Research Group
Supervised by: Dr. Mohamed Saeed Elsabry
