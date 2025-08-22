import 'package:flutter/material.dart';
import 'dart:ui';
import '../../helper/constants/app_colors.dart';

class LogoutBottomSheet extends StatelessWidget {
  final VoidCallback? onLogout;
  final VoidCallback? onCancel;

  const LogoutBottomSheet({
    super.key,
    this.onLogout,
    this.onCancel,
  });

  static Future<bool?> show(
    BuildContext context, {
    VoidCallback? onLogout,
    VoidCallback? onCancel,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LogoutBottomSheet(
        onLogout: onLogout,
        onCancel: onCancel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Message
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'Are you sure you want to log out?',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.secondaryText,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Cancel button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onCancel?.call();
                      Navigator.of(context).pop(false);
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.light,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.borderLight,
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Logout button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onLogout?.call();
                      Navigator.of(context).pop(true);
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Yes, Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

// Alternative implementation with backdrop blur effect
class LogoutBottomSheetWithBlur extends StatelessWidget {
  final VoidCallback? onLogout;
  final VoidCallback? onCancel;

  const LogoutBottomSheetWithBlur({
    super.key,
    this.onLogout,
    this.onCancel,
  });

  static Future<bool?> show(
    BuildContext context, {
    VoidCallback? onLogout,
    VoidCallback? onCancel,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => LogoutBottomSheetWithBlur(
        onLogout: onLogout,
        onCancel: onCancel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Backdrop blur
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),

        // Bottom sheet content
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Message
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Are you sure you want to log out?',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryText,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const Spacer(),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Cancel button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            onCancel?.call();
                            Navigator.of(context).pop(false);
                          },
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.light,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.borderLight,
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Logout button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            onLogout?.call();
                            Navigator.of(context).pop(true);
                          },
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Yes, Logout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom handle bar
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
