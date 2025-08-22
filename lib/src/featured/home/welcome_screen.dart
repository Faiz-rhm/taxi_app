import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';
import 'home_page.dart';
import '../auth/sign_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Very light gray background
      body: Column(
        children: [
          // Main image section with floating icons
          Expanded(
            flex: 3,
            child: _buildMainImageSection(),
          ),

          // Content section
          Expanded(
            flex: 2,
            child: _buildContentSection(context),
          ),

          // Bottom navigation indicator
          _buildBottomIndicator(),
        ],
      ),
    );
  }

  Widget _buildMainImageSection() {
    return Stack(
      children: [
        // Main image container with curved bottom
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5), // Very light gray background
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Woman icon representation - more prominent and centered
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: const Color(0xFFF2994A), // Orange color
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Smartphone icon - positioned below the woman
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.phone_android,
                        size: 48,
                        color: const Color(0xFFF2994A), // Orange color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Floating icons - positioned around the woman
        Positioned(
          top: 60,
          left: 30,
          child: _buildFloatingIcon(Icons.location_on, "Location"),
        ),

        Positioned(
          top: 60,
          right: 30,
          child: _buildFloatingIcon(Icons.person, "Driver"),
        ),

        Positioned(
          bottom: 80,
          left: 30,
          child: _buildFloatingIcon(Icons.chat_bubble_outline, "Chat"),
        ),

        Positioned(
          bottom: 80,
          right: 30,
          child: _buildFloatingIcon(Icons.phone, "Call"),
        ),
      ],
    );
  }

  Widget _buildFloatingIcon(IconData icon, String label) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF2994A), // Orange background
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF2994A).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 26,
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Headline
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF242424), // Dark gray
                height: 1.2,
              ),
              children: [
                const TextSpan(text: "Welcome to Your "),
                TextSpan(
                  text: "Ultimate Transportation Solution",
                  style: const TextStyle(color: Color(0xFFF2994A)), // Orange color
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF9E9E9E), // Lighter gray
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          // Call-to-action button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2994A), // Orange background
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Let's Get Started",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Sign in link
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              );
            },
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF9E9E9E), // Lighter gray
                ),
                children: [
                  const TextSpan(text: "Already have an account? "),
                  TextSpan(
                    text: "Sign In",
                    style: TextStyle(
                      color: const Color(0xFFF2994A), // Orange color
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomIndicator() {
    return Container(
      width: 100,
      height: 4,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2994A), // Orange color
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
