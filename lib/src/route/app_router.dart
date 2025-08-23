import 'package:flutter/material.dart';
import '../featured/auth/sign_in_screen.dart';
import '../featured/auth/sign_up_screen.dart';
import '../featured/auth/forgot_password_screen.dart';
import '../featured/auth/verify_code_screen.dart';
import '../featured/onboarding/onboarding_screen.dart';
import '../featured/onboarding/welcome_screen.dart';
import '../featured/home/home_page.dart';
import '../featured/tab/tab_screen.dart';
import '../featured/booking/bookings_screen.dart';
import '../featured/profile/complete_profile_screen.dart';
import '../featured/profile/notification_permission_screen.dart';
import '../featured/profile/location_permission_screen.dart';
import '../featured/profile/add_card_screen.dart';
import '../featured/profile/help_center_screen.dart';
import '../featured/profile/invite_friends_screen.dart';
import '../featured/profile/sos_screen.dart';
import '../featured/profile/notification_screen.dart';
import '../featured/profile/settings_screen.dart';
import '../featured/home/e_receipt_screen.dart';

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
      case '/add-card':
        return MaterialPageRoute(builder: (_) => const AddCardScreen());
      case '/help-center':
        return MaterialPageRoute(builder: (_) => const HelpCenterScreen());
      case '/invite-friends':
        return MaterialPageRoute(builder: (_) => const InviteFriendsScreen());
      case '/sos':
        return MaterialPageRoute(builder: (_) => const SosScreen());
      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/bookings':
        return MaterialPageRoute(builder: (_) => const BookingsScreen());
      case '/e-receipt':
        return MaterialPageRoute(builder: (_) => const EReceiptScreen());
      default:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
    }
  }
}
