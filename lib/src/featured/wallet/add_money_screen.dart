import 'package:flutter/material.dart';

class AddMoneyScreen extends StatefulWidget {
  final double currentBalance;
  
  const AddMoneyScreen({super.key, required this.currentBalance});

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
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Wallet Balance Card
            _buildWalletBalanceCard(),
            
            // Predefined Amount Buttons
            _buildPredefinedAmounts(),
            
            // Custom Amount Input
            _buildCustomAmountInput(),
            
            // Add Money Button
            Expanded(
              child: _buildAddMoneyButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF242424),
                size: 20,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Add Money',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF242424),
                ),
              ),
            ),
          ),
          const SizedBox(width: 40), // Balance the layout
        ],
      ),
    );
  }

  Widget _buildWalletBalanceCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F0), // Light orange background
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
                  fontSize: 14,
                  color: Color(0xFF9E9E9E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${widget.currentBalance.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF242424),
                ),
              ),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF2994A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Amount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF242424),
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
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
                    color: isSelected ? const Color(0xFFF2994A) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFFF2994A) : const Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+ \$${amount.toString()}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF242424),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAmountInput() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Custom Amount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF242424),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2994A),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '\$',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter Amount',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Color(0xFF9E9E9E),
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
        ],
      ),
    );
  }

  Widget _buildAddMoneyButton() {
    final hasValidAmount = _selectedAmount != null && _selectedAmount! > 0;
    
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: hasValidAmount ? _addMoney : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: hasValidAmount 
                ? const Color(0xFFF2994A) // Orange when enabled
                : const Color(0xFFE0E0E0), // Grey when disabled
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: hasValidAmount ? 4 : 0,
            shadowColor: const Color(0xFFF2994A),
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
        backgroundColor: const Color(0xFFF2994A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
