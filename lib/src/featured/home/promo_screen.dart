import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../helper/constants/app_colors.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({super.key});

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  final TextEditingController _promoCodeController = TextEditingController();
  String? _selectedCouponCode;

  final List<Map<String, dynamic>> _coupons = [
    {
      'code': 'WELCOME200',
      'unlockCondition': 'Add items worth \$2 more to unlock',
      'offer': 'Get 50% OFF',
      'isUnlocked': false,
    },
    {
      'code': 'CASHBACK12',
      'unlockCondition': 'Add items worth \$2 more to unlock',
      'offer': 'Up to \$12.00 cashback',
      'isUnlocked': false,
    },
    {
      'code': 'FEST2COST',
      'unlockCondition': 'Add items worth \$28 more to unlock',
      'offer': 'Get 50% OFF for Combo',
      'isUnlocked': false,
    },
  ];

  @override
  void dispose() {
    _promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Coupon',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
      ),
      body: Column(
        children: [
          // Coupons Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Coupons for you',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Coupons List
                  Expanded(
                    child: ListView.builder(
                      itemCount: _coupons.length,
                      itemBuilder: (context, index) {
                        final coupon = _coupons[index];
                        return _buildCouponCard(coupon, index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Section with Promo Code and Continue Button
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildCouponCard(Map<String, dynamic> coupon, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Stack(
        children: [
          // Coupon content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coupon Code
                Text(
                  coupon['code'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),

                const SizedBox(height: 8),

                // Unlock Condition
                Text(
                  coupon['unlockCondition'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),

                const SizedBox(height: 16),

                // Offer and Copy Button Row
                Row(
                  children: [
                    // Offer with icon
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.local_offer,
                              color: AppColors.surface,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              coupon['offer'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Copy Code Button
                    GestureDetector(
                      onTap: () => _copyCouponCode(coupon['code']),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'COPY CODE',
                          style: TextStyle(
                            color: AppColors.surface,
                            fontSize: 12,
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

          // Perforated edges effect
          Positioned(
            left: -8,
            top: 0,
            bottom: 0,
            child: Container(
              width: 16,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(8, (index) => Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                  ),
                )),
              ),
            ),
          ),

          Positioned(
            right: -8,
            top: 0,
            bottom: 0,
            child: Container(
              width: 16,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(8, (index) => Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Promo Code Input Row
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: TextField(
                    controller: _promoCodeController,
                    decoration: const InputDecoration(
                      hintText: 'Promo Code',
                      hintStyle: TextStyle(color: AppColors.hintText),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Apply Button
              ElevatedButton(
                onPressed: _applyPromoCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Continue Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _continueWithSelectedCoupon,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyCouponCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Coupon code "$code" copied to clipboard'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _applyPromoCode() {
    final promoCode = _promoCodeController.text.trim();
    if (promoCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a promo code'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return;
    }

    // Check if promo code matches any available coupons
    final matchingCoupon = _coupons.firstWhere(
      (coupon) => coupon['code'] == promoCode.toUpperCase(),
      orElse: () => {},
    );

    if (matchingCoupon.isNotEmpty) {
      setState(() {
        _selectedCouponCode = matchingCoupon['code'];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Promo code "${matchingCoupon['code']}" applied successfully!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid promo code'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _continueWithSelectedCoupon() {
    if (_selectedCouponCode != null) {
      // Navigate back with selected coupon
      Navigator.pop(context, {
        'couponCode': _selectedCouponCode,
        'promoCode': _promoCodeController.text.trim(),
      });
    } else {
      // Navigate back without coupon
      Navigator.pop(context);
    }
  }
}
