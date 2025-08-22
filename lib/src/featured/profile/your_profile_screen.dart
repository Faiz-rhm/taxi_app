import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({super.key});

  @override
  State<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Esther Howard');
  final TextEditingController _phoneController = TextEditingController(text: '603.555.0123');
  final TextEditingController _emailController = TextEditingController();
  String _selectedGender = '';

  final List<String> _genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text('Your Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Picture Section
            _buildProfilePicture(),

            // Form Fields
            _buildFormFields(),

            // Update Button
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const AppColors.borderLight,
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.hintText,
                size: 60,
              ),
            ),
          ),
          // Edit Profile Picture Button
          Positioned(
            right: MediaQuery.of(context).size.width * 0.5 - 60,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.primary, // Orange color
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: AppColors.surface,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Container(
      color: AppColors.surface,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name Field
          _buildFormField(
            label: 'Name',
            controller: _nameController,
            hintText: 'Enter your name',
          ),

          const SizedBox(height: 24),

          // Phone Number Field
          _buildPhoneField(),

          const SizedBox(height: 24),

          // Email Field
          _buildFormField(
            label: 'Email',
            controller: _emailController,
            hintText: 'example@gmail.com',
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 24),

          // Gender Field
          _buildGenderField(),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryText.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.hintText,
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primaryText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryText.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: GestureDetector(
                  onTap: () {
                    // Handle phone number change
                  },
                  child: const Text(
                    'Change',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary, // Orange color
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
          'Gender',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryText.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              _showGenderPicker();
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedGender.isEmpty ? 'Select' : _selectedGender,
                      style: TextStyle(
                        fontSize: 16,
                        color: _selectedGender.isEmpty
                            ? const AppColors.hintText
                            : const AppColors.primaryText,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primary, // Orange color
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showGenderPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Gender',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 20),
              ..._genderOptions.map((gender) => ListTile(
                title: Text(
                  gender,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryText,
                  ),
                ),
                trailing: _selectedGender == gender
                    ? const Icon(
                        Icons.check,
                        color: AppColors.primary,
                      )
                    : null,
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

  Widget _buildUpdateButton() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            // Handle profile update
            _updateProfile();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const AppColors.primary, // Orange color
            foregroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Update',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _updateProfile() {
    // Validate and update profile
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar('Please enter your name');
      return;
    }

    if (_phoneController.text.trim().isEmpty) {
      _showSnackBar('Please enter your phone number');
      return;
    }

    if (_emailController.text.trim().isNotEmpty &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text.trim())) {
      _showSnackBar('Please enter a valid email address');
      return;
    }

    // Show success message
    _showSnackBar('Profile updated successfully!');

    // You can add API call here to update the profile
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
