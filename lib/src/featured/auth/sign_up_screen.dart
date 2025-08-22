import 'package:flutter/material.dart';
import '../../helper/constants/app_constants.dart';
import '../../helper/constants/app_colors.dart';
import 'verify_code_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _agreeToTerms = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top section with back button
            _buildTopSection(),

            // Main content area
            Expanded(
              child: _buildMainContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF242424),
              size: 22,
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF242424), // Dark gray
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // Subtitle
              const Center(
                child: Text(
                  "Fill your information below or register with your social account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9E9E9E), // Lighter gray
                    height: 1.3,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Name field
              _buildInputField(
                label: "Name",
                controller: _nameController,
                hintText: "Esther Howard",
                keyboardType: TextInputType.name,
                prefixIcon: Icons.person_outline,
              ),

              const SizedBox(height: 14),

              // Email field
              _buildInputField(
                label: "Email",
                controller: _emailController,
                hintText: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),

              const SizedBox(height: 14),

              // Password field
              _buildPasswordField(),

              const SizedBox(height: 16),

              // Terms and conditions checkbox
              _buildTermsCheckbox(),

              const SizedBox(height: 20),

              // Sign Up button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to verify code screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerifyCodeScreen(
                          email: _emailController.text.isNotEmpty
                              ? _emailController.text
                              : "example@email.com",
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2994A), // Orange background
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Divider with "Or sign up with"
              _buildDivider(),

              const SizedBox(height: 18),

              // Social signup buttons
              _buildSocialSignupButtons(),

              const SizedBox(height: 20),

              // Sign in link
              _buildSignInLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    required IconData prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424), // Dark gray
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFE0E0E0), // Light gray border
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF9E9E9E), // Lighter gray
                fontSize: 13,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: const Color(0xFF9E9E9E),
                size: 17,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424), // Dark gray
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFE0E0E0), // Light gray border
              width: 1,
            ),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: "************",
              hintStyle: const TextStyle(
                color: Color(0xFF9E9E9E), // Lighter gray
                fontSize: 13,
              ),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF9E9E9E),
                size: 17,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF9E9E9E),
                  size: 17,
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
          activeColor: const Color(0xFFF2994A), // Orange color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF242424), // Dark gray
              ),
              children: [
                const TextSpan(text: "Agree with "),
                TextSpan(
                  text: "Terms & Condition",
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
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFE0E0E0), // Light gray
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or sign up with",
            style: TextStyle(
              color: const Color(0xFF9E9E9E), // Lighter gray
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFE0E0E0), // Light gray
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSignupButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Apple button
        _buildSocialButton(
          icon: Icons.apple,
          backgroundColor: Colors.white,
          iconColor: Colors.black,
          onPressed: () {
            // Handle Apple sign up
          },
        ),
        const SizedBox(width: 14),
        // Google button
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          backgroundColor: Colors.white,
          iconColor: const Color(0xFF4285F4), // Google blue
          onPressed: () {
            // Handle Google sign up
          },
        ),
        const SizedBox(width: 14),
        // Facebook button
        _buildSocialButton(
          icon: Icons.facebook,
          backgroundColor: Colors.white,
          iconColor: const Color(0xFF1877F2), // Facebook blue
          onPressed: () {
            // Handle Facebook sign up
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFE0E0E0), // Light gray border
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(
            color: Color(0xFF242424), // Dark gray
            fontSize: 13,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Go back to sign in screen
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: Color(0xFFF2994A), // Orange color
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
