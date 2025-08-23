import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../helper/constants/app_colors.dart';
import 'saved_places_screen.dart';
import 'book_ride_screen.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryText,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Destination',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Card with origin and destination
            _buildAddressCard(),
            const SizedBox(height: 16),

            // Saved Places Section
            _buildSavedPlacesSection(),
            const SizedBox(height: 16),

            // Recent Destinations
            _buildRecentDestinations(),

            const Spacer(),

            // Confirm Location Button
            _buildConfirmLocationButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Origin Address
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
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '6391 Elgin St. Celina, Delawa...',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),

          // Vertical dashed line
          Container(
            margin: const EdgeInsets.only(left: 7, top: 8, bottom: 8),
            width: 2,
            height: 24,
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
                size: 18,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '1901 Thornridge Cir. Sh...',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              // Map icon (three stacked rectangles)
              Icon(
                Icons.map,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 12),
              // Plus icon
              Icon(
                Icons.add,
                color: AppColors.primary,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavedPlacesSection() {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SavedPlacesScreen(),
          ),
        );
        // Handle the result if a place was selected
        if (result != null) {
          // You can update the destination address here if needed
          debugPrint('Selected saved place: $result');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
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
              Icons.bookmark,
              color: AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: 16),
            const Text(
              'Saved Places',
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondaryText,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentDestinations() {
    final List<String> recentDestinations = [
      '2118 Thornridge Cir. Syracuse, C..',
      '4517 Washington Ave. Manche...',
      '2715 Ash Dr. San Jose, South Da...',
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: recentDestinations.asMap().entries.map((entry) {
          final index = entry.key;
          final destination = entry.value;
          final isLast = index == recentDestinations.length - 1;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.refresh,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        destination,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.borderLight,
                  indent: 56,
                  endIndent: 20,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildConfirmLocationButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
                         child: InkWell(
                   onTap: () {
                     // Navigate to book ride screen with default pickup location
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => const BookRideScreen(
                           pickupLocation: LatLng(40.7128, -74.0060), // Default NYC location
                         ),
                       ),
                     );
                   },
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              'Confirm Location',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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
