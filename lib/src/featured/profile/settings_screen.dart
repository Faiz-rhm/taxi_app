import 'package:flutter/material.dart';
import 'password_manager_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Settings Options
            _buildSettingsOption(
              context,
              icon: Icons.notifications_outlined,
              title: 'Notification Settings',
              onTap: () {
                _showNotificationSettings(context);
              },
            ),

            const SizedBox(height: 20),

            _buildSettingsOption(
              context,
              icon: Icons.lock_outline,
              title: 'Password Manager',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordManagerScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            _buildSettingsOption(
              context,
              icon: Icons.delete_outline,
              title: 'Delete Account',
              onTap: () {
                _showDeleteAccountDialog(context);
              },
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFF0F0F0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDestructive
                    ? const Color(0xFFFFEBEE)
                    : const Color(0xFFFFF8F0),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                icon,
                color: isDestructive
                    ? const Color(0xFFE53935)
                    : const Color(0xFFF2994A),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDestructive
                      ? const Color(0xFFE53935)
                      : const Color(0xFF242424),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDestructive
                  ? const Color(0xFFE53935)
                  : const Color(0xFFF2994A),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const NotificationSettingsBottomSheet(),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Delete Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE53935),
            ),
          ),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF666666),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showDeleteConfirmationDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Delete',
                style: TextStyle(
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

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Final Confirmation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE53935),
            ),
          ),
          content: const Text(
            'Type "DELETE" to confirm account deletion:',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
            ),
          ),
          actions: [
            Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Type DELETE here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE53935)),
                    ),
                  ),
                  onChanged: (value) {
                    // Handle text change
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Handle account deletion
                        Navigator.of(context).pop();
                        _showAccountDeletedSnackBar(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Delete Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showAccountDeletedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Account deletion process initiated. You will receive a confirmation email.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFE53935),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}

class NotificationSettingsBottomSheet extends StatefulWidget {
  const NotificationSettingsBottomSheet({super.key});

  @override
  State<NotificationSettingsBottomSheet> createState() => _NotificationSettingsBottomSheetState();
}

class _NotificationSettingsBottomSheetState extends State<NotificationSettingsBottomSheet> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = true;
  bool _rideUpdates = true;
  bool _promotionalOffers = false;
  bool _securityAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Notification Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF242424),
            ),
          ),

          const SizedBox(height: 24),

          _buildNotificationToggle(
            'Push Notifications',
            'Receive notifications on your device',
            _pushNotifications,
            (value) => setState(() => _pushNotifications = value),
          ),

          _buildNotificationToggle(
            'Email Notifications',
            'Receive notifications via email',
            _emailNotifications,
            (value) => setState(() => _emailNotifications = value),
          ),

          _buildNotificationToggle(
            'SMS Notifications',
            'Receive notifications via SMS',
            _smsNotifications,
            (value) => setState(() => _smsNotifications = value),
          ),

          const Divider(height: 32, color: Color(0xFFF0F0F0)),

          _buildNotificationToggle(
            'Ride Updates',
            'Notifications about your rides',
            _rideUpdates,
            (value) => setState(() => _rideUpdates = value),
          ),

          _buildNotificationToggle(
            'Promotional Offers',
            'Special offers and discounts',
            _promotionalOffers,
            (value) => setState(() => _promotionalOffers = value),
          ),

          _buildNotificationToggle(
            'Security Alerts',
            'Important security notifications',
            _securityAlerts,
            (value) => setState(() => _securityAlerts = value),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSettingsSavedSnackBar();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2994A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Save Settings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF242424),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFF2994A),
            activeTrackColor: const Color(0xFFF2994A).withOpacity(0.3),
            inactiveThumbColor: const Color(0xFFE0E0E0),
            inactiveTrackColor: const Color(0xFFF5F5F5),
          ),
        ],
      ),
    );
  }

  void _showSettingsSavedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Notification settings saved successfully!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFF2994A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
