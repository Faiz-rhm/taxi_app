import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../helper/constants/app_colors.dart';
import 'pay_cash_screen.dart';

class ArrivedDestinationScreen extends StatefulWidget {
  const ArrivedDestinationScreen({super.key});

  @override
  State<ArrivedDestinationScreen> createState() => _ArrivedDestinationScreenState();
}

class _ArrivedDestinationScreenState extends State<ArrivedDestinationScreen> {
  GoogleMapController? _mapController;

  // Sample coordinates for destination
  final LatLng _destinationLocation = const LatLng(40.7128, -74.0060); // Worth St & Broadway area

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Section
          _buildMapSection(),

          // Header
          _buildHeader(),

          // SOS Button
          _buildSOSButton(),

          // Current Location Button
          _buildCurrentLocationButton(),

          // Bottom Information Card
          _buildBottomCard(),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _fitMapToDestination();
        },
        initialCameraPosition: CameraPosition(
          target: _destinationLocation,
          zoom: 16.0,
        ),
        markers: _createDestinationMarker(),
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        compassEnabled: false,
        mapType: MapType.normal,
        liteModeEnabled: false,
        trafficEnabled: false,
        buildingsEnabled: false,
        indoorViewEnabled: false,
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      left: 20,
      right: 20,
      child: Row(
        children: [
          // Back Button
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primaryText,
                size: 18,
              ),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
            ),
          ),

          const Spacer(),

          // Title
          const Text(
            'Arrived At Destination',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          // Placeholder for balance
          const SizedBox(width: 32),
        ],
      ),
    );
  }

  Widget _buildSOSButton() {
    return Positioned(
      left: 20,
      top: MediaQuery.of(context).size.height * 0.4,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'SOS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return Positioned(
      right: 20,
      bottom: 280,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.my_location,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            _fitMapToDestination();
          },
        ),
      ),
    );
  }

  Widget _buildBottomCard() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
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
          mainAxisSize: MainAxisSize.min,
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

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Confirmation Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Confirmation Text
                  const Text(
                    'Arrived At Destination',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Address Details
                  Text(
                    '6391 Elgin St. Celina, Delawa...',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Payment Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to pay cash screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PayCashScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Pay Cash \$12.5',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> _createDestinationMarker() {
    return {
      // Destination marker (orange map pin)
      Marker(
        markerId: const MarkerId('destination'),
        position: _destinationLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    };
  }

  void _fitMapToDestination() {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          _destinationLocation,
          16.0,
        ),
      );
    }
  }
}
