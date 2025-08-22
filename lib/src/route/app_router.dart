import 'package:flutter/material.dart';
import '../featured/auth/sign_in_screen.dart';
import '../featured/auth/sign_up_screen.dart';
import '../featured/auth/forgot_password_screen.dart';
import '../featured/auth/verify_code_screen.dart';
import '../featured/home/onboarding_screen.dart';
import '../featured/home/welcome_screen.dart';
import '../featured/home/home_page.dart';
import '../featured/tab/tab_screen.dart';
import '../featured/booking/bookings_screen.dart';
import '../featured/booking/ride_tracking_screen.dart';
import '../featured/profile/complete_profile_screen.dart';
import '../featured/profile/notification_permission_screen.dart';
import '../featured/profile/location_permission_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/verify-code':
        return MaterialPageRoute(builder: (_) => const VerifyCodeScreen(email: ''));
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/tabs':
        return MaterialPageRoute(builder: (_) => const TabScreen());
      case '/complete-profile':
        return MaterialPageRoute(builder: (_) => const CompleteProfileScreen());
      case '/notification-permission':
        return MaterialPageRoute(builder: (_) => const NotificationPermissionScreen());
      case '/location-permission':
        return MaterialPageRoute(builder: (_) => const LocationPermissionScreen());
      case '/bookings':
        return MaterialPageRoute(builder: (_) => const BookingsScreen());
      case '/ride-tracking':
        return MaterialPageRoute(builder: (_) => const RideTrackingScreen());
      default:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
    }
  }
}
