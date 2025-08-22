import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import '../auth/sign_in_screen.dart';
import '../tab/tab_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Main image section with floating icons
          Expanded(
            flex: 3,
            child: ShapeOfView(
              shape: ArcShape(
                direction: ArcDirection.Outside,
                height: 20,
                position: ArcPosition.Bottom
              ),
              elevation: 0,
              child: _buildMainImageSection(),
            ),
          ),

          // Content section with curved top edge
          Expanded(
            flex: 2,
            child: _buildContentSection(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMainImageSection() {
    return  Image.asset(
      'assets/images/welcome.png',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
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
                    builder: (context) => const TabScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2994A), // Orange background
                foregroundColor: Colors.white,
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
}


