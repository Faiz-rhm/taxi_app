# Taxi App - Flutter Project

A modern Flutter-based taxi booking mobile application with a clean, feature-based architecture.

## **Project Overview**

This is a **Flutter-based taxi booking mobile application** that provides a complete solution for users to book rides, track journeys, and manage their transportation needs. The app is built with modern Flutter architecture and follows best practices.

## **Key Technologies & Dependencies**

- **Framework**: Flutter 3.8.1+
- **State Management**: Riverpod (flutter_riverpod: ^2.6.1)
- **Navigation**: Custom routing system with MaterialPageRoute
- **Maps**: Google Maps Flutter (google_maps_flutter: ^2.6.0)
- **UI Components**: Custom design system with Poppins fonts
- **Platforms**: Android, iOS, Web, Linux, macOS, Windows

## **Project Architecture**

The project follows a **feature-based architecture** with clear separation of concerns:

```
lib/
├── main.dart                 # App entry point
├── src/
│   ├── featured/            # Feature modules
│   │   ├── auth/            # Authentication screens
│   │   ├── home/            # Home and onboarding screens
│   │   ├── tab/             # Tab-based navigation
│   │   ├── booking/         # Booking and ride tracking
│   │   ├── profile/         # User profile management
│   │   └── message/         # Messaging functionality
│   ├── helper/              # Utilities & constants
│   │   ├── constants/       # App constants and colors
│   │   └── utils/           # Utility functions
│   ├── route/               # Navigation & routing
│   └── core/                # Core functionality
│       ├── widgets/         # Reusable UI components
│       ├── models/          # Data models
│       └── services/        # Business logic services
```

## **Core Features**

### **1. Authentication System**
- Welcome and onboarding screens
- Sign in/Sign up functionality
- Password recovery with OTP verification
- Profile completion flow

### **2. Main Navigation (Tab-based)**
- **Home**: Ride booking and map interface
- **My Bookings**: User's ride history and active rides
- **Message**: Chat with drivers
- **Profile**: User account management

### **3. Ride Management**
- Location-based ride booking
- Real-time ride tracking
- Google Maps integration
- Location and notification permissions

### **4. Additional Features**
- Permission handling (location, notifications)
- Profile completion workflow
- Ride history management
- Modern UI/UX design

## **Design System**

The app uses a **consistent design language** with:
- **Primary Color**: Purple (#6D53F4)
- **Typography**: Poppins font family
- **Color Palette**: Comprehensive color system
- **Custom Components**: Reusable UI widgets

## **Key Screens & Flow**

1. **Onboarding** → Introduction to the app
2. **Welcome** → App introduction and sign-in options
3. **Authentication** → Login/Register flow
4. **Main App** → Tab-based navigation
5. **Ride Booking** → Location selection and booking
6. **Ride Tracking** → Real-time journey monitoring
7. **Profile** → Account management and settings

## **State Management**

Uses **Riverpod** for:
- Global state management
- Route management
- Form validation
- API state handling

## **Navigation Structure**

Implements **custom routing** with:
- Route generation
- Deep linking support
- Clean URL structure
- Screen transitions

## **Asset Management**

- **Images**: App icons, backgrounds
- **Fonts**: Poppins typography system
- **Splash Screen**: Branded app launch experience

## **Development Features**

- **Multi-platform support** (iOS, Android, Web, Desktop)
- **Responsive design** for different screen sizes
- **Permission handling** for location and notifications
- **Form validation** with custom validators
- **Clean architecture** with feature-based organization

## **Getting Started**

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd taxi_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## **Project Structure Benefits**

- **Maintainability**: Clear separation of concerns
- **Scalability**: Easy to add new features
- **Testability**: Isolated feature modules
- **Team Collaboration**: Clear ownership of features
- **Code Reusability**: Shared components and utilities

This is a **production-ready taxi booking application** with a professional architecture, comprehensive feature set, and modern Flutter development practices. The codebase is well-organized, follows Flutter conventions, and includes all necessary components for a commercial taxi booking service.
# taxi_app
