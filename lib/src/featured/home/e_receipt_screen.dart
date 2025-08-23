import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../../helper/constants/app_colors.dart';

class EReceiptScreen extends StatelessWidget {
  const EReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.divider,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'E-Receipt',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Barcode Section
            BarcodeWidget(
              barcode: Barcode.code128(),
              data: '#854HG23',
              width: double.infinity,
              height: 100,
              color: AppColors.textPrimary,
              backgroundColor: AppColors.surface,
            ),

            const SizedBox(height: 24),

            // Booking ID Section
            _buildInfoRow('Booking ID', '#854HG23'),
            _buildDivider(),

            // Driver and Car Details Section
            _buildInfoRow('Driver', 'Jenny Wilson'),
            _buildInfoRow('Car Number', 'GR 678-UVWX'),
            _buildInfoRow('Car Model', 'Hyundai Verna'),
            _buildInfoRow('Car Color', 'White'),
            _buildDivider(),

            // Cost and Total Section
            _buildInfoRow('Cost Per Mile', '\$1.25'),
            _buildInfoRow('Estimated Mile', '10'),
            _buildDashedDivider(),
            _buildInfoRow('Total', '\$12.5', isTotal: true),
            _buildDivider(),

            // Customer and Transaction Details Section
            _buildInfoRow('Name', 'Esther Howard'),
            _buildInfoRow('Phone Number', '+1 (208) 555-0112'),
            _buildInfoRow('Transaction ID', '#RE2564HG23'),

            const SizedBox(height: 40),

            // Download Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement download functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('E-Receipt downloaded successfully!'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textInverse,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                child: const Text('Download E-Receipt'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColors.divider,
      margin: const EdgeInsets.symmetric(vertical: 8),
    );
  }

  Widget _buildDashedDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: List.generate(
          50,
          (index) => Expanded(
            child: Container(
              height: 1,
              color: index % 2 == 0 ? AppColors.divider : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
