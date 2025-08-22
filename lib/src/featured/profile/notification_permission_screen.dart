import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../helper/constants/app_colors.dart';
import 'location_permission_screen.dart';

class NotificationPermissionScreen extends StatefulWidget {
  const NotificationPermissionScreen({super.key});

  @override
  State<NotificationPermissionScreen> createState() => _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState extends State<NotificationPermissionScreen> {
  bool _isLoading = false;
  String _statusMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Very light gray background
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            // Notification Icon
            _buildNotificationIcon(),

            const SizedBox(height: 24),

            // Heading
            const Text(
              "Enable Notification Access",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF242424), // Dark gray/black
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Description
            const Text(
              "Enable notifications to receive real-time updates on your ride status, driver arrivals.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF9E9E9E), // Lighter gray
                height: 1.4,
              ),
            ),

            const SizedBox(height: 16),

            // Status Message
            if (_statusMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _statusMessage.contains('granted')
                      ? const Color(0xFFE8F5E8)
                      : const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _statusMessage.contains('granted')
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFF2994A),
                    width: 1,
                  ),
                ),
                child: Text(
                  _statusMessage,
                  style: TextStyle(
                    fontSize: 14,
                    color: _statusMessage.contains('granted')
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFE65100),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            const SizedBox(height: 32),

            Spacer(),

            // Primary Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _requestNotificationPermission,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2994A), // Orange background
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        "Allow Notification",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 16),

            // Secondary Link
            TextButton(
              onPressed: _isLoading ? null : _skipNotificationPermission,
              child: const Text(
                "Maybe Later",
                style: TextStyle(
                  color: Color(0xFFF2994A), // Orange color
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0), // Light gray background
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.notifications,
        color: Color(0xFFF2994A), // Orange color
        size: 50,
      ),
    );
  }

  Future<void> _requestNotificationPermission() async {
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    try {
      // Check current permission status
      PermissionStatus permissionStatus = await Permission.notification.status;

      if (permissionStatus.isGranted) {
        // Permission already granted
        setState(() {
          _statusMessage = 'Notification permission already granted!';
        });

        // Wait a bit to show the success message
        await Future.delayed(const Duration(seconds: 1));

        // Navigate to location permission screen
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LocationPermissionScreen(),
            ),
          );
        }
        return;
      }

      if (permissionStatus.isDenied) {
        // Request permission
        permissionStatus = await Permission.notification.request();

        if (permissionStatus.isGranted) {
          setState(() {
            _statusMessage = 'Notification permission granted!';
          });

          // Wait a bit to show the success message
          await Future.delayed(const Duration(seconds: 1));

          // Navigate to location permission screen
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LocationPermissionScreen(),
              ),
            );
          }
        } else if (permissionStatus.isPermanentlyDenied) {
          setState(() {
            _statusMessage = 'Notification permission permanently denied. Please enable it in app settings.';
          });

          // Show dialog to open settings
          _showOpenSettingsDialog();
        } else {
          setState(() {
            _statusMessage = 'Notification permission denied.';
          });
        }
      } else if (permissionStatus.isPermanentlyDenied) {
        setState(() {
          _statusMessage = 'Notification permission permanently denied. Please enable it in app settings.';
        });

        // Show dialog to open settings
        _showOpenSettingsDialog();
      }

    } catch (e) {
      setState(() {
        _statusMessage = 'Error requesting notification permission: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showOpenSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Permission Required'),
          content: const Text(
            'Notification permission is required to receive ride updates. Please enable it in app settings.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  void _skipNotificationPermission() {
    // Handle skipping notification permission
    print("Notification permission skipped");

    // Show message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Notification permission skipped. You can enable it later in settings."),
        backgroundColor: Color(0xFFFF9800),
      ),
    );

    // Navigate to location permission screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationPermissionScreen(),
      ),
    );
  }
}
