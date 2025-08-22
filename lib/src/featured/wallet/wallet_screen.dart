import 'package:flutter/material.dart';
import 'add_money_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final double _walletBalance = 12000.00;

  // Sample transaction data grouped by date
  final List<Map<String, dynamic>> _transactions = [
    {
      'date': 'Today',
      'transactions': [
        {
          'description': 'Money Added to Wallet',
          'dateTime': '24 September | 7:30 AM',
          'amount': 500.00,
          'type': 'credit',
          'balance': 12000.00,
        },
      ],
    },
    {
      'date': 'Yesterday',
      'transactions': [
        {
          'description': 'Booking No #34234',
          'dateTime': '23 September | 5:30 AM',
          'amount': 500.00,
          'type': 'debit',
          'balance': 11250.00,
        },
      ],
    },
    {
      'date': '22 September 2023',
      'transactions': [
        {
          'description': 'Refund for Booking #34234',
          'dateTime': '22 September | 7:30 AM',
          'amount': 500.00,
          'type': 'credit',
          'balance': 11250.00,
        },
        {
          'description': 'Booking #34234',
          'dateTime': '22 September | 7:30 AM',
          'amount': 250.00,
          'type': 'debit',
          'balance': 11250.00,
        },
        {
          'description': 'Booking #34234',
          'dateTime': '22 September | 7:30 AM',
          'amount': 250.00,
          'type': 'debit',
          'balance': 11250.00,
        },
        {
          'description': 'Booking #34234',
          'dateTime': '22 September | 7:30 AM',
          'amount': 250.00,
          'type': 'debit',
          'balance': 11250.00,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Wallet Balance Section
            _buildWalletBalanceSection(),

            // Transaction History
            Expanded(
              child: _buildTransactionHistory(),
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
                'Wallet',
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

  Widget _buildWalletBalanceSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F0), // Light orange background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wallet Balance',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9E9E9E),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2994A),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${_walletBalance.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF242424),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _addMoney,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2994A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
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
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          final dateGroup = _transactions[index];
          return _buildDateGroup(dateGroup);
        },
      ),
    );
  }

  Widget _buildDateGroup(Map<String, dynamic> dateGroup) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            dateGroup['date'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF242424),
            ),
          ),
        ),

        // Transactions for this date
        ...(dateGroup['transactions'] as List).map((transaction) =>
          _buildTransactionCard(transaction)
        ),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final isCredit = transaction['type'] == 'credit';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFF0F0F0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  transaction['description'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF242424),
                  ),
                ),
              ),
              Text(
                '${isCredit ? '+' : '-'} \$${transaction['amount'].toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isCredit ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transaction['dateTime'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9E9E9E),
                ),
              ),
              Text(
                'Balance \$${transaction['balance'].toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addMoney() {
    // Show add money dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Money to Wallet'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  final amount = double.tryParse(value);
                  if (amount != null && amount > 0) {
                    _processAddMoney(amount);
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // For simplicity, add a default amount
              _processAddMoney(100.0);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _processAddMoney(double amount) {
    // In a real app, this would integrate with payment gateway
    setState(() {
      // Add to wallet balance
      // Update transaction history
    });

    _showSnackBar('Added \$${amount.toStringAsFixed(2)} to wallet successfully!');
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
