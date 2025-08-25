import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String _selectedAddressType = 'Home';
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  final List<String> _addressTypes = ['Home', 'Office', 'Parent\'s House', 'Friend\'s House'];

  // Google Maps variables
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng _currentLocation = const LatLng(40.7128, -74.0060); // Default to NYC
  LatLng _selectedLocation = const LatLng(40.7128, -74.0060);
  BitmapDescriptor? _customMarkerIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarkerIcon();
    _getCurrentLocation();
  }

  Future<void> _loadCustomMarkerIcon() async {
    _customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/images/pine1.png',
    );
    _addMarker();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _floorController.dispose();
    _landmarkController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map Section
            _buildMapSection(),

            // Address Form
            _buildAddressForm(),

            // Save Button
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }


    Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _selectedLocation = _currentLocation;
      });

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_currentLocation, 15.0),
        );
      }

      _addMarker();
    } catch (e) {
      // Handle error - keep default location
    }
  }

  void _addMarker() {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('selected_location'),
        position: _selectedLocation,
        icon: _customMarkerIcon ?? BitmapDescriptor.defaultMarker, // Will be updated to custom icon
        draggable: true,
        onDragEnd: (LatLng newPosition) {
          setState(() {
            _selectedLocation = newPosition;
          });
          _getAddressFromCoordinates(newPosition);
        },
        infoWindow: const InfoWindow(
          title: 'Selected Location',
          snippet: 'Drag to adjust position',
        ),
      ),
    );
  }

  Future<void> _getAddressFromCoordinates(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '${place.street}, ${place.locality}, ${place.administrativeArea}';

        setState(() {
          _addressController.text = address;
        });
      }
    } catch (e) {
      // Handle error - keep current address
    }
  }

  Widget _buildMapSection() {
    return SizedBox(
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
            if (_customMarkerIcon != null) {
              _addMarker();
            }
          },
          initialCameraPosition: CameraPosition(
            target: _currentLocation,
            zoom: 15.0,
          ),
          markers: _markers,
          onTap: (LatLng position) {
            setState(() {
              _selectedLocation = position;
              _addMarker();
            });
            _getAddressFromCoordinates(position);
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: false,
          mapType: MapType.normal,
        ),
      ),
    );
  }


  Widget _buildAddressForm() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address Type Selection
          _buildAddressTypeSection(),

          const SizedBox(height: 32),

          // Complete Address
          _buildFormField(
            label: 'Complete address',
            controller: _addressController,
            hintText: 'Enter address *',
            maxLines: 3,
            isRequired: true,
          ),

          const SizedBox(height: 24),

          // Floor
          _buildFormField(
            label: 'Floor',
            controller: _floorController,
            hintText: 'Enter Floor',
            isRequired: false,
          ),

          const SizedBox(height: 24),

          // Landmark
          _buildFormField(
            label: 'Landmark',
            controller: _landmarkController,
            hintText: 'Enter Landmark',
            isRequired: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Save address as *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _addressTypes.map((type) {
              bool isSelected = _selectedAddressType == type;
              return Container(
                margin: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAddressType = type;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFF2994A) // Orange when selected
                          : const Color(0xFFF5F5F5), // Light grey when not selected
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFF2994A)
                            : const Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isRequired ? const Color(0xFF242424) : const Color(0xFF9E9E9E),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFFF8F8F8),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF242424),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            _saveAddress();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF2994A), // Orange color
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: const Text(
            'Save address',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

    void _saveAddress() {
    // Validate required fields
    if (_addressController.text.trim().isEmpty) {
      _showSnackBar('Please enter the complete address');
      return;
    }

    // Show success message
    _showSnackBar('Address saved successfully!');

    // Create new address data
    final newAddress = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': _selectedAddressType,
      'address': _addressController.text.trim(),
      'type': _selectedAddressType,
      'floor': _floorController.text.trim(),
      'landmark': _landmarkController.text.trim(),
      'latitude': _selectedLocation.latitude,
      'longitude': _selectedLocation.longitude,
    };

    // You can add API call here to save the address with coordinates
    print('New Address: $newAddress');

    // Navigate back with the new address data
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context, newAddress);
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFF2994A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
