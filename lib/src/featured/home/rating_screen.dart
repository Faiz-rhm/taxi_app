import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _selectedRating = 5;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rate Driver',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Driver Information
            _buildDriverInfo(),

            const SizedBox(height: 32),

            // Trip Question
            _buildTripQuestion(),

            const SizedBox(height: 32),

            // Star Rating
            _buildStarRating(),

            const SizedBox(height: 32),

            // Detailed Review
            _buildDetailedReview(),

            const SizedBox(height: 32),

            // Submit Button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverInfo() {
    return Column(
      children: [
        // Driver Profile Picture
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/driver-profile');
          },
          child:         Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage('assets/images/user6.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ),

        const SizedBox(height: 16),

        // Driver Name
        const Text(
          'Jenny Wilson',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 8),

        // Vehicle Information
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hyundai Verna',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              'GR 678-UVWX',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTripQuestion() {
    return const Text(
      'How was your trip with\nJenny Wilson',
      style: TextStyle(
        color: AppColors.primaryText,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildStarRating() {
    return Column(
      children: [
        Divider(
          color: AppColors.borderLight,
          height: 1,
          thickness: 1,
        ),

        const SizedBox(height: 16),

        Text(
          'Your overall rating',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 16),

        // Star Rating Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final starNumber = index + 1;
            final isSelected = starNumber <= _selectedRating;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRating = starNumber;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  isSelected ? Icons.star : Icons.star_border,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 16),

        Divider(
          color: AppColors.borderLight,
          height: 1,
          thickness: 1,
        ),

      ],
    );
  }

  Widget _buildDetailedReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add detailed review',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 16),

        // Review Input Field
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.borderLight,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _reviewController,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText: 'Enter here',
              hintStyle: TextStyle(
                color: AppColors.hintText,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(20),
            ),
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 16,
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildSubmitButton() {
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
            _handleSubmit();
          },
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              'Submit',
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

  void _handleSubmit() {
    // Handle rating submission logic
    final rating = _selectedRating;
    final review = _reviewController.text;

    // You can add API call here to submit the rating and review
    debugPrint('Submitting rating: $rating stars');
    debugPrint('Review: $review');

    // Navigate back
    Navigator.pop(context);
  }
}
