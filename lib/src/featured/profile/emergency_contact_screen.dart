import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  bool _selectAll = false;
  final List<Map<String, dynamic>> _contacts = [
    {
      'name': 'Robert Alexander',
      'relationship': 'Father',
      'phone': '+1 (555) 123-4567',
      'isSelected': true,
    },
    {
      'name': 'Jane Alexander',
      'relationship': 'Mother',
      'phone': '+1 (555) 123-4568',
      'isSelected': false,
    },
    {
      'name': 'Arlene McCoy',
      'relationship': 'Friends',
      'phone': '+1 (555) 123-4569',
      'isSelected': false,
    },
    {
      'name': 'Joshua Doe',
      'relationship': 'Friends',
      'phone': '+1 (555) 123-4570',
      'isSelected': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contact',),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildContactsList(),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // Select All Option
          _buildSelectAllOption(),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF0F0F0),
            indent: 20,
            endIndent: 20,
          ),
          // Contact List
          ..._contacts.asMap().entries.map((entry) {
            final index = entry.key;
            final contact = entry.value;
            return _buildContactItem(contact, index);
          }),
        ],
      ),
    );
  }

  Widget _buildSelectAllOption() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _selectAll = !_selectAll;
                for (var contact in _contacts) {
                  contact['isSelected'] = _selectAll;
                }
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _selectAll ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _selectAll ? AppColors.primary : AppColors.borderLight,
                  width: 2,
                ),
              ),
              child: _selectAll
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Select All',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                _contacts[index]['isSelected'] = !contact['isSelected'];
                _updateSelectAllState();
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: contact['isSelected'] ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: contact['isSelected'] ? AppColors.primary : AppColors.borderLight,
                  width: 2,
                ),
              ),
              child: contact['isSelected']
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),

          const SizedBox(width: 16),

          // Contact Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
              children: [
                Text(
                  contact['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${contact['relationship']})',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  contact['phone'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),

          // Delete Button
          GestureDetector(
            onTap: () => _showDeleteConfirmation(index),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      decoration: const BoxDecoration(
      color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Send Alert Button
          SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
              onPressed: _hasSelectedContacts() ? _sendAlert : null,
          style: ElevatedButton.styleFrom(
                backgroundColor: _hasSelectedContacts() ? AppColors.primary : AppColors.borderLight,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
                elevation: _hasSelectedContacts() ? 4 : 0,
                shadowColor: _hasSelectedContacts() ? AppColors.primary.withOpacity(0.3) : null,
          ),
          child: const Text(
            'Send Alert',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
          ),

          const SizedBox(height: 16),

          // Add New Contact Link
          GestureDetector(
            onTap: () => _showAddContactBottomSheet(),
            child: Text(
              'Add New Contact',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateSelectAllState() {
    final allSelected = _contacts.every((contact) => contact['isSelected']);
    if (_selectAll != allSelected) {
      setState(() {
        _selectAll = allSelected;
      });
    }
  }

  bool _hasSelectedContacts() {
    return _contacts.any((contact) => contact['isSelected']);
  }

  void _sendAlert() {
    final selectedContacts = _contacts.where((contact) => contact['isSelected']).toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.warning,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning,
      color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Emergency Alert Sent!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Alert sent to ${selectedContacts.length} contact${selectedContacts.length == 1 ? '' : 's'}.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
          child: const Text(
                'OK',
            style: TextStyle(
                  color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(int index) {
    final contact = _contacts[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Delete Contact',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure you want to delete ${contact['name']}?',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _contacts.removeAt(index);
                  _updateSelectAllState();
                });
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
          ),
        ),
      ),
          ],
        );
      },
    );
  }

  void _showAddContactBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddEmergencyContactBottomSheet(),
    );
  }
}

class AddEmergencyContactBottomSheet extends StatefulWidget {
  const AddEmergencyContactBottomSheet({super.key});

  @override
  State<AddEmergencyContactBottomSheet> createState() => _AddEmergencyContactBottomSheetState();
}

class _AddEmergencyContactBottomSheetState extends State<AddEmergencyContactBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _relationshipController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _relationshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              'Add Emergency Contact',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    _buildInputField(
                      label: 'Name',
                      controller: _nameController,
                      hintText: 'Enter contact name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    _buildInputField(
                      label: 'Phone Number',
                      controller: _phoneController,
                      hintText: 'Enter phone number',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
          ),

          const SizedBox(height: 20),

                    _buildInputField(
                      label: 'Relationship',
                      controller: _relationshipController,
                      hintText: 'e.g., Father, Mother, Friend',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a relationship';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    _buildAddButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.secondary,
          ),
        ),
          const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.hintText),
            filled: true,
            fillColor: AppColors.light,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
        onPressed: _addContact,
              style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.3),
              ),
              child: const Text(
          'Add Emergency Contact',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  void _addContact() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically save the contact to your backend
      Navigator.of(context).pop();

      // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('${_nameController.text} added as emergency contact!'),
          backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    }
  }
}
