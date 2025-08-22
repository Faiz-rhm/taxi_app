import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';
import 'add_address_screen.dart';
import '../../helper/constants/app_colors.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({super.key});

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  String? _selectedAddressId;

  // Sample address data - in a real app, this would come from a database or API
  final List<Map<String, dynamic>> _addresses = [
    {
      'id': '1',
      'title': 'Home',
      'address': '1901 Thornridge Cir. Shiloh, Hawaii 81063',
      'type': 'Home',
      'floor': '',
      'landmark': '',
      'latitude': 40.7128,
      'longitude': -74.0060,
    },
    {
      'id': '2',
      'title': 'Office',
      'address': '4517 Washington Ave. Manchester, Kentucky 39495',
      'type': 'Office',
      'floor': '',
      'landmark': '',
      'latitude': 40.7128,
      'longitude': -74.0060,
    },
    {
      'id': '3',
      'title': 'Parent\'s House',
      'address': '8502 Preston Rd. Inglewood, Maine 98380',
      'type': 'Parent\'s House',
      'floor': '',
      'landmark': '',
      'latitude': 40.7128,
      'longitude': -74.0060,
    },
    {
      'id': '4',
      'title': 'Friend\'s House',
      'address': '2464 Royal Ln. Mesa, New Jersey 45463',
      'type': 'Friend\'s House',
      'floor': '',
      'landmark': '',
      'latitude': 40.7128,
      'longitude': -74.0060,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text('Manage Address', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),),
      ),
      body: Column(
        children: [

          // Address List
          Expanded(
            child: _buildAddressList(),
          ),

          // Add New Address Button
          _buildAddNewAddressButton(),

          // Apply Button
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildAddressList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: _addresses.length,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFF0F0F0),
        indent: 70,
      ),
      itemBuilder: (context, index) {
        final address = _addresses[index];
        final isSelected = _selectedAddressId == address['id'];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          leading: GestureDetector(
            onTap: () {
              setState(() {
                _selectedAddressId = address['id'];
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const AppColors.primary, // Orange outline
                  width: 2,
                ),
                color: isSelected ? const AppColors.primary : AppColors.surface,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: AppColors.surface,
                      size: 16,
                    )
                  : null,
            ),
          ),
          title: Text(
            address['title'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              address['address'],
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.hintText,
                height: 1.3,
              ),
            ),
          ),
          trailing: PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.hintText,
            ),
            onSelected: (value) {
              if (value == 'edit') {
                _editAddress(address);
              } else if (value == 'delete') {
                _deleteAddress(address);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 20),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            setState(() {
              _selectedAddressId = address['id'];
            });
          },
        );
      },
    );
  }

  Widget _buildAddNewAddressButton() {
    return Container(
      color: AppColors.surface,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(
            color: const AppColors.primary, // Orange border
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddAddressScreen(),
              ),
            );

            // If a new address was added, add it to the list
            if (result != null && result is Map<String, dynamic> && mounted) {
              setState(() {
                _addresses.add(result);
                // Select the newly added address
                _selectedAddressId = result['id'];
              });
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: AppColors.primary, // Orange color
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Add New Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary, // Orange color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _selectedAddressId != null ? _applySelection : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedAddressId != null
                ? const AppColors.primary // Orange when enabled
                : const AppColors.borderLight, // Grey when disabled
            foregroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: _selectedAddressId != null ? 4 : 0,
            shadowColor: const AppColors.primary,
          ),
          child: const Text(
            'Apply',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _applySelection() {
    if (_selectedAddressId != null) {
      final selectedAddress = _addresses.firstWhere(
        (address) => address['id'] == _selectedAddressId,
      );

      // Show success message
      _showSnackBar('Address "${selectedAddress['title']}" selected successfully!');

      // You can add API call here to update the selected address
      // For now, just navigate back
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context, selectedAddress);
      });
    }
  }

  void _editAddress(Map<String, dynamic> address) {
    // Navigate to edit address screen (for now, just show a message)
    _showSnackBar('Edit functionality coming soon for ${address['title']}');
  }

  void _deleteAddress(Map<String, dynamic> address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Address'),
        content: Text('Are you sure you want to delete "${address['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _addresses.removeWhere((a) => a['id'] == address['id']);
                if (_selectedAddressId == address['id']) {
                  _selectedAddressId = null;
                }
              });
              Navigator.pop(context);
              _showSnackBar('Address "${address['title']}" deleted successfully!');
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
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
