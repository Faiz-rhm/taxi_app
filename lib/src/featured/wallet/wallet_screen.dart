import 'package:flutter/material.dart';

import 'add_money_screen.dart';
import '../../helper/constants/app_colors.dart';


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

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Wallet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),),
      ),
      body: Column(
        children: [
          // Wallet Balance Section
          _buildWalletBalanceSection(),

          // Transaction History
          Expanded(
            child: _buildTransactionHistory(),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletBalanceSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.1), // Light orange background
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
                  color: AppColors.hintText,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.wallet,
                  color: AppColors.surface,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${_walletBalance.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddMoneyScreen())),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor: AppColors.primary,
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
      color: AppColors.surface,
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
              color: AppColors.primaryText,
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderLight,
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
                    color: AppColors.primaryText,
                  ),
                ),
              ),
              Text(
                '${isCredit ? '+' : '-'} \$${transaction['amount'].toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isCredit ? AppColors.success : AppColors.error,
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
                  color: AppColors.hintText,
                ),
              ),
              Text(
                '\$${transaction['balance'].toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.hintText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
