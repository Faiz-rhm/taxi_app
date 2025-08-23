import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';
import 'rating_screen.dart';

class TipScreen extends StatefulWidget {
  const TipScreen({super.key});

  @override
  State<TipScreen> createState() => _TipScreenState();
}

class _TipScreenState extends State<TipScreen> {
  String _selectedTipAmount = 'US \$2';
  final TextEditingController _customAmountController = TextEditingController();
  bool _showCustomInput = false;

  final List<String> _tipAmounts = [
    'US \$1',
    'US \$2',
    'US \$3',
    'US \$4',
    'US \$5',
    'US \$6',
    'US \$7',
    'US \$8',
  ];

  @override
  void dispose() {
    _customAmountController.dispose();
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
          'Tip For Driver',
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
          children: [
            // Driver Information
            _buildDriverInfo(),

            const SizedBox(height: 32),

            // Rating Summary
            _buildRatingSummary(),

            const SizedBox(height: 24),

            // Divider
            Divider(
              color: AppColors.borderLight,
              height: 1,
              thickness: 1,
            ),

            const SizedBox(height: 24),

            // Tipping Section
            _buildTippingSection(),

            const Spacer(),

            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverInfo() {
    return Column(
      children: [
        // Driver Profile Picture
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.borderLight,
          ),
          child: const Icon(
            Icons.person,
            size: 40,
            color: AppColors.secondaryText,
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

  Widget _buildRatingSummary() {
    return Column(
      children: [
        const Text(
          'You Rated Jenny Wilson 5 Star',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        Text(
          'Do you want to add tip for Jenny?',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTippingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add a tip for Jenny Wilson',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 20),

        // Tip Amount Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: _tipAmounts.length,
          itemBuilder: (context, index) {
            final amount = _tipAmounts[index];
            final isSelected = _selectedTipAmount == amount;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTipAmount = amount;
                  _showCustomInput = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.borderLight,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected ? AppColors.primary : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    amount,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        // Custom Amount Link
        GestureDetector(
          onTap: () {
            setState(() {
              _showCustomInput = true;
              _selectedTipAmount = '';
            });
          },
          child: Text(
            'Enter Custom Amount',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),

        // Custom Amount Input Field
        if (_showCustomInput) ...[
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.borderLight,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _customAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter amount',
                hintStyle: TextStyle(
                  color: AppColors.hintText,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
                prefixText: 'US \$',
                prefixStyle: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 16,
              ),
              onChanged: (value) {
                setState(() {
                  _selectedTipAmount = value.isNotEmpty ? 'US \$$value' : '';
                });
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // No, Thanks Button
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                                 onTap: () {
                   // Navigate to rating screen
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const RatingScreen(),
                     ),
                   );
                 },
                borderRadius: BorderRadius.circular(16),
                child: const Center(
                  child: Text(
                    'No, Thanks',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Pay Tip Button
        Expanded(
          child: Container(
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
                  _handlePayTip();
                },
                borderRadius: BorderRadius.circular(16),
                child: const Center(
                  child: Text(
                    'Pay Tip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

    void _handlePayTip() {
    // Handle tip payment logic
    String tipAmount = _selectedTipAmount;
    if (_showCustomInput && _customAmountController.text.isNotEmpty) {
      tipAmount = 'US \$${_customAmountController.text}';
    }

    // You can add API call here to process the tip
    debugPrint('Processing tip: $tipAmount');

    // Navigate to rating screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RatingScreen(),
      ),
    );
  }
}
