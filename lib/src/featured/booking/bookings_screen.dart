import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';
import '../profile/pre_booking_ride_screen.dart';
import '../../helper/constants/app_colors.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int _selectedTabIndex = 1; // 0: Active, 1: Completed, 2: Cancelled

  final List<String> _tabs = ['Active', 'Completed', 'Cancelled'];

  // Sample completed bookings data
  final List<Map<String, dynamic>> _completedBookings = [
    {
      'userName': 'Byron Barlow',
      'userImage': 'assets/images/byron.jpg', // Placeholder
      'vehicleType': 'MPV (5 Seater)',
      'rating': '5.0',
      'distance': '4.5 Mile',
      'duration': '4 mins',
      'pricePerMile': '\$1.25 /mile',
      'dateTime': 'Oct 18, 2023 | 08:00 AM',
      'pickupAddress': '6391 Elgin St. Celina, Delawa...',
      'destinationAddress': '1901 Thornridge Cir. Sh...',
      'carNumber': 'GR 678-UVWX',
      'seats': '05',
    },
    {
      'userName': 'Robert Fox',
      'userImage': 'assets/images/robert.jpg', // Placeholder
      'vehicleType': 'MPV (5 Seater)',
      'rating': '5.0',
      'distance': '4.5 Mile',
      'duration': '4 mins',
      'pricePerMile': '\$1.25 /mile',
      'dateTime': 'Oct 18, 2023 | 08:00 AM',
      'pickupAddress': '6391 Elgin St. Celina, Delawa...',
      'destinationAddress': '1901 Thornridge Cir. Sh...',
      'carNumber': 'GR 678-UVWX',
      'seats': '05',
    },
  ];

  // Sample cancelled bookings data
  final List<Map<String, dynamic>> _cancelledBookings = [
    {
      'userName': 'Cody Fisher',
      'userImage': 'assets/images/cody.jpg', // Placeholder
      'vehicleType': 'MPV (5 Seater)',
      'rating': '5.0',
      'distance': '4.5 Mile',
      'duration': '4 mins',
      'pricePerMile': '\$1.25 /mile',
      'dateTime': 'Oct 18, 2023 | 08:00 AM',
      'pickupAddress': '6391 Elgin St. Celina, Delawa...',
      'destinationAddress': '1901 Thornridge Cir. Sh...',
      'carNumber': 'GR 678-UVWX',
      'cancelledBy': 'driver',
    },
    {
      'userName': 'Ralph Edwards',
      'userImage': 'assets/images/ralph.jpg', // Placeholder
      'vehicleType': 'MPV (5 Seater)',
      'rating': '5.0',
      'distance': '4.5 Mile',
      'duration': '4 mins',
      'pricePerMile': '\$1.25 /mile',
      'dateTime': 'Oct 18, 2023 | 08:00 AM',
      'pickupAddress': '6391 Elgin St. Celina, Delawa...',
      'destinationAddress': '1901 Thornridge Cir. Sh...',
      'carNumber': 'GR 678-UVWX',
      'cancelledBy': 'user',
    },
  ];

  // Sample active bookings data
  final List<Map<String, dynamic>> _activeBookings = [
    {
      'userName': 'Jenny Wilson',
      'userImage': 'assets/images/jenny.jpg', // Placeholder
      'vehicleType': 'Sedan (4 Seater)',
      'rating': '5.0',
      'distance': '4.5 Mile',
      'duration': '4 mins',
      'pricePerMile': '\$1.25 /mile',
      'dateTime': 'Oct 18, 2023 | 08:00 AM',
      'pickupAddress': '6391 Elgin St. Celina, Delawa...',
      'destinationAddress': '1901 Thornridge Cir. Sh...',
      'carNumber': 'GR 678-UVWX',
      'seats': '04',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Bookings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: _tabs.asMap().entries.map((entry) {
                int index = entry.key;
                String tab = entry.value;
                bool isSelected = _selectedTabIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? const AppColors.primary : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? const AppColors.primary : const AppColors.hintText,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_selectedTabIndex == 0) { // Active tab
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _activeBookings.length,
        itemBuilder: (context, index) {
          return _buildActiveBookingCard(_activeBookings[index]);
        },
      );
    } else if (_selectedTabIndex == 1) { // Completed tab
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _completedBookings.length,
        itemBuilder: (context, index) {
          return _buildBookingCard(_completedBookings[index]);
        },
      );
    } else if (_selectedTabIndex == 2) { // Cancelled tab
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _cancelledBookings.length,
        itemBuilder: (context, index) {
          return _buildCancelledBookingCard(_cancelledBookings[index]);
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreBookingRideScreen(bookingData: booking),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryText.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information Section
            Row(
              children: [
                // Profile Picture
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const AppColors.borderLight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.hintText,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),

                // User Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['userName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking['vehicleType'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.hintText,
                        ),
                      ),
                    ],
                  ),
                ),

                // Rating
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFD700),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      booking['rating'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Ride Summary
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        booking['distance'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        booking['duration'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        booking['pricePerMile'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Date & Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date & Time',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.hintText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  booking['dateTime'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Route Details
            Row(
              children: [
                // Pickup
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryText,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          booking['pickupAddress'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Dashed line
            Container(
              margin: const EdgeInsets.only(left: 5),
              height: 20,
              child: CustomPaint(
                painter: DashedLinePainter(),
              ),
            ),

            // Destination
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          booking['destinationAddress'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Car Number
            Row(
              children: [
                Text(
                  'Car Number',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.hintText,
                  ),
                ),
                const Spacer(),
                Text(
                  booking['carNumber'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Expand/Collapse Indicator
            Center(
              child: Icon(
                Icons.keyboard_arrow_up,
                color: const AppColors.hintText,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveBookingCard(Map<String, dynamic> booking) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreBookingRideScreen(bookingData: booking),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryText.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information Section
            Row(
              children: [
                // Profile Picture
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const AppColors.borderLight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.hintText,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),

                // User Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['userName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking['vehicleType'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.hintText,
                        ),
                      ),
                    ],
                  ),
                ),

                // Rating
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFD700),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      booking['rating'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Ride Summary
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        booking['distance'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        booking['duration'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        booking['pricePerMile'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Date & Time
            Row(
              children: [
                Text(
                  'Date & Time',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.hintText,
                  ),
                ),
                const Spacer(),
                Text(
                  booking['dateTime'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Route Details
            Row(
              children: [
                // Pickup
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryText, // Black radio button
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          booking['pickupAddress'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Dashed line
            Container(
              margin: const EdgeInsets.only(left: 5),
              height: 20,
              child: CustomPaint(
                painter: DashedLinePainter(),
              ),
            ),

            // Destination
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary, // Orange location pin
                        size: 16,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          booking['destinationAddress'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Car Number
            Row(
              children: [
                Text(
                  'Car Number',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.hintText,
                  ),
                ),
                const Spacer(),
                Text(
                  booking['carNumber'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Map Section
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    // Placeholder for map
                    Container(
                      color: const AppColors.borderLight,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.map,
                              size: 32,
                              color: AppColors.hintText,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Route Map',
                              style: TextStyle(
                                color: AppColors.hintText,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Route line overlay
                    Positioned(
                      top: 30,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: const Color(0xFF424242),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),

                    // Pickup pin
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Destination pin
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle cancel action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: const AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.primary),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle reschedule action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const AppColors.primary,
                      foregroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Reschedule',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelledBookingCard(Map<String, dynamic> booking) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreBookingRideScreen(bookingData: booking),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA), // Light grey background as shown in image
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryText.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cancelled Label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const AppColors.primary, // Orange background
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                booking['cancelledBy'] == 'driver' ? 'Cancelled by Driver' : 'Cancelled by You',
                style: const TextStyle(
                  color: AppColors.surface,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Driver Information Section
            Row(
              children: [
                // Profile Picture
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const AppColors.borderLight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.hintText,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),

                // Driver Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['userName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking['vehicleType'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.hintText,
                        ),
                      ),
                    ],
                  ),
                ),

                // Rating
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFD700),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      booking['rating'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Ride Summary
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.my_location,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        booking['distance'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        booking['duration'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        booking['pricePerMile'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Date & Time
            Row(
              children: [
                Text(
                  'Date & Time',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.hintText,
                  ),
                ),
                const Spacer(),
                Text(
                  booking['dateTime'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Route Details
            Row(
              children: [
                // Pickup
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const AppColors.primary, // Orange circle
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const AppColors.primaryText, // Black dot inside
                            width: 3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          booking['pickupAddress'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Dashed line
            Container(
              margin: const EdgeInsets.only(left: 5),
              height: 20,
              child: CustomPaint(
                painter: DashedLinePainter(),
              ),
            ),

            // Destination
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary, // Orange location pin
                        size: 16,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          booking['destinationAddress'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Car Number
            Row(
              children: [
                Text(
                  'Car Number',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.hintText,
                  ),
                ),
                const Spacer(),
                Text(
                  booking['carNumber'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Expand/Collapse Indicator
            Center(
              child: Icon(
                Icons.keyboard_arrow_up,
                color: const AppColors.hintText,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const AppColors.borderLight
      ..strokeWidth = 1.0;

    const dashHeight = 3.0;
    const dashSpace = 3.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
