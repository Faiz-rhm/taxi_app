import 'package:flutter/material.dart';
import '../../helper/constants/app_constants.dart';
import '../../helper/constants/app_colors.dart';
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
      title: "Book a Ride Anywhere,",
      titleHighlight: "Book a Ride",
      titleHighlight2: "Anytime!",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
    ),
    OnboardingPage(
      title: "Track Your Journey",
      titleHighlight: "Track Your",
      titleHighlight2: "Journey",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
    ),
    OnboardingPage(
      title: "Earn While You Drive",
      titleHighlight: "Earn While",
      titleHighlight2: "You Drive",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light gray background
      body: Column(
        children: [
            // Skip button section
            _buildSkipButton(),

            // Main content area
            Expanded(
              child: _buildMainContent(),
            ),

            // Bottom section with content and navigation
            _buildBottomSection(),
          ],
        ),
    );
  }

  Widget _buildSkipButton() {
    return Padding(
      padding: AppConstants.paddingM,
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

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // Light gray background
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5), // Light gray background
            ),
            child: Stack(
              children: [
                // Background with darker borders
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: const Color(0xFFE0E0E0), // Darker gray borders
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    final currentPage = _pages[_currentPage];

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
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

          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFFF2994A) // Orange for active
                      : const Color(0xFFD4A574), // Lighter orange/beige for inactive
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),

          const SizedBox(height: 24),

          // Navigation button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2994A), // Orange background
                  shape: BoxShape.circle,
                ),
                child: IconButton(
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
  final String title;
  final String titleHighlight;
  final String titleHighlight2;
  final String description;

  OnboardingPage({
    required this.title,
    required this.titleHighlight,
    required this.titleHighlight2,
    required this.description,
  });
}
