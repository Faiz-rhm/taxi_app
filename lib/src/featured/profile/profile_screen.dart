import 'package:flutter/material.dart';
import 'your_profile_screen.dart';
import 'manage_address_screen.dart';

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
            _buildHeader(),

            // Menu Options
            Expanded(
              child: _buildMenuOptions(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
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
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF9E9E9E),
                  size: 60,
                ),
              ),
              // Edit Profile Picture Button
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2994A), // Orange color
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Profile Name
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
          // Navigate to notification settings
        },
      },
      {
        'title': 'Payment Methods',
        'icon': Icons.credit_card_outlined,
        'onTap': () {
          // Navigate to payment methods
        },
      },
      {
        'title': 'Pre-Booked Rides',
        'icon': Icons.calendar_today_outlined,
        'onTap': () {
          // Navigate to pre-booked rides
        },
      },
      {
        'title': 'Settings',
        'icon': Icons.settings_outlined,
        'onTap': () {
          // Navigate to settings
        },
      },
      {
        'title': 'Emergency Contact',
        'icon': Icons.emergency_outlined,
        'onTap': () {
          // Navigate to emergency contacts
        },
      },
      {
        'title': 'Help Center',
        'icon': Icons.help_outline,
        'onTap': () {
          // Navigate to help center
        },
      },
    ];

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFF0F0F0),
          indent: 70,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                item['icon'],
                color: const Color(0xFFF2994A), // Orange color
                size: 24,
              ),
            ),
            title: Text(
              item['title'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF242424),
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Color(0xFFF2994A), // Orange color
              size: 24,
            ),
            onTap: item['onTap'],
          );
        },
      ),
    );
  }
}
