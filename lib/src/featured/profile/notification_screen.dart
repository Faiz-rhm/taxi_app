import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> _todayNotifications = [
    {
      'id': '1',
      'title': 'Ride Booked Successfully',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'timestamp': '1h',
      'icon': Icons.calendar_today,
      'isRead': false,
      'iconColor': AppColors.primary,
      'backgroundColor': AppColors.primary.withOpacity(0.1),
    },
    {
      'id': '2',
      'title': '50% Off on First Ride',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'timestamp': '1h',
      'icon': Icons.local_offer,
      'isRead': false,
      'iconColor': AppColors.primary,
      'backgroundColor': AppColors.primary.withOpacity(0.1),
    },
    {
      'id': '3',
      'title': 'Ride Review Request',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis',
      'timestamp': '1h',
      'icon': Icons.star_border,
      'isRead': false,
      'iconColor': AppColors.primary,
      'backgroundColor': AppColors.primary.withOpacity(0.1),
    },
  ];

  final List<Map<String, dynamic>> _yesterdayNotifications = [
    {
      'id': '4',
      'title': 'Taxi Booked Successfully',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'timestamp': '1d',
      'icon': Icons.calendar_today,
      'isRead': false,
      'iconColor': AppColors.primary,
      'backgroundColor': AppColors.primary.withOpacity(0.1),
    },
    {
      'id': '5',
      'title': 'New Paypal Added',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'timestamp': '1d',
      'icon': Icons.account_balance_wallet,
      'isRead': false,
      'iconColor': AppColors.primary,
      'backgroundColor': AppColors.primary.withOpacity(0.1),
    },
    {
      'id': '6',
      'title': 'Taxi Booked Successfully',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'timestamp': '1d',
      'icon': Icons.calendar_today,
      'isRead': true,
      'iconColor': AppColors.secondaryText,
      'backgroundColor': AppColors.light,
    },
  ];

  int get unreadCount => _todayNotifications.where((n) => !n['isRead']).length +
                         _yesterdayNotifications.where((n) => !n['isRead']).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildNotificationsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.secondary, size: 20),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Notification',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
          // Badge showing unread count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$unreadCount NEW',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // TODAY Section
          _buildDateSection('TODAY', _todayNotifications, () => _markAllAsRead(_todayNotifications)),

          const SizedBox(height: 24),

          // YESTERDAY Section
          _buildDateSection('YESTERDAY', _yesterdayNotifications, () => _markAllAsRead(_yesterdayNotifications)),
        ],
      ),
    );
  }

  Widget _buildDateSection(String date, List<Map<String, dynamic>> notifications, VoidCallback onMarkAllAsRead) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date header with mark all as read
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryText,
                  letterSpacing: 1.2,
                ),
              ),
              GestureDetector(
                onTap: onMarkAllAsRead,
                child: Text(
                  'Mark all as read',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Notifications list
        ...notifications.map((notification) => _buildNotificationItem(notification)),
      ],
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: notification['backgroundColor'],
              shape: BoxShape.circle,
            ),
            child: Icon(
              notification['icon'],
              color: notification['iconColor'],
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: notification['isRead'] ? AppColors.secondaryText : AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Timestamp
          Text(
            notification['timestamp'],
            style: TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _markAllAsRead(List<Map<String, dynamic>> notifications) {
    setState(() {
      for (var notification in notifications) {
        notification['isRead'] = true;
        notification['iconColor'] = AppColors.secondaryText;
        notification['backgroundColor'] = AppColors.light;
      }
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All ${notifications.length} notifications marked as read'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _markNotificationAsRead(String notificationId) {
    // Find and mark specific notification as read
    final todayNotification = _todayNotifications.firstWhere(
      (n) => n['id'] == notificationId,
      orElse: () => {},
    );

    final yesterdayNotification = _yesterdayNotifications.firstWhere(
      (n) => n['id'] == notificationId,
      orElse: () => {},
    );

    if (todayNotification.isNotEmpty) {
      setState(() {
        todayNotification['isRead'] = true;
        todayNotification['iconColor'] = AppColors.secondaryText;
        todayNotification['backgroundColor'] = AppColors.light;
      });
    } else if (yesterdayNotification.isNotEmpty) {
      setState(() {
        yesterdayNotification['isRead'] = true;
        yesterdayNotification['iconColor'] = AppColors.secondaryText;
        yesterdayNotification['backgroundColor'] = AppColors.light;
      });
    }
  }
}
