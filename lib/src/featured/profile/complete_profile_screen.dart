import 'package:flutter/material.dart';
import '../../helper/constants/app_constants.dart';
import '../../helper/constants/app_colors.dart';
import 'notification_permission_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final String _selectedCountryCode = "+1";
  String _selectedGender = "Select";

  final List<String> _countryCodes = ["+1", "+44", "+91", "+86", "+81", "+49"];
  final List<String> _genders = ["Male", "Female", "Other", "Prefer not to say"];

  @override
  void initState() {
    super.initState();
    // Pre-fill name as shown in the image
    _nameController.text = "Esther Howard";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          const Text(
            "Complete Your Profile",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF242424), // Dark gray
            ),
          ),

          const SizedBox(height: 8),

          // Description
          const Text(
            "Don't worry, only you can see your personal data. No one else will be able to see it.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9E9E9E), // Lighter gray
              height: 1.3,
            ),
          ),

          const SizedBox(height: 24),

          // Profile Picture Section
          _buildProfilePictureSection(),

          const SizedBox(height: 24),

          // Name Field
          _buildInputField(
            label: "Name",
            controller: _nameController,
            hintText: "Enter your name",
            prefixIcon: Icons.person_outline,
          ),

          const SizedBox(height: 16),

          // Phone Number Field
          _buildPhoneNumberField(),

          const SizedBox(height: 16),

          // Gender Field
          _buildGenderField(),

          const SizedBox(height: 24),

          // Complete Profile button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to notification permission screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationPermissionScreen(),
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
                "Complete Profile",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return Stack(
      children: [
        // Profile picture circle
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0), // Light gray background
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            size: 50,
            color: Color(0xFF9E9E9E), // Dark gray icon
          ),
        ),

        // Edit button
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFF2994A), // Orange background
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
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
        const SizedBox(height: 6),
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

  Widget _buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Phone Number",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424), // Dark gray
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFE0E0E0), // Light gray border
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Phone number input
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    hintStyle: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          '+1',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF242424),
                          ),
                        ),
                        SizedBox(width: 3),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF9E9E9E),
                          size: 14,
                        ),
                        Container(
                          width: 1,
                          height: 20,
                          color: const Color(0xFFE0E0E0),
                        ),
                      ]
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gender",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424), // Dark gray
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            _showGenderPicker();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFE0E0E0), // Light gray border
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Text(
                  _selectedGender,
                  style: TextStyle(
                    fontSize: 13,
                    color: _selectedGender == "Select"
                        ? const Color(0xFF9E9E9E)
                        : const Color(0xFF242424),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF9E9E9E),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showGenderPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Gender",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ..._genders.map((gender) => ListTile(
                title: Text(gender),
                onTap: () {
                  setState(() {
                    _selectedGender = gender;
                  });
                  Navigator.pop(context);
                },
              )),
            ],
          ),
        );
      },
    );
  }

  void _completeProfile() {
    final name = _nameController.text;
    final phone = _phoneController.text;

    // Basic validation
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your name"),
          backgroundColor: Color(0xFFE53935),
        ),
      );
      return;
    }

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your phone number"),
          backgroundColor: Color(0xFFE53935),
        ),
      );
      return;
    }

    if (_selectedGender == "Select") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select your gender"),
          backgroundColor: Color(0xFFE53935),
        ),
      );
      return;
    }

    // Success - profile completed
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile completed successfully!"),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );

    // TODO: Navigate to next screen (e.g., home screen)
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
