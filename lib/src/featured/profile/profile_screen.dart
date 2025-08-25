import 'package:flutter/material.dart';
import 'your_profile_screen.dart';
import 'manage_address_screen.dart';
import 'emergency_contact_screen.dart';
import 'payment_methods_screen.dart';
import 'logout_bottom_sheet.dart';
import 'pre_booking_ride_screen.dart';
import '../../helper/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        title: const Text('Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            _buildHeader(context),

            // Menu Options
            _buildMenuOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [

        const SizedBox(height: 20),

        // Profile Picture Section
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            GestureDetector(
              onTap: () {
                // Handle profile picture tap
                _showProfilePictureOptions(context);
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/user1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Edit Profile Picture Button
            GestureDetector(
              onTap: () {
                _showProfilePictureOptions(context);
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.primary, // Orange color
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowMedium,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
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

        const SizedBox(height: 20),

        // Profile Name - Updated to match the image
        const Text(
          'Esther Howard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuOptions(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Your profile',
        'icon': Icons.person_outline,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const YourProfileScreen(),
            ),
          );
        },
      },
      {
        'title': 'Manage Address',
        'icon': Icons.location_on_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManageAddressScreen(),
            ),
          );
        },
      },
      {
        'title': 'Notification',
        'icon': Icons.notifications_outlined,
        'onTap': () {
          Navigator.pushNamed(context, '/notifications');
        },
      },
      {
        'title': 'Payment Methods',
        'icon': Icons.credit_card_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentMethodsScreen(),
            ),
          );
        },
      },
      {
        'title': 'Pre-Booked Rides',
        'icon': Icons.calendar_today_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreBookingRideScreen(),
            ),
          );
        },
      },
      {
        'title': 'Settings',
        'icon': Icons.settings_outlined,
        'onTap': () {
          Navigator.pushNamed(context, '/settings');
        },
      },
      {
        'title': 'Emergency Contact',
        'icon': Icons.emergency_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmergencyContactScreen(),
            ),
          );
        },
      },
      {
        'title': 'SOS',
        'icon': Icons.sos_outlined,
        'onTap': () {
          Navigator.pushNamed(context, '/sos');
        },
      },
      {
        'title': 'Help Center',
        'icon': Icons.help_outline,
        'onTap': () {
          Navigator.pushNamed(context, '/help-center');
        },
      },
      {
        'title': 'Invite Friends',
        'icon': Icons.person_add_outlined,
        'onTap': () {
          Navigator.pushNamed(context, '/invite-friends');
        },
      },
      {
        'title': 'Log out',
        'icon': Icons.logout,
        'onTap': () {
          // Handle logout
          _showLogoutDialog(context);
        },
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: menuItems.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        thickness: 1,
        color: AppColors.borderLight,
        indent: 70,
        endIndent: 20,
      ),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        final isLogout = item['title'] == 'Log out';

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isLogout ? AppColors.warningLight.withOpacity(0.3) : AppColors.backgroundVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              item['icon'],
              color: isLogout ? AppColors.warning : AppColors.primary,
              size: 24,
            ),
          ),
          title: Text(
            item['title'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isLogout ? AppColors.warning : AppColors.primaryText,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: isLogout ? AppColors.warning : AppColors.primary,
            size: 24,
          ),
          onTap: item['onTap'],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    LogoutBottomSheet.show(
      context,
      onCancel: () {
        // Handle cancel action
      },
      onLogout: () {
        // Handle logout logic here
        // Navigate to login screen or perform logout
        Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
      },
    );
  }

  void _showProfilePictureOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Profile Picture'),
          content: const Text('Choose an option to change your profile picture.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement camera option
              },
              child: const Text('Take Photo'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement gallery option
              },
              child: const Text('Choose from Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
