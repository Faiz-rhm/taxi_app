import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

// Main Screen Widget
class PreBookingRideScreen extends StatefulWidget {
  const PreBookingRideScreen({super.key});

  @override
  State<PreBookingRideScreen> createState() => _PreBookingRideScreenState();
}

class _PreBookingRideScreenState extends State<PreBookingRideScreen> {
  int _selectedDateIndex = 2; // Wednesday 18th is selected by default

  final List<Map<String, String>> _dates = [
    {'day': 'M', 'date': '16'},
    {'day': 'T', 'date': '17'},
    {'day': 'W', 'date': '18'},
    {'day': 'T', 'date': '19'},
    {'day': 'F', 'date': '20'},
    {'day': 'S', 'date': '21'},
    {'day': 'S', 'date': '22'},
  ];

  // Sample completed bookings data
  final List<Map<String, dynamic>> _completedBookings = [
    {
      'userName': 'Byron Barlow',
      'userImage': 'assets/images/user2.png',
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
      'userImage': 'assets/images/user3.png',
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
      'userImage': 'assets/images/user4.jpg',
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
      'userImage': 'assets/images/user5.jpg',
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
      'userImage': 'assets/images/user6.jpg',
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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        dates: _dates,
        selectedDateIndex: _selectedDateIndex,
        onDateSelected: (index) {
          setState(() {
            _selectedDateIndex = index;
          });
        },
      ),
      body: BookingsList(
        activeBookings: _activeBookings,
        completedBookings: _completedBookings,
        cancelledBookings: _cancelledBookings,
      ),
    );
  }
}

// Custom App Bar Component
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Map<String, String>> dates;
  final int selectedDateIndex;
  final Function(int) onDateSelected;

  const CustomAppBar({
    super.key,
    required this.dates,
    required this.selectedDateIndex,
    required this.onDateSelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Pre-Booked Rides',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF242424),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: DateSelector(
          dates: dates,
          selectedDateIndex: selectedDateIndex,
          onDateSelected: onDateSelected,
        ),
      ),
    );
  }
}

// Date Selector Component
class DateSelector extends StatelessWidget {
  final List<Map<String, String>> dates;
  final int selectedDateIndex;
  final Function(int) onDateSelected;

  const DateSelector({
    super.key,
    required this.dates,
    required this.selectedDateIndex,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: dates.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, String> date = entry.value;
          bool isSelected = selectedDateIndex == index;

          return Expanded(
            child: DateItem(
              day: date['day']!,
              date: date['date']!,
              isSelected: isSelected,
              onTap: () => onDateSelected(index),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Individual Date Item Component
class DateItem extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateItem({
    super.key,
    required this.day,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF2994A) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF242424),
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xFF242424),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bookings List Component
class BookingsList extends StatelessWidget {
  final List<Map<String, dynamic>> activeBookings;
  final List<Map<String, dynamic>> completedBookings;
  final List<Map<String, dynamic>> cancelledBookings;

  const BookingsList({
    super.key,
    required this.activeBookings,
    required this.completedBookings,
    required this.cancelledBookings,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Active Bookings
        ...activeBookings.map((booking) => PreBookingCard(booking: booking)),
        if (activeBookings.isNotEmpty) ...[
          const SizedBox(height: 16),
        ],

        // Completed Bookings
        ...completedBookings.map((booking) => PreBookingCard(booking: booking)),
        if (completedBookings.isNotEmpty) ...[
          const SizedBox(height: 16),
        ],

        // Cancelled Bookings
        ...cancelledBookings.map((booking) => PreBookingCard(booking: booking)),
      ],
    );
  }
}

// Pre-Booking Card Component
class PreBookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;

  const PreBookingCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Driver/Vehicle Information Section
          DriverInfoSection(booking: booking),

          const SizedBox(height: 16),
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: 16),

          // Ride Summary
          RideSummarySection(booking: booking),

          const SizedBox(height: 20),

          // Date & Time
          DateTimeSection(booking: booking),

          const SizedBox(height: 16),
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: 16),

          // Route Details
          RouteDetailsSection(booking: booking),

          const SizedBox(height: 16),
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: 16),

          // Vehicle Specifics
          VehicleSpecificsSection(booking: booking),

          const SizedBox(height: 20),

          // Action Buttons
          ActionButtonsSection(),

          const SizedBox(height: 16),

          // Expand/Collapse Indicator
          const ExpandIndicator(),
        ],
      ),
    );
  }
}

// Driver Info Section Component
class DriverInfoSection extends StatelessWidget {
  final Map<String, dynamic> booking;

  const DriverInfoSection({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profile Picture
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Image.asset(booking['userImage']),
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
                  color: Color(0xFF242424),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                booking['vehicleType'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ),

        // Rating
        RatingDisplay(rating: booking['rating']),
      ],
    );
  }
}

// Rating Display Component
class RatingDisplay extends StatelessWidget {
  final String rating;

  const RatingDisplay({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Color(0xFFFFD700),
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          rating,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424),
          ),
        ),
      ],
    );
  }
}

// Ride Summary Section Component
class RideSummarySection extends StatelessWidget {
  final Map<String, dynamic> booking;

  const RideSummarySection({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RideInfoItem(
          icon: Icons.location_on,
          value: booking['distance'],
        ),
        RideInfoItem(
          icon: Icons.access_time,
          value: booking['duration'],
        ),
        RideInfoItem(
          icon: Icons.attach_money,
          value: booking['pricePerMile'],
        ),
      ],
    );
  }
}

// Ride Info Item Component
class RideInfoItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const RideInfoItem({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFFF2994A),
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF242424),
          ),
        ),
      ],
    );
  }
}

// Date Time Section Component
class DateTimeSection extends StatelessWidget {
  final Map<String, dynamic> booking;

  const DateTimeSection({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Date & Time',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF9E9E9E),
          ),
        ),
        const Spacer(),
        Text(
          booking['dateTime'],
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424),
          ),
        ),
      ],
    );
  }
}

// Route Details Section Component
class RouteDetailsSection extends StatelessWidget {
  final Map<String, dynamic> booking;

  const RouteDetailsSection({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Pickup
        RoutePoint(
          icon: Icons.circle_outlined,
          address: booking['pickupAddress'],
        ),

        // Dashed line
        const DashedLine(),

        // Destination
        RoutePoint(
          icon: Icons.location_on,
          address: booking['destinationAddress'],
          iconColor: const Color(0xFFF2994A),
        ),
      ],
    );
  }
}

// Route Point Component
class RoutePoint extends StatelessWidget {
  final IconData icon;
  final String address;
  final Color? iconColor;

  const RoutePoint({
    super.key,
    required this.icon,
    required this.address,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? Colors.black,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF242424),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Dashed Line Component
class DashedLine extends StatelessWidget {
  const DashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      height: 20,
      child: CustomPaint(
        painter: DashedLinePainter(),
      ),
    );
  }
}

// Vehicle Specifics Section Component
class VehicleSpecificsSection extends StatelessWidget {
  final Map<String, dynamic> booking;

  const VehicleSpecificsSection({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VehicleInfoRow(
          label: 'Car Number',
          value: booking['carNumber'],
        ),
        const SizedBox(height: 12),
        VehicleInfoRow(
          label: 'No. of Seats',
          value: booking['seats'] ?? '05',
        ),
      ],
    );
  }
}

// Vehicle Info Row Component
class VehicleInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const VehicleInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9E9E9E),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424),
          ),
        ),
      ],
    );
  }
}

// Action Buttons Section Component
class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ActionButton(
          icon: Icons.close,
          onTap: () {
            // Handle cancel action
          },
        ),
        const SizedBox(width: 16),
        ActionButton(
          icon: Icons.chat_bubble_outline,
          onTap: () {
            // Handle chat action
          },
        ),
        const SizedBox(width: 16),
        ActionButton(
          icon: Icons.call,
          onTap: () {
            // Handle call action
          },
        ),
      ],
    );
  }
}

// Action Button Component
class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Color(0xFFF2994A),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}

// Expand Indicator Component
class ExpandIndicator extends StatelessWidget {
  const ExpandIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.keyboard_arrow_up,
        color: Color(0xFF9E9E9E),
        size: 20,
      ),
    );
  }
}

// Dashed Line Painter
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE0E0E0)
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
