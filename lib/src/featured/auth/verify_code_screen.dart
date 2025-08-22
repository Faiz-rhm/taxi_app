import 'package:flutter/material.dart';
import '../../helper/constants/app_constants.dart';
import '../../helper/constants/app_colors.dart';
import '../profile/complete_profile_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;

  const VerifyCodeScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  @override
  void initState() {
    super.initState();
    // Pre-fill first two fields as shown in the image
    _otpControllers[0].text = "2";
    _otpControllers[1].text = "8";
    _otpControllers[2].text = "-";
    _otpControllers[3].text = "-";
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0), // Light gray background
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF242424), // Dark gray
                size: 20,
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              const Text(
                "Verify Code",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF242424), // Dark gray
                ),
              ),

              const SizedBox(height: 12),

              // Instructions
              const Text(
                "Please enter the code we just sent to email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9E9E9E), // Lighter gray
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 8),

              // Email address
              Text(
                widget.email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFFF2994A), // Orange color
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 32),

              // OTP Input Fields
              _buildOTPInputFields(),

              const SizedBox(height: 24),

              // Resend code option
              _buildResendCodeOption(),

              const SizedBox(height: 32),

              // Verify button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to complete profile screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompleteProfileScreen(),
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
                    "Verify",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: EdgeInsets.only(
            right: index < 3 ? 12 : 0,
          ),
          width: 60,
          height: 60,
          child: TextField(
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF242424), // Dark gray
            ),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0), // Light gray border
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0), // Light gray border
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFF2994A), // Orange border when focused
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              if (value.length == 1 && index < 3) {
                // Move to next field
                _focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                // Move to previous field
                _focusNodes[index - 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildResendCodeOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Didn't receive OTP? ",
          style: TextStyle(
            color: Color(0xFF9E9E9E), // Lighter gray
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle resend code
            _resendCode();
          },
          child: const Text(
            "Resend code",
            style: TextStyle(
              color: Color(0xFF2196F3), // Blue color
              fontSize: 14,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  void _verifyCode() {
    // Get the OTP from all fields
    String otp = _otpControllers.map((controller) => controller.text).join();

    // Remove any hyphens or non-numeric characters
    otp = otp.replaceAll(RegExp(r'[^0-9]'), '');

    if (otp.length == 4) {
      // Valid OTP, proceed with verification
      print("Verifying OTP: $otp");
      // TODO: Implement verification logic

      // Show success message or navigate to next screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Code verified successfully!"),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    } else {
      // Invalid OTP
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid 4-digit code"),
          backgroundColor: Color(0xFFE53935),
        ),
      );
    }
  }

  void _resendCode() {
    // Handle resend code logic
    print("Resending code to ${widget.email}");

    // Show loading or success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Code resent successfully!"),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }
}
