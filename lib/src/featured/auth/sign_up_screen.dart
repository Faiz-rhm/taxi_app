import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: _buildMainContent(),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
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
                color: AppColors.primaryText, // Dark gray
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
                color: AppColors.hintText, // Lighter gray
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
                backgroundColor: AppColors.primary, // Orange background
                foregroundColor: AppColors.surface,
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
            color: AppColors.primaryText, // Dark gray
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.borderLight, // Light gray border
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.hintText, // Lighter gray
                fontSize: 13,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: AppColors.hintText,
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
            color: AppColors.primaryText, // Dark gray
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.borderLight, // Light gray border
              width: 1,
            ),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: "************",
              hintStyle: const TextStyle(
                color: AppColors.hintText, // Lighter gray
                fontSize: 13,
              ),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColors.hintText,
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
                  color: AppColors.hintText,
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
          activeColor: AppColors.primary, // Orange color
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
                color: AppColors.primaryText, // Dark gray
              ),
              children: [
                const TextSpan(text: "Agree with "),
                TextSpan(
                  text: "Terms & Condition",
                  style: TextStyle(
                    color: AppColors.primary, // Orange color
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
            color: AppColors.borderLight, // Light gray
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or sign up with",
            style: TextStyle(
              color: AppColors.hintText, // Lighter gray
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.borderLight, // Light gray
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
          svgPath: 'assets/svg/apple.svg',
          backgroundColor: AppColors.surface,
          onPressed: () {
            // Handle Apple sign up
          },
        ),
        const SizedBox(width: 14),
        // Google button
        _buildSocialButton(
          svgPath: 'assets/svg/google.svg',
          backgroundColor: AppColors.surface,
          onPressed: () {
            // Handle Google sign up
          },
        ),
        const SizedBox(width: 14),
        // Facebook button
        _buildSocialButton(
          svgPath: 'assets/svg/facebook.svg',
          backgroundColor: AppColors.surface,
          onPressed: () {
            // Handle Facebook sign up
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String svgPath,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.borderLight, // Light gray border
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          svgPath,
          width: 30,
          height: 30,
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
            color: AppColors.primaryText, // Dark gray
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
              color: AppColors.primary, // Orange color
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
