import 'package:flutter/material.dart';

import '../../helper/constants/app_colors.dart';
import 'sign_up_screen.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
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
        centerTitle: true,
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
          const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText, // Dark gray
            ),
          ),

          const SizedBox(height: 6),

          // Subtitle
          const Text(
            "Hi! Welcome back, you've been missed",
            style: TextStyle(
              fontSize: 13,
              color: AppColors.hintText, // Lighter gray
              height: 1.3,
            ),
          ),

          const SizedBox(height: 20),

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

          const SizedBox(height: 10),

          // Forgot Password link
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Navigate to forgot password screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                );
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  color: AppColors.primary, // Orange color
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Sign In button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // Handle sign in
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
                "Sign In",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Divider with "Or sign in with"
          _buildDivider(),

          const SizedBox(height: 18),

          // Social login buttons
          _buildSocialLoginButtons(),

          const SizedBox(height: 20),

          // Sign up link
          _buildSignUpLink(context),
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
            "Or sign in with",
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

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Apple button
        _buildSocialButton(
          icon: Icons.apple,
          backgroundColor: AppColors.surface,
          iconColor: AppColors.primaryText,
          onPressed: () {
            // Handle Apple sign in
          },
        ),
        const SizedBox(width: 14),
        // Google button
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          backgroundColor: AppColors.surface,
          iconColor: AppColors.info, // Google blue
          onPressed: () {
            // Handle Google sign in
          },
        ),
        const SizedBox(width: 14),
        // Facebook button
        _buildSocialButton(
          icon: Icons.facebook,
          backgroundColor: AppColors.surface,
          iconColor: AppColors.info, // Facebook blue
          onPressed: () {
            // Handle Facebook sign in
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
        icon: Icon(
          icon,
          color: iconColor,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            color: AppColors.primaryText, // Dark gray
            fontSize: 13,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
          child: const Text(
            "Sign Up",
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
