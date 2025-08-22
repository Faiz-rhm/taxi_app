import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/services/map_config_service.dart';
// import 'booking_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _currentIndex = 0;
  GoogleMapController? _mapController;
  LatLng? _currentUserLocation;
  bool _isLocationLoading = false;

  // Default location (New York City) - fallback if location not available
  static const CameraPosition _defaultLocation = CameraPosition(
    target: LatLng(40.7128, -74.0060),
    zoom: 14.0,
  );

  // Sample car locations (you can replace with real data)
  final Set<Marker> _carMarkers = {
    Marker(
      markerId: const MarkerId('car1'),
      position: const LatLng(40.7128, -74.0060),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: const MarkerId('car2'),
      position: const LatLng(40.7140, -74.0080),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: const MarkerId('car3'),
      position: const LatLng(40.7100, -74.0040),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
  };

  // Current location marker
  final Set<Marker> _currentLocationMarker = {
    Marker(
      markerId: const MarkerId('current_location'),
      position: const LatLng(40.7128, -74.0060),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ),
  };

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  @override
  void dispose() {
    MapConfigService().disposeMapController(_mapController);
    super.dispose();
  }

  Future<void> _initializeLocation() async {
    setState(() {
      _isLocationLoading = true;
    });

    try {
      // Check location permission
      PermissionStatus permissionStatus = await Permission.location.status;

      if (permissionStatus.isGranted) {
        // Check if location services are enabled
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

        if (serviceEnabled) {
          // Get current position
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            timeLimit: const Duration(seconds: 10),
          );

          setState(() {
            _currentUserLocation = LatLng(position.latitude, position.longitude);
          });

          // Update map camera to user's location only if map is ready
          if (_mapController != null && _currentUserLocation != null) {
            try {
              _mapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _currentUserLocation!,
                    zoom: 15.0,
                  ),
                ),
              );
            } catch (e) {
              // Handle any map controller errors gracefully
              debugPrint('Map camera update error: $e');
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      // Keep default location if there's an error
    } finally {
      setState(() {
        _isLocationLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLocationLoading = true;
    });

    try {
      // Check location permission
      PermissionStatus permissionStatus = await Permission.location.status;

      if (permissionStatus.isGranted) {
        // Check if location services are enabled
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

        if (serviceEnabled) {
          // Get current position
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            timeLimit: const Duration(seconds: 10),
          );

          setState(() {
            _currentUserLocation = LatLng(position.latitude, position.longitude);
          });

          // Update map camera to user's location only if map is ready
          if (_mapController != null && _currentUserLocation != null) {
            try {
              _mapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                  MapConfigService().getOptimizedCameraPosition(_currentUserLocation!),
                ),
              );
            } catch (e) {
              // Handle any map controller errors gracefully
              debugPrint('Map camera update error: $e');
            }
          }
        } else {
          // Show dialog to enable location services
          _showEnableLocationDialog();
        }
      } else {
        // Show dialog to request location permission
        _showRequestPermissionDialog();
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting location: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLocationLoading = false;
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

  void _showRequestPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
            'Location permission is required to show your current location on the map.',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Section (Full screen)
          _buildMapSection(),

          // Draggable Sheet for "Where to?" section
          DraggableScrollableSheet(
            initialChildSize: 0.35, // Start at 35% of screen height
            minChildSize: 0.25, // Minimum 25% of screen height
            maxChildSize: 0.7, // Maximum 70% of screen height
            builder: (context, scrollController) {
              return _buildDraggableContentPanel(scrollController);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
      children: [
        // Google Maps with optimized configuration
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
            // Try to get user location after map is created
            if (_currentUserLocation != null) {
              try {
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    MapConfigService().getOptimizedCameraPosition(_currentUserLocation!),
                  ),
                );
              } catch (e) {
                debugPrint('Map camera update error: $e');
              }
            }
          },
          initialCameraPosition: _currentUserLocation != null
              ? MapConfigService().getOptimizedCameraPosition(_currentUserLocation!)
              : _defaultLocation,
          markers: MapConfigService().getOptimizedMarkers({..._carMarkers, ..._currentLocationMarker}),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: false,
          mapType: MapType.normal,
          liteModeEnabled: false,
          trafficEnabled: false,
          buildingsEnabled: false,
          indoorViewEnabled: false,
          onCameraMove: null,
          onCameraIdle: null,
        ),

        // Search Bar
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: _buildSearchBar(),
        ),

        // Location Button
        Positioned(
          top: 100,
          right: 20,
          child: _buildLocationButton(),
        ),
      ],
      ),
    );
  }

  Widget _buildDraggableContentPanel(ScrollController scrollController) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag Handle
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with "Where to?" and "MANAGE"
                  Row(
                    children: [
                      const Text(
                        "Where to?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF242424),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Handle manage action
                        },
                        child: const Text(
                          "MANAGE",
                          style: TextStyle(
                            color: Color(0xFFF2994A),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Destination Options
                  Row(
                    children: [
                      // Destination Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const BookingScreen(),
                            //   ),
                            // );
                          },
                          child: _buildDestinationButton(
                            icon: Icons.location_on,
                            title: "Destination",
                            subtitle: "Enter Destination",
                            backgroundColor: const Color(0xFFF2994A),
                            textColor: Colors.white,
                            iconColor: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Office Button
                      Expanded(
                        child: _buildDestinationButton(
                          icon: Icons.business,
                          title: "Office",
                          subtitle: "35 Km Away",
                          backgroundColor: Colors.white,
                          textColor: const Color(0xFF242424),
                          iconColor: const Color(0xFF242424),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Quick Book Now Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const BookingScreen(),
                        //   ),
                        // );
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
                        "Book Now",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Orange dot
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFF2994A),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),

          // Current Location text
          const Text(
            "Current Location",
            style: TextStyle(
              color: Color(0xFF242424),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          const Spacer(),

          // Bookmark icon
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFFF2994A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationButton() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        onPressed: _isLocationLoading ? null : _getCurrentLocation,
        icon: _isLocationLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF2994A)),
                ),
              )
            : const Icon(
                Icons.my_location,
                color: Color(0xFFF2994A),
                size: 24,
              ),
      ),
    );
  }



  Widget _buildDestinationButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required Color textColor,
    required Color iconColor,
  }) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: backgroundColor == Colors.white
            ? Border.all(color: const Color(0xFFE0E0E0))
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: textColor.withOpacity(0.8),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
