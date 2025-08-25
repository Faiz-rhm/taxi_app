import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../../helper/constants/app_colors.dart';
import 'tip_screen.dart';

class PayCashScreen extends StatefulWidget {
  const PayCashScreen({super.key});

  @override
  State<PayCashScreen> createState() => _PayCashScreenState();
}

class _PayCashScreenState extends State<PayCashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pay Cash',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Main Content Card
            _buildMainContentCard(),

            const Spacer(),

            // Cash Paid Button
            _buildCashPaidButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContentCard() {
    return TicketWidget(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      isCornerRounded: true,
      color: AppColors.divider.withOpacity(0.3),
      child: Column(
        children: [
          // Pay Cash Header
          _buildPayCashHeader(),

          // Address and Ride Details
          _buildAddressSection(),

          // OTP and Driver Information
          _buildOTPAndDriverSection(),

          const Spacer(),

          // Total Amount Bar
          _buildTotalAmountBar(),
        ],
      ),
    );
  }


  Widget _buildPayCashHeader() {
    return Column(
      children: [
        // Ticket Header with decorative elements
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Wallet Icon with enhanced styling
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),

              const SizedBox(height: 16),

              // Pay Cash Text with ticket styling
              const Text(
                'Pay Cash',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pickup Location
          Row(
            children: [
              // Origin indicator (black circle with dot)
              Icon(Icons.circle_outlined,),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '6391 Elgin St. Celina, Delawa...',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          // Vertical dashed line
          Container(
            margin: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
            width: 2,
            height: 24,
            child: CustomPaint(
              painter: DashedLinePainter(),
            ),
          ),

          // Destination Location
          Row(
            children: [
              // Destination indicator (orange map pin)
              Icon(
                Icons.place,
                color: AppColors.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '1901 Thornridge Cir. Sh...',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOTPAndDriverSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 32.0),
      child: Column(
        children: [
          // OTP Divider
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.borderLight,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'OTP - 7854',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.borderLight,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 50),

          // Driver Profile
          Row(
            children: [
              // Driver Profile Picture
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/driver-profile');
                },
                child:               Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/user6.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ),

              const SizedBox(width: 16),

              // Driver Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jenny Wilson',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sedan (4 Seater)',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalAmountBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text(
            'Total Amount',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Text(
            '\$12.5',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCashPaidButton() {
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
                   // Navigate to tip screen
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const TipScreen(),
                     ),
                   );
                 },
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              'Cash Paid',
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
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.borderLight
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashHeight = 3;
    const dashSpace = 4;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
