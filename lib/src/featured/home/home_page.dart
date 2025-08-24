import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/services/map_config_service.dart';
import '../../helper/constants/app_colors.dart';
import 'pickup_location_screen.dart';
import 'destination_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GoogleMapController? _mapController;
  LatLng? _currentUserLocation;


  // Default location (New York City) - fallback if location not available
  static const CameraPosition _defaultLocation = CameraPosition(
    target: LatLng(40.7128, -74.0060),
    zoom: 14.0,
  );

  Set<Marker> _carMarkers = {};
  Set<Marker> _currentLocationMarker = {};

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _createCarMarkers();
  }

  @override
  void dispose() {
    MapConfigService().disposeMapController(_mapController);
    super.dispose();
  }

  Future<void> _initializeLocation() async {
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
          _updateCurrentLocationMarker();
          _createCarMarkers(); // Recreate car markers near user's location

          // Update map camera to user's location only if map is ready
          if (_mapController != null && _currentUserLocation != null) {
            try {
              _mapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _currentUserLocation!,
                    zoom: 14.0, // Slightly zoomed out to show car markers
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
    }
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
            initialChildSize: 0.35, // Start at 30% of screen height
            minChildSize: 0.1, // Minimum 30% of screen height
            maxChildSize: 0.35, // Maximum 80% of screen height
            snap: true,
            shouldCloseOnMinExtent: true,
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
            debugPrint('Map created. Current markers: ${_carMarkers.length} cars, ${_currentLocationMarker.length} location markers');

            // Ensure markers are created if not already done
            if (_carMarkers.isEmpty) {
              _createCarMarkers();
            }

            // Try to get user location after map is created
            if (_currentUserLocation != null) {
              try {
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _currentUserLocation!,
                      zoom: 14.0,
                    ),
                  ),
                );
              } catch (e) {
                debugPrint('Map camera update error: $e');
              }
            }
          },
          initialCameraPosition: _currentUserLocation != null
              ? CameraPosition(target: _currentUserLocation!, zoom: 14.0)
              : _defaultLocation,
          markers: {..._carMarkers, ..._currentLocationMarker},
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

        // Current Location Bar
        Positioned(
          top: MediaQuery.of(context).padding.top + 32,
          left: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PickupLocationScreen(),
                ),
              );
            },
            child: _buildCurrentLocationBar(),
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildDraggableContentPanel(ScrollController scrollController) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with "Where to?" and "MANAGE"
                  Row(
                    children: [
                      const Text(
                        "Where to?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "MANAGE",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),

                  // Destination Options
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                                              // Destination Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DestinationScreen(),
                              ),
                            );
                          },
                          child: _buildDestinationCard(
                            iconData: Icons.place,
                            title: "Destination",
                            subtitle: "Enter Destination",
                            isHighlighted: true,
                          ),
                        ),
                      ),

                        const SizedBox(width: 16),

                        // Office Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Handle office selection
                            },
                            child: _buildDestinationCard(
                              iconData: Icons.business_center,
                              title: "Office",
                              subtitle: "35 Km Away",
                              isHighlighted: false,
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Office Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Handle office selection
                            },
                            child: _buildDestinationCard(
                              iconData: Icons.home,
                              title: "Home",
                              subtitle: "100 Km Away",
                              isHighlighted: false,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildCurrentLocationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Orange dot indicator
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),

          // Current Location text
          const Text(
            "Current Location",
            style: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),

          const Spacer(),

                    // Arrow indicator
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primary,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard({
    required IconData iconData,
    required String title,
    required String subtitle,
    required bool isHighlighted,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      width: 170,
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: isHighlighted
            ? null
            : Border.all(color: AppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isHighlighted ? Colors.white : Colors.black,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: isHighlighted ? AppColors.primary : Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            title,
            style: TextStyle(
              color: isHighlighted ? Colors.white : AppColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle
          Text(
            subtitle,
            style: TextStyle(
              color: isHighlighted
                                      ? Colors.white.withValues(alpha: 0.9)
                  : AppColors.secondaryText,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _createCarMarkers() async {
    // If user location is not available, use default location (NYC)
    final LatLng baseLocation = _currentUserLocation ?? const LatLng(40.7128, -74.0060);

    final icon = await BitmapDescriptor.asset(const ImageConfiguration(size: Size(48, 48)), 'assets/images/car.png');

    // Generate car markers near the user's location with better spacing
    setState(() {
      _carMarkers = {
        Marker(
          markerId: const MarkerId('car1'),
          position: LatLng(baseLocation.latitude + 0.003, baseLocation.longitude - 0.002),
          icon: icon,
          infoWindow: const InfoWindow(title: 'Available Taxi 1'),
        ),
        Marker(
          markerId: const MarkerId('car2'),
          position: LatLng(baseLocation.latitude - 0.002, baseLocation.longitude + 0.004),
          icon: icon,
          infoWindow: const InfoWindow(title: 'Available Taxi 2'),
        ),
        Marker(
          markerId: const MarkerId('car3'),
          position: LatLng(baseLocation.latitude + 0.001, baseLocation.longitude + 0.003),
          icon: icon,
          infoWindow: const InfoWindow(title: 'Available Taxi 3'),
        ),
        Marker(
          markerId: const MarkerId('car4'),
          position: LatLng(baseLocation.latitude - 0.004, baseLocation.longitude - 0.001),
          icon: icon,
          infoWindow: const InfoWindow(title: 'Available Taxi 4'),
        ),
        Marker(
          markerId: const MarkerId('car5'),
          position: LatLng(baseLocation.latitude + 0.002, baseLocation.longitude + 0.001),
          icon: icon,
          infoWindow: const InfoWindow(title: 'Available Taxi 5'),
        ),
      };
    });
    debugPrint('Created ${_carMarkers.length} car markers around location: ${baseLocation.latitude}, ${baseLocation.longitude}');
  }

  Future<void> _updateCurrentLocationMarker() async {
    final icon = await BitmapDescriptor.asset(const ImageConfiguration(size: Size(48, 48)), 'assets/images/pine.png');

    if (_currentUserLocation != null) {
      setState(() {
        _currentLocationMarker = {
          Marker(
            markerId: const MarkerId('current_location'),
            position: _currentUserLocation!,
            icon: icon,
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        };
      });
    }
  }
}

