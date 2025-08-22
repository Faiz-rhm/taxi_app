import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Payment Methods', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF242424)),),
      ),
      body: Column(
        children: [
          Expanded(child: _buildContent()),
          _buildConfirmPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreditDebitSection(),
          _buildMorePaymentOptionsSection(),
        ],
      ),
    );
  }

  Widget _buildCreditDebitSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Credit & Debit Card',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF242424)),
          ),
          const SizedBox(height: 16),
          _buildAddCardButton(),
        ],
      ),
    );
  }

  Widget _buildAddCardButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/add-card');
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFF2994A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.credit_card, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Add Card',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF242424)),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFFF2994A), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMorePaymentOptionsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'More Payment Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF242424)),
          ),
          const SizedBox(height: 16),
          _buildPaymentOption(
            icon: Icons.payment,
            iconColor: const Color(0xFF0070BA),
            title: 'Paypal',
            isSelected: _selectedPaymentMethod == 'paypal',
            onTap: () => _selectPaymentMethod('paypal'),
          ),
          _buildPaymentOption(
            icon: Icons.apple,
            iconColor: Colors.black,
            title: 'Apple Pay',
            isSelected: _selectedPaymentMethod == 'apple_pay',
            onTap: () => _selectPaymentMethod('apple_pay'),
          ),
          _buildPaymentOption(
            icon: Icons.g_mobiledata,
            iconColor: const Color(0xFF4285F4),
            title: 'Google Pay',
            isSelected: _selectedPaymentMethod == 'google_pay',
            onTap: () => _selectPaymentMethod('google_pay'),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF242424)),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFFF2994A) : const Color(0xFFE0E0E0),
                    width: 2,
                  ),
                  color: isSelected ? const Color(0xFFF2994A) : Colors.white,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPaymentButton() {
    final hasSelectedMethod = _selectedPaymentMethod != null;

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: hasSelectedMethod ? _confirmPayment : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: hasSelectedMethod ? const Color(0xFFF2994A) : const Color(0xFFE0E0E0),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: hasSelectedMethod ? 4 : 0,
            shadowColor: const Color(0xFFF2994A),
          ),
          child: const Text(
            'Confirm Payment',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  void _selectPaymentMethod(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  void _confirmPayment() {
    if (_selectedPaymentMethod != null) {
      _showSnackBar('Payment method "${_selectedPaymentMethod!.replaceAll('_', ' ').toUpperCase()}" confirmed successfully!');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFF2994A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
