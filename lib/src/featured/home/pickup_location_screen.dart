import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../helper/constants/app_colors.dart';
import 'book_ride_screen.dart';

class PickupLocationScreen extends StatefulWidget {
  const PickupLocationScreen({super.key});

  @override
  State<PickupLocationScreen> createState() => _PickupLocationScreenState();
}

class _PickupLocationScreenState extends State<PickupLocationScreen> {
  final TextEditingController _addressController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  LatLng? _currentUserLocation;
  bool _isLocationLoading = false;
  Set<Marker> _markers = {};

  // Default location (New York City)
  static const CameraPosition _defaultLocation = CameraPosition(
    target: LatLng(40.7128, -74.0060),
    zoom: 15.0,
  );

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _loadSampleAddress();
  }

  void _loadSampleAddress() {
    _addressController.text = "6391 Elgin St. Celina, Delawa...";
  }

  @override
  void dispose() {
    _addressController.dispose();
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
            _selectedLocation = _currentUserLocation;
          });

          // Update markers
          _updateMarkers();

          // Update map camera to user's location
          if (_mapController != null && _currentUserLocation != null) {
            _mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: _currentUserLocation!,
                  zoom: 15.0,
                ),
              ),
            );
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
      if (_currentUserLocation != null) {
        setState(() {
          _selectedLocation = _currentUserLocation;
        });

        // Update markers
        _updateMarkers();

        if (_mapController != null) {
          _mapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _currentUserLocation!,
                zoom: 15.0,
              ),
            ),
          );
        }
      } else {
        await _initializeLocation();
      }
    } catch (e) {
      debugPrint('Error getting current location: $e');
    } finally {
      setState(() {
        _isLocationLoading = false;
      });
    }
  }

  void _clearAddress() {
    _addressController.clear();
    setState(() {
      _selectedLocation = null;
      _markers.clear();
    });
  }

  void _confirmLocation() {
    if (_selectedLocation != null) {
      // Navigate to the book ride screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookRideScreen(
            pickupLocation: _selectedLocation!,
            destinationLocation: null, // Will be set later
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a location on the map'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });

    // Update markers
    _updateMarkers();

    // Update the address text (in a real app, you'd reverse geocode this)
    _addressController.text = "Selected Location (${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)})";
  }

  Future<void> _updateMarkers() async {
    if (_selectedLocation == null) {
      setState(() {
        _markers.clear();
      });
      return;
    }

    try {
      final icon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(30, 48)),
        'assets/images/pine1.png'
      );

      setState(() {
        _markers = {
          Marker(
            markerId: const MarkerId('pickup_location'),
            position: _selectedLocation!,
            icon: icon,
            infoWindow: const InfoWindow(title: 'Pick-up Location'),
          ),
        };
      });
    } catch (e) {
      debugPrint('Error loading marker icon: $e');
      // Fallback to default marker if custom icon fails
      setState(() {
        _markers = {
          Marker(
            markerId: const MarkerId('pickup_location'),
            position: _selectedLocation!,
            infoWindow: const InfoWindow(title: 'Pick-up Location'),
          ),
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
          _buildMap(),

          // Top Header
          _buildTopHeader(),

          // Address Input Field
          _buildAddressInput(),

          // Current Location Button
          _buildCurrentLocationButton(),

          // Confirm Location Button
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        if (_currentUserLocation != null) {
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _currentUserLocation!,
                zoom: 15.0,
              ),
            ),
          );
        }
      },
      initialCameraPosition: _currentUserLocation != null
          ? CameraPosition(target: _currentUserLocation!, zoom: 15.0)
          : _defaultLocation,
      markers: _markers,
      onTap: _onMapTap,
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
    );
  }

  Widget _buildTopHeader() {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            // Back Button
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
              ),
            ),

            Spacer(),

            // Title
            const Text(
              "Pick-up",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(width: 50),

            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressInput() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 80,
      left: 16,
      right: 16,
      child: TextField(
          controller: _addressController,
          decoration: InputDecoration(
            hintText: "Enter your pick-up address",
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16),
            prefixIcon: Icon(Icons.search, color: AppColors.primary),
            suffixIcon: _addressController.text.isNotEmpty ? IconButton(
              onPressed: _clearAddress,
              icon: Icon(Icons.close_outlined, color: AppColors.primary)) : null,
          ),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.primaryText,
          ),
          onChanged: (value) {
            // Handle address input changes
            // In a real app, you'd implement address autocomplete here
          },
        ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return Positioned(
      bottom: Platform.isIOS ? 200 : 130,
      right: 16,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
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
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                )
              : Icon(
                  Icons.my_location,
                  color: AppColors.primary,
                  size: 24,
                ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _selectedLocation != null ? _confirmLocation : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Confirm Location",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
