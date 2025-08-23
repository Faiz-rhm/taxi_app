import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({super.key});

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  String _selectedReason = 'Schedule Change';
  final TextEditingController _otherReasonController = TextEditingController();

  final List<String> _cancellationReasons = [
    'Schedule Change',
    'Book Another Cab',
    'Found a better alternative',
    'Driver is taking too long',
    'My Reason is not listed',
    'Other',
  ];

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.primaryText,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cancel Taxi Booking',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cancellation Reason Prompt
            const Text(
              'Please select the reason for cancellations:',
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 24),

            // Cancellation Reasons List
            Expanded(
              child: Column(
                children: [
                  // Radio Button Options
                  ..._cancellationReasons.map((reason) => _buildReasonOption(reason)),

                  const SizedBox(height: 24),

                  // Divider
                  Divider(
                    color: AppColors.borderLight,
                    height: 1,
                    thickness: 1,
                  ),

                  const SizedBox(height: 24),

                  // Other Reason Input Field
                  if (_selectedReason == 'Other') _buildOtherReasonInput(),
                ],
              ),
            ),

            // Cancel Ride Button
            _buildCancelRideButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonOption(String reason) {
    final isSelected = _selectedReason == reason;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Radio Button
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedReason = reason;
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.borderMedium,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),

          const SizedBox(width: 16),

          // Reason Text
          Expanded(
            child: Text(
              reason,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherReasonInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Other',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.borderLight,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _otherReasonController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Enter your Reason',
              hintStyle: TextStyle(
                color: AppColors.hintText,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCancelRideButton() {
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
            _handleCancelRide();
          },
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              'Cancel Ride',
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

  void _handleCancelRide() {
    // Handle cancellation logic
    String reason = _selectedReason;
    if (_selectedReason == 'Other' && _otherReasonController.text.isNotEmpty) {
      reason = _otherReasonController.text;
    }

    // You can add API call here to cancel the ride
    debugPrint('Cancelling ride with reason: $reason');

    // Navigate back
    Navigator.pop(context);
  }
}
