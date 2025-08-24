import 'package:flutter/material.dart';
import '../profile/pre_booking_ride_screen.dart';
import '../../helper/constants/app_colors.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> with TickerProviderStateMixin {
  // Sample completed bookings data
  final List<Map<String, dynamic>> _completedBookings = [
    {
      'userName': 'Byron Barlow',
              'userImage': 'assets/images/user2.png', // User image
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
              'userImage': 'assets/images/user3.png', // User image
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
              'userImage': 'assets/images/user4.jpg', // User image
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
              'userImage': 'assets/images/user5.jpg', // User image
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
              'userImage': 'assets/images/user6.jpg', // User image
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
    return DefaultTabController(
      length: 3,
      initialIndex: 1, // Start with Completed tab
      child: Scaffold(
        appBar: AppBar(
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
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.hintText,
            dividerColor: AppColors.borderLight,
            indicatorColor: AppColors.primary,
            indicatorWeight: 2,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // Active Tab
            ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _activeBookings.length,
              itemBuilder: (context, index) {
                return _buildActiveBookingCard(_activeBookings[index]);
              },
            ),
            // Completed Tab
            ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _completedBookings.length,
              itemBuilder: (context, index) {
                return _buildBookingCard(_completedBookings[index]);
              },
            ),
            // Cancelled Tab
            ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _cancelledBookings.length,
              itemBuilder: (context, index) {
                return _buildCancelledBookingCard(_cancelledBookings[index]);
              },
            ),
          ],
        ),
      ),
    );
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
              color: AppColors.shadowLight,
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
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset(booking['userImage']),
                ),
                const SizedBox(width: 16),

                // User Details
                Column(
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

                Spacer(),

                // Rating
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.rating5,
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

            const SizedBox(height: 16),

            Divider(
              color: AppColors.borderLight,
              height: 1,
            ),

            const SizedBox(height: 16),

            // Ride Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                Row(
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
                Row(
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
              ],
            ),

            const SizedBox(height: 20),

            // Date & Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

            const SizedBox(height: 16),

            Divider(
              color: AppColors.borderLight,
              height: 1,
            ),

            const SizedBox(height: 16),

            // Route Details
            Row(
              children: [
                // Pickup
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.circle_outlined),
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
              margin: const EdgeInsets.only(left: 12),
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

            const SizedBox(height: 16),

            Divider(
              color: AppColors.borderLight,
              height: 1,
            ),

            const SizedBox(height: 16),

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
                color: AppColors.hintText,
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
              color: AppColors.shadowLight,
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
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset(booking['userImage']),
                ),
                const SizedBox(width: 16),

                // User Details
                Column(
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

                const Spacer(),

                // Rating
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.rating5,
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

            const SizedBox(height: 16),

            Divider(
              color: AppColors.borderLight,
              height: 1,
            ),

            const SizedBox(height: 16),

            // Ride Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                Row(
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
                Row(
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

            const SizedBox(height: 16),

            Divider(
              color: AppColors.borderLight,
              height: 1,
            ),

            const SizedBox(height: 16),

            // Route Details
            Row(
              children: [
                // Pickup
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.circle_outlined),
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
              margin: const EdgeInsets.only(left: 12),
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

            const SizedBox(height: 16),

            Divider(
              color: AppColors.borderLight,
              height: 1,
            ),

            const SizedBox(height: 16),

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
                color: AppColors.backgroundVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    // Placeholder for map
                    Container(
                      color: AppColors.borderLight,
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
                          color: AppColors.dark,
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
                      backgroundColor: AppColors.light,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
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
                      backgroundColor: AppColors.primary,
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

            const SizedBox(height: 20),
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
          color: AppColors.backgroundVariant, // Light grey background as shown in image
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
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
                color: AppColors.primary.withOpacity(0.1), // Orange background
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                booking['cancelledBy'] == 'driver' ? 'Cancelled by Driver' : 'Cancelled by You',
                style: const TextStyle(
                  color: AppColors.primary,
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
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset(booking['userImage']),
                ),
                const SizedBox(width: 16),

                // Driver Details
                Column(
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

                Spacer(),

                // Rating
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.rating5,
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

            const SizedBox(height: 16),

            Divider(
              color: AppColors.borderLight,
              height: 1,
            ),

            const SizedBox(height: 16),

            // Ride Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                Row(
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
                Row(
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

            const SizedBox(height: 16),

            Divider(
              color: AppColors.borderLight,
              height: 1,
            ),

            const SizedBox(height: 16),

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
                          color: AppColors.primary, // Orange circle
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryText, // Black dot inside
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

            const SizedBox(height: 16),

            Divider(
              color: AppColors.borderLight,
              height: 1,
            ),

            const SizedBox(height: 16),

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
                color: AppColors.hintText,
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
      ..color = AppColors.borderLight
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
