import 'package:flutter/material.dart';

class PreBookingRideScreen extends StatefulWidget {
  final Map<String, dynamic> bookingData;

  const PreBookingRideScreen({
    super.key,
    required this.bookingData,
  });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: _dates.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> date = entry.value;
                bool isSelected = _selectedDateIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDateIndex = index;
                      });
                    },
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
                            date['day']!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : const Color(0xFF242424),
                            ),
                          ),
                          Text(
                            date['date']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : const Color(0xFF242424),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildPreBookingCard(widget.bookingData),
          const SizedBox(height: 16),
          _buildPreBookingCard({
            'userName': 'Robert Fox',
            'userImage': 'assets/images/user3.png',
            'vehicleType': 'MPV (5 Seater)',
            'rating': '5.0',
            'distance': '4.5 mile',
            'duration': '4 mins',
            'pricePerMile': '\$1.25 /mile',
            'dateTime': 'Oct 18, 2023 | 08:00 AM',
            'pickupAddress': '6391 Elgin St. Celina, Delawa...',
            'destinationAddress': '1901 Thornridge Cir. Sh...',
            'carNumber': 'GR 678-UVWX',
            'seats': '05',
          }),
        ],
      ),
    );
  }

  Widget _buildPreBookingCard(Map<String, dynamic> booking) {
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
          Row(
            children: [
              // Profile Picture
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF9E9E9E),
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
                      color: Color(0xFF242424),
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
                      color: Color(0xFFF2994A),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      booking['distance'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF242424),
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
                      color: Color(0xFFF2994A),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      booking['duration'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF242424),
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
                      color: Color(0xFFF2994A),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      booking['pricePerMile'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF242424),
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
                        color: Color(0xFF242424),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        booking['pickupAddress'],
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
                      color: Color(0xFFF2994A),
                      size: 16,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        booking['destinationAddress'],
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
          ),

          const SizedBox(height: 20),

          // Vehicle Specifics
          Row(
            children: [
              Text(
                'Car Number',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                ),
              ),
              const Spacer(),
              Text(
                booking['carNumber'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF242424),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Text(
                'No. of Seats',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                ),
              ),
              const Spacer(),
              Text(
                booking['seats'] ?? '05',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF242424),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                icon: Icons.close,
                onTap: () {
                  // Handle cancel action
                },
              ),
              const SizedBox(width: 16),
              _buildActionButton(
                icon: Icons.chat_bubble_outline,
                onTap: () {
                  // Handle chat action
                },
              ),
              const SizedBox(width: 16),
              _buildActionButton(
                icon: Icons.call,
                onTap: () {
                  // Handle call action
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Expand/Collapse Indicator
          Center(
            child: Icon(
              Icons.keyboard_arrow_up,
              color: const Color(0xFF9E9E9E),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
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
