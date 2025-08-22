import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import '../tab/tab_screen.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  bool _isLoading = false;
  String _statusMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Very light gray background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Location Icon
                _buildLocationIcon(),

                const SizedBox(height: 24),

                // Heading
                const Text(
                  "Enable Location Access",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF242424), // Dark gray/black
                  ),
                ),

                const SizedBox(height: 12),

                // Description
                const Text(
                  "To ensure a seamless and efficient experience, allow us access to your location.",
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
                            : const Color(0xFFFF9800),
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

                // Primary Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _requestLocationPermission,
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
                            "Allow Location Access",
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
                  onPressed: _isLoading ? null : _skipLocationPermission,
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
        ),
    );
  }

  Widget _buildLocationIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0), // Light gray background
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Location pin icon
          const Icon(
            Icons.location_on,
            color: Color(0xFFF2994A), // Orange color
            size: 50,
          ),

          // White dot in center of pin
          Positioned(
            top: 12,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _requestLocationPermission() async {
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _statusMessage = 'Location services are disabled. Please enable them in settings.';
        });

        // Show dialog to open settings
        _showEnableLocationDialog();
        return;
      }

      // Check current permission status
      PermissionStatus permissionStatus = await Permission.location.status;

      if (permissionStatus.isGranted) {
        // Permission already granted, check if we can get location
        await _checkLocationAccess();
        return;
      }

      if (permissionStatus.isDenied) {
        // Request permission
        permissionStatus = await Permission.location.request();

        if (permissionStatus.isGranted) {
          await _checkLocationAccess();
        } else if (permissionStatus.isPermanentlyDenied) {
          setState(() {
            _statusMessage = 'Location permission permanently denied. Please enable it in app settings.';
          });

          // Show dialog to open settings
          _showOpenSettingsDialog();
        } else {
          setState(() {
            _statusMessage = 'Location permission denied.';
          });
        }
      } else if (permissionStatus.isPermanentlyDenied) {
        setState(() {
          _statusMessage = 'Location permission permanently denied. Please enable it in app settings.';
        });

        // Show dialog to open settings
        _showOpenSettingsDialog();
      }

    } catch (e) {
      setState(() {
        _statusMessage = 'Error requesting location permission: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _checkLocationAccess() async {
    try {
      // Try to get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      setState(() {
        _statusMessage = 'Location access granted! Getting your location...';
      });

      // Wait a bit to show the success message
      await Future.delayed(const Duration(seconds: 1));

      // Navigate to home screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TabScreen(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error getting location: ${e.toString()}';
      });
    }
  }

  void _showEnableLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text(
            'Location services are disabled. Please enable them in your device settings to use Google Maps.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  void _showOpenSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
            'Location permission is required for Google Maps to work properly. Please enable it in app settings.',
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

  void _skipLocationPermission() {
    // Handle skipping location permission
    print("Location permission skipped");

    // Show message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Location permission skipped. You can enable it later in settings."),
        backgroundColor: Color(0xFFFF9800),
      ),
    );

    // Navigate to home screen without location permission
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const TabScreen(),
      ),
    );
  }
}
