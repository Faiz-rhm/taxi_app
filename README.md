# Taxi App

A modern Flutter-based taxi booking application with comprehensive ride management features.

## Project Overview

This taxi app provides a complete ride booking experience with real-time driver tracking, multiple ride types, scheduling capabilities, and seamless payment integration.

## Key Features

### Book Ride Screen
- **Interactive Google Maps Integration**: Full-screen map with custom markers for pickup and destination
- **Multiple Ride Types**: Mini, Sedan, and SUV options with pricing and capacity details
- **Smart State Management**: Comprehensive loading states and state transitions
- **Scheduled Rides**: Advanced date and time picker for future ride bookings
- **Payment Integration**: Multiple payment method support
- **Real-time Updates**: Live ride status updates with driver information

### State Management & Loading States
- **Searching State**: Animated search indicator with clear user feedback
- **Ride Found State**: Smooth transition animations when ride is located
- **Driver Assignment**: Progressive loading states for driver information
- **Error Handling**: Graceful error states with retry functionality
- **Request Processing**: Loading states for ride requests

### UI/UX Features
- **Component-Based Architecture**: Reusable UI components for consistency
- **Smooth Animations**: Flutter built-in animation controllers for state transitions
- **Responsive Design**: Adapts to different screen sizes and orientations
- **Modern Material Design**: Following Material Design 3 principles
- **Accessibility**: Proper semantics and screen reader support

## Technical Implementation

### Architecture
- **StatefulWidget Pattern**: Proper state management with lifecycle awareness
- **Animation Controllers**: Smooth transitions between different ride states
- **Resource Management**: Proper disposal of controllers and resources
- **Error Handling**: Comprehensive error states and recovery mechanisms

### Key Components
- `BookRideScreen`: Main ride booking interface
- `GoogleMap`: Interactive map with custom markers and routes
- `DraggableScrollableSheet`: Bottom sheet for ride options
- `AnimationController`: State transition animations
- Custom marker icons and route visualization

### State Flow
1. **Initial State**: User selects ride options and confirms booking
2. **Searching State**: Animated search with clear feedback
3. **Ride Found**: Success animation and driver assignment
4. **Driver Assigned**: Driver details and ride confirmation
5. **Request Processing**: Final ride request with loading state

## Dependencies

- `flutter`: Core Flutter framework
- `google_maps_flutter`: Google Maps integration
- Custom color schemes and constants
- Asset management for custom markers

## Setup Instructions

1. Clone the repository
2. Install Flutter dependencies: `flutter pub get`
3. Configure Google Maps API key
4. Generate app icons: `dart run icons_launcher:create`
5. Run the application: `flutter run`

## App Icon Generation

This project uses the [icons_launcher](https://pub.dev/packages/icons_launcher) package to automatically generate app icons for all platforms.

### Icon Configuration
- **Source Image**: `assets/images/icon.png`
- **Primary Color**: Orange (#eb8e01) - matches the app's primary color scheme
- **Platforms**: Android, iOS, and Web enabled

### Generate Icons
After making changes to the icon or configuration:

```bash
# Install dependencies
flutter pub get

# Generate app icons
dart run icons_launcher:create
```

### Generated Files
The package automatically generates:

#### Android
- **Adaptive Icons**: `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml`
- **Background Color**: `android/app/src/main/res/values/colors.xml` with `#eb8e01`
- **Icon Images**: Multiple resolution variants in `mipmap-*` folders

#### iOS
- **App Icons**: Multiple sizes in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- **Contents.json**: Icon configuration file
- **Alpha Channel**: Automatically removed for iOS compatibility

#### Web
- **Favicon**: `web/favicon.png`
- **Icon Images**: Multiple sizes in `web/icons/` folder

### Customization
The icon configuration can be modified in `pubspec.yaml` under the `icons_launcher` section:
- Enable/disable specific platforms
- Customize adaptive icon colors for Android
- Set different images for different platforms
- Configure notification icons and adaptive icon variants

## Development Notes

### Recent Improvements
- **Proper Resource Disposal**: Added comprehensive dispose methods for all controllers
- **Enhanced State Management**: Improved loading states with visible feedback
- **Animation Integration**: Smooth transitions between different ride states
- **Error Handling**: Better error recovery and user feedback
- **Performance Optimization**: Proper cleanup and resource management
- **User Guidance**: Clear messaging to guide users through the ride request process

### Best Practices Implemented
- **Component Reusability**: Modular UI components for consistency
- **State Visibility**: Clear visual feedback for all loading states
- **Resource Management**: Proper disposal of controllers and resources
- **User Experience**: Smooth animations and clear state transitions
- **Error Recovery**: Graceful handling of edge cases and errors

## Future Enhancements

- [ ] Real-time driver tracking
- [ ] Push notifications for ride updates
- [ ] Offline mode support
- [ ] Multi-language support
- [ ] Advanced analytics and reporting
- [ ] Integration with external ride services

## Testing

- Unit tests for all business logic
- Widget tests for UI components
- Integration tests for complete user flows
- Performance testing for animations and state transitions

## Contributing

1. Follow Flutter best practices
2. Maintain component-based architecture
3. Ensure proper resource disposal
4. Add comprehensive tests for new features
5. Update documentation for any changes

## License

This project is licensed under the MIT License.
