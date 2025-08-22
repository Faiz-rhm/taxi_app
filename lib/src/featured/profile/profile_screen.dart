import 'package:flutter/material.dart';
import 'your_profile_screen.dart';
import 'manage_address_screen.dart';
import 'emergency_contact_screen.dart';
import 'payment_methods_screen.dart';
import 'notification_permission_screen.dart';
import 'logout_bottom_sheet.dart';
import '../booking/bookings_screen.dart';
import '../booking/pre_booking_ride_screen.dart';
import '../wallet/wallet_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(context),

            // Menu Options
            Expanded(
              child: _buildMenuOptions(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Back Button and Title
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: () {
                    // Handle back navigation
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF242424),
                    size: 20,
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF242424),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40), // Balance the layout
            ],
          ),

          const SizedBox(height: 30),

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
                      image: AssetImage('assets/images/profile_placeholder.jpg'),
                      fit: BoxFit.cover,
                    ),
                    // Fallback if image doesn't exist
                    color: const Color(0xFFE0E0E0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.transparent,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF9E9E9E),
                      size: 60,
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
                    color: Color(0xFFF2994A), // Orange color
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
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
              color: Color(0xFF242424),
            ),
          ),
        ],
      ),
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
              builder: (context) => PreBookingRideScreen(
                bookingData: {
                  'userName': 'Esther Howard',
                  'vehicleType': 'Sedan (4 Seater)',
                  'rating': '5.0',
                  'distance': '4.5 Mile',
                  'duration': '4 mins',
                  'pricePerMile': '\$1.25 /mile',
                  'pickupAddress': '6391 Elgin St. Celina, Delawa...',
                  'destinationAddress': '1901 Thornridge Cir. Sh...',
                  'carNumber': 'GR 678-UVWX',
                  'seats': '04',
                },
              ),
            ),
          );
        },
      },
      {
        'title': 'Settings',
        'icon': Icons.settings_outlined,
        'onTap': () {
          // Navigate to settings
          _showComingSoonDialog(context, 'Settings');
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

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.only(top: 20),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFF0F0F0),
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
                color: isLogout ? const Color(0xFFFFF3E0) : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                item['icon'],
                color: isLogout ? const Color(0xFFE65100) : const Color(0xFFF2994A),
                size: 24,
              ),
            ),
            title: Text(
              item['title'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isLogout ? const Color(0xFFE65100) : const Color(0xFF242424),
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: isLogout ? const Color(0xFFE65100) : const Color(0xFFF2994A),
              size: 24,
            ),
            onTap: item['onTap'],
          );
        },
      ),
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

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(feature),
          content: Text('$feature feature is coming soon!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
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
