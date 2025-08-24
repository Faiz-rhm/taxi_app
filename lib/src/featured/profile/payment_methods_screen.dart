import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final String? selectedPaymentMethod;

  const PaymentMethodsScreen({
    super.key,
    this.selectedPaymentMethod,
  });

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String _selectedPaymentMethod = 'Cash';

  @override
  void initState() {
    super.initState();
    if (widget.selectedPaymentMethod != null) {
      _selectedPaymentMethod = widget.selectedPaymentMethod!;
    }
  }

  void _selectPaymentMethod(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  void _addCard() {
    // Navigate to add card screen
    Navigator.pushNamed(context, '/add-card');
  }

  void _confirmPayment() {
    // Return the selected payment method
    Navigator.pop(context, _selectedPaymentMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Methods",
        ),
      ),
      body: Column(
      children: [

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                  // Cash Section
                  _buildSectionHeader('Cash'),
                  _buildPaymentCard(
                    icon: Icons.money,
                    title: 'Cash',
                    isSelected: _selectedPaymentMethod == 'Cash',
                    onTap: () => _selectPaymentMethod('Cash'),
                  ),

                  const SizedBox(height: 24),

                  // Wallet Section
                  _buildSectionHeader('Wallet'),
                  _buildPaymentCard(
                    icon: Icons.account_balance_wallet,
                    title: 'Wallet',
                    isSelected: _selectedPaymentMethod == 'Wallet',
                    onTap: () => _selectPaymentMethod('Wallet'),
                  ),

                  const SizedBox(height: 24),

                  // Credit & Debit Card Section
                  _buildSectionHeader('Credit & Debit Card'),
                  _buildPaymentCard(
                    icon: Icons.credit_card,
                    title: 'Add Card',
                    isSelected: false,
                    onTap: _addCard,
                    showArrow: true,
                  ),

                  const SizedBox(height: 24),

                  // More Payment Options Section
                  _buildSectionHeader('More Payment Options'),
                  _buildPaymentCard(
                    icon: Icons.payment,
                    title: 'Paypal',
                    isSelected: _selectedPaymentMethod == 'Paypal',
                    onTap: () => _selectPaymentMethod('Paypal'),
                    customIcon: _buildPaypalIcon(),
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentCard(
                    icon: Icons.payment,
                    title: 'Apple Pay',
                    isSelected: _selectedPaymentMethod == 'Apple Pay',
                    onTap: () => _selectPaymentMethod('Apple Pay'),
                    customIcon: _buildApplePayIcon(),
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentCard(
                    icon: Icons.payment,
                    title: 'Google Pay',
                    isSelected: _selectedPaymentMethod == 'Google Pay',
                    onTap: () => _selectPaymentMethod('Google Pay'),
                    customIcon: _buildGooglePayIcon(),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Button
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryText,
        ),
      ),
    );
  }

  Widget _buildPaymentCard({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    bool showArrow = false,
    Widget? customIcon,
  }) {
    return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
          child: Row(
            children: [
                // Icon
                if (customIcon != null)
                  customIcon
                else
                  Icon(
                    icon,
                    color: AppColors.primary,
                    size: 24,
                  ),

                const SizedBox(width: 16),

                // Title
              Expanded(
                child: Text(
                  title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),

                // Radio Button or Arrow
                if (showArrow)
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  )
                else
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.grey[300]!,
                    width: 2,
                  ),
                      color: isSelected ? AppColors.primary : Colors.white,
                ),
                child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          )
                    : null,
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaypalIcon() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFF0070BA),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text(
          'P',
          style: TextStyle(
      color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildApplePayIcon() {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.apple,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildGooglePayIcon() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4285F4), // Blue
            Color(0xFFEA4335), // Red
            Color(0xFFFBBC05), // Yellow
            Color(0xFF34A853), // Green
          ],
        ),
      ),
      child: const Center(
        child: Text(
          'G',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _confirmPayment,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Confirm Payment",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
