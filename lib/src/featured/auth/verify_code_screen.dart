import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
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
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Pre-fill with initial code as shown in the design
    _pinController.text = "28";
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
      ),
      body: _buildMainContent(),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
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
                color: AppColors.primaryText, // Dark gray
              ),
            ),

            const SizedBox(height: 12),

            // Instructions
            const Text(
              "Please enter the code we just sent to email",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.hintText, // Lighter gray
                height: 1.3,
              ),
            ),

            const SizedBox(height: 8),

            // Email address
            Text(
              widget.email,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.primary, // Orange color
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 32),

            // OTP Input Fields using Pinput
            _buildPinputField(),

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
                  backgroundColor: AppColors.primary, // Orange background
                  foregroundColor: AppColors.surface,
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
    );
  }

  Widget _buildPinputField() {
    // Define pin themes to match the app design
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryText,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
          color: AppColors.borderLight,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: AppColors.primary,
        width: 2,
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.surface,
        border: Border.all(
          color: AppColors.primary,
          width: 1,
        ),
      ),
    );

    return Center(
      child: Pinput(
        controller: _pinController,
        focusNode: _pinFocusNode,
        length: 4,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        cursor: Container(
          height: 20,
          width: 2,
          color: AppColors.primary,
        ),
        onCompleted: (pin) {
          _verifyCode();
        },
        onChanged: (value) {
          // Optional: Handle real-time validation
        },
        keyboardType: TextInputType.number,
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        separatorBuilder: (index) => const SizedBox(width: 12),
      ),
    );
  }

  Widget _buildResendCodeOption() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Didn't receive OTP? ",
          style: TextStyle(
            color: AppColors.hintText, // Lighter gray
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
              color: AppColors.info, // Blue color
              fontSize: 14,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  void _verifyCode() {
    // Get the OTP from Pinput controller
    String otp = _pinController.text;

    // Remove any non-numeric characters (just in case)
    otp = otp.replaceAll(RegExp(r'[^0-9]'), '');

    if (otp.length == 4) {
      // Valid OTP, proceed with verification
      print("Verifying OTP: $otp");
      // TODO: Implement verification logic

      // Show success message or navigate to next screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Code verified successfully!"),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      // Invalid OTP
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid 4-digit code"),
          backgroundColor: AppColors.error,
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
        backgroundColor: AppColors.success,
      ),
    );
  }
}
