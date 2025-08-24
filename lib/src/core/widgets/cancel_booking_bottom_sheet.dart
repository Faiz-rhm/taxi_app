import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class CancelBookingBottomSheet extends StatelessWidget {
  final String bookingReference;
  final VoidCallback? onGotIt;

  const CancelBookingBottomSheet({
    super.key,
    required this.bookingReference,
    this.onGotIt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
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

          // Success Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Success Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.surface,
                    size: 40,
                  ),
                ),

                const SizedBox(height: 24),

                // Success Message
                const Text(
                  'Booking Cancelled Successfully!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // Booking Reference
                Text(
                  'Your booking with CRN : #$bookingReference has been cancelled successfully.',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.secondaryText,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Got it Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (onGotIt != null) {
                        onGotIt!();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Got it',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper function to show the cancel booking bottom sheet
void showCancelBookingBottomSheet(
  BuildContext context, {
  required String bookingReference,
  VoidCallback? onGotIt,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => CancelBookingBottomSheet(
      bookingReference: bookingReference,
      onGotIt: onGotIt,
    ),
  );
}
