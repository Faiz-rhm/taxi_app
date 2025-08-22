import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0; // Start at page 0 (leftmost dot)

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      imagePath: "assets/images/onboarding1.png",
      titleHighlight: "Book a Ride",
      titleHighlight2: "Anywhere, Anytime!",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
    ),
    OnboardingPage(
      imagePath: "assets/images/onboarding2.png",
      titleHighlight: "Choose Your Comfort:",
      titleHighlight2: "Enjoy a Luxurious Ride",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
    ),
    OnboardingPage(
      imagePath: "assets/images/onboarding3.png",
      titleHighlight: "Elevate Your",
      titleHighlight2: "Ride Tracking Experience",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
            // Skip button section
            _buildSkipButton(),

            // Main image section
            Expanded(
              flex: 3,
              child: _buildMainImageSection(),
            ),

            // Bottom section with content and navigation
            Expanded(
              flex: 2,
              child: _buildBottomSection(),
            ),
          ],
        ),
    );
  }

  Widget _buildSkipButton() {
    return Container(
      padding: const EdgeInsets.only(right: 24, top: 36),
      color: Color(0xFFF6f6f6),
      child: Row(
        children: [
          const Spacer(),
          // Skip button
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                ),
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: const Color(0xFFF2994A), // Orange color
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainImageSection() {
    final currentPage = _pages[_currentPage];

    return ShapeOfView(
      shape: ArcShape(
        direction: ArcDirection.Outside,
        height: 20,
        position: ArcPosition.Bottom
      ),
      elevation: 0,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          currentPage.imagePath,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFF5F5F5),
              child: Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 100,
                  color: const Color(0xFFE0E0E0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    final currentPage = _pages[_currentPage];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 32, // Larger font size
                fontWeight: FontWeight.bold,
                color: const Color(0xFF242424), // Dark gray/black
                height: 1.2,
              ),
              children: [
                TextSpan(
                  text: currentPage.titleHighlight,
                  style: const TextStyle(color: Color(0xFFF2994A)), // Orange color
                ),
                const TextSpan(text: " "),
                TextSpan(text: currentPage.titleHighlight2),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            currentPage.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF9E9E9E), // Lighter gray
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          // Navigation controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left arrow button
              _currentPage > 0 ? SizedBox(
                width: 56,
                height: 56,
                child: IconButton.outlined(
                  onPressed: _currentPage > 0 ? () {
                    setState(() {
                      _currentPage--;
                    });
                  } : null,
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                ),
              ) : const SizedBox(width: 56, height: 56),

              // Page indicators
              Row(
                children: List.generate(_pages.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: _currentPage == index ? 12 : 8,
                    height: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? const Color(0xFFF2994A) // Orange for active
                          : const Color(0xFFF2994A).withOpacity(0.3), // Light gray for inactive
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),

              // Right arrow button
              SizedBox(
                width: 56,
                height: 56,
                child: IconButton.filled(
                  onPressed: _currentPage < _pages.length - 1 ? () {
                    setState(() {
                      _currentPage++;
                    });
                  } : () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    _currentPage < _pages.length - 1 ? Icons.arrow_forward : Icons.check,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String imagePath;
  final String titleHighlight;
  final String titleHighlight2;
  final String description;

  OnboardingPage({
    required this.imagePath,
    required this.titleHighlight,
    required this.titleHighlight2,
    required this.description,
  });
}
