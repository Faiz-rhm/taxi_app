import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();
  double? _selectedAmount;

  final List<double> _predefinedAmounts = [
    100, 200, 500, 1000,
    2000, 3000, 4000, 5000,
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Money',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.primaryText,
              size: 24,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Content area
          Expanded(
            child: Container(
              color: const Color(0xFFF5F4F1), // Beige/cream background
              child: Column(
                children: [
                  // Wallet Balance Card
                  _buildWalletBalanceCard(),

                  // Predefined Amount Buttons
                  _buildPredefinedAmounts(),

                  // Custom Amount Input
                  _buildCustomAmountInput(),

                  const Spacer(),

                  // Add Money Button
                  _buildAddMoneyButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletBalanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE8DDD4), // Cream/beige background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Wallet Balance',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8B7A6B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '\$ 12000.00',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.surface,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredefinedAmounts() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.2,
        ),
        itemCount: _predefinedAmounts.length,
        itemBuilder: (context, index) {
          final amount = _predefinedAmounts[index];
          final isSelected = _selectedAmount == amount;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedAmount = amount;
                _amountController.text = amount.toString();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? const AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE8E8E8),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryText.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '+ \$${amount.toInt()}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.surface : const AppColors.primaryText,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomAmountInput() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE8E8E8),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryText.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Text(
              '\$',
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter Amount',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color(0xFFB0B0B0),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    final amount = double.tryParse(value);
                    setState(() {
                      _selectedAmount = amount;
                    });
                  } else {
                    setState(() {
                      _selectedAmount = null;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMoneyButton() {
    final hasValidAmount = _selectedAmount != null && _selectedAmount! > 0;

    return Container(
      margin: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: hasValidAmount ? _addMoney : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: hasValidAmount
                ? const AppColors.primary // Orange when enabled
                : const AppColors.borderLight, // Grey when disabled
            foregroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: const Text(
            'Add Money',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _addMoney() {
    if (_selectedAmount != null && _selectedAmount! > 0) {
      // In a real app, this would integrate with payment gateway
      // For now, just show success message and pop back
      _showSnackBar('Added \$${_selectedAmount!.toStringAsFixed(2)} to wallet successfully!');

      // Return the added amount to the previous screen
      Navigator.pop(context, _selectedAmount);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
