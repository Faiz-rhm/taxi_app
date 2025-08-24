import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import '../../helper/constants/app_colors.dart';
import 'arrived_destination_screen.dart';
import 'cancel_booking_screen.dart';

class TrackDriverScreen extends StatefulWidget {
  const TrackDriverScreen({super.key});

  @override
  State<TrackDriverScreen> createState() => _TrackDriverScreenState();
}

class _TrackDriverScreenState extends State<TrackDriverScreen> {
  GoogleMapController? _mapController;

  // Sample coordinates for demonstration
  final LatLng _driverLocation = const LatLng(40.7128, -74.0060); // Worth St area
  final LatLng _passengerLocation = const LatLng(40.7147, -74.0068); // Chambers/Warren St area

  // State management
  String _currentState = 'arriving'; // 'arriving', 'arrived', 'picked_up'
  String _statusText = 'Driver is Arriving...';
  String _timeText = '5 min Away';
  String _buttonText = 'Cancel Ride';
  Timer? _stateTimer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _startStateTransition();
  }

  @override
  void dispose() {
    _stateTimer?.cancel();
    super.dispose();
  }

  void _startStateTransition() {
    _stateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;

        // State transitions based on time
        if (_elapsedSeconds >= 10 && _currentState == 'arriving') {
          // After 10 seconds, driver arrives
          _currentState = 'arrived';
          _statusText = 'Driver Arrived';
          _timeText = 'Driver is here';
          _buttonText = 'Get in Car';
        } else if (_elapsedSeconds >= 20 && _currentState == 'arrived') {
          // After 20 seconds, client is picked up
          _currentState = 'picked_up';
          _statusText = 'On the Way';
          _timeText = 'En route to destination';
          _buttonText = 'Track Journey';
        }
      });
    });
  }

  void _handleButtonAction() {
    switch (_currentState) {
      case 'arriving':
        // Navigate to cancel booking screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CancelBookingScreen(),
          ),
        );
        break;
      case 'arrived':
        // Get in car - simulate pickup
        setState(() {
          _currentState = 'picked_up';
          _statusText = 'On the Way';
          _timeText = 'En route to destination';
          _buttonText = 'Track Journey';
        });
        break;
      case 'picked_up':
        // Track journey - navigate to arrived destination
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ArrivedDestinationScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Section
          _buildMapSection(),

          // Header
          _buildHeader(),

          // Estimated Fare Banner
          _buildEstimatedFareBanner(),

          // Ride Details Card
          DraggableScrollableSheet(
            initialChildSize: 0.6, // Start at 60% of screen height
            minChildSize: 0.1, // Minimum 10% of screen height
            maxChildSize: 0.6, // Maximum 60% of screen height
            snap: true,
            shouldCloseOnMinExtent: true,
            builder: (context, scrollController) {
              return _buildRideDetailsCard(scrollController);
            },
          ),
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
          _fitMapBounds();
        },
        initialCameraPosition: CameraPosition(
          target: _driverLocation,
          zoom: 16.0,
        ),
        markers: _createMarkers(),
        polylines: _createRoute(),
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
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
                Icons.arrow_back,
                color: AppColors.primaryText,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          const Spacer(),

          // Title - changes based on state
          Text(
            _currentState == 'arriving' ? 'Driver Arriving' :
            _currentState == 'arrived' ? 'Driver Arrived' : 'On the Way',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          // Placeholder for balance
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildEstimatedFareBanner() {
    return Positioned(
      bottom: 100, // Above the ride details card
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '\$10.00 are your estimated fares for your ride',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideDetailsCard(ScrollController scrollController) {
    return Container(
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

          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Status Header
                  Row(
                    children: [
                      Text(
                        _statusText,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _timeText,
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Driver Information
                  Row(
                    children: [
                      // Driver Profile Picture
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/driver-profile');
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.borderLight,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Driver Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Jenny Wilson',
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Sedan',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Contact Options
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                // Handle chat
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                // Handle call
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Pickup and Destination Addresses
                  _buildAddressSection(),

                  const SizedBox(height: 24),

                  // Ride Specifics Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildRideSpecItem('Rate per', '\$1.25'),
                      ),
                      Expanded(
                        child: _buildRideSpecItem('Car Number', 'GR 678-UVWX'),
                      ),
                      Expanded(
                        child: _buildRideSpecItem('No. of Seats', '4 Seats'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Dynamic Button based on state
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _handleButtonAction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _buttonText,
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
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Pickup Address
          Row(
            children: [
              // Origin indicator (black circle with dot)
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.primaryText,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '6391 Elgin St. Celina, Delawa...',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // OTP Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'OTP - 8546',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          // Vertical dashed line
          Container(
            margin: const EdgeInsets.only(left: 7, top: 8, bottom: 8),
            width: 2,
            height: 20,
            child: CustomPaint(
              painter: DashedLinePainter(),
            ),
          ),

          // Destination Address
          Row(
            children: [
              // Destination indicator (orange map pin)
              Icon(
                Icons.place,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '1901 Thornridge Cir. Sh...',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRideSpecItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Set<Marker> _createMarkers() {
    return {
      // Driver marker (car icon)
      Marker(
        markerId: const MarkerId('driver'),
        position: _driverLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(title: 'Driver Location'),
      ),
      // Passenger marker (orange circle)
      Marker(
        markerId: const MarkerId('passenger'),
        position: _passengerLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),
    };
  }

  Set<Polyline> _createRoute() {
    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: [_driverLocation, _passengerLocation],
        color: AppColors.secondaryText,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      ),
    };
  }

  void _fitMapBounds() {
    if (_mapController != null) {
      double minLat = _driverLocation.latitude < _passengerLocation.latitude
          ? _driverLocation.latitude
          : _passengerLocation.latitude;
      double maxLat = _driverLocation.latitude > _passengerLocation.latitude
          ? _driverLocation.latitude
          : _passengerLocation.latitude;
      double minLng = _driverLocation.longitude < _passengerLocation.longitude
          ? _driverLocation.longitude
          : _passengerLocation.longitude;
      double maxLng = _driverLocation.longitude > _passengerLocation.longitude
          ? _driverLocation.longitude
          : _passengerLocation.longitude;

      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat - 0.002, minLng - 0.002),
            northeast: LatLng(maxLat + 0.002, maxLng + 0.002),
          ),
          50.0, // padding
        ),
      );
    }
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.borderLight
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashHeight = 3;
    const dashSpace = 4;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
