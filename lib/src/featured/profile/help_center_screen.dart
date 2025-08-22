import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  int _selectedTabIndex = 0;
  int _selectedCategoryIndex = 0;
  int _expandedFaqIndex = 0;
  int _expandedContactIndex = 1; // WhatsApp is expanded by default

  final List<String> _tabs = ['FAQ', 'Contact Us'];
  final List<String> _categories = ['All', 'Services', 'General', 'Account', 'Payment', 'Safety'];

  final List<Map<String, dynamic>> _faqItems = [
    {
      'question': 'What if I need to cancel a booking?',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'category': 'Services'
    },
    {
      'question': 'Is safe to use App?',
      'answer': 'Yes, our app is completely safe to use. We implement industry-standard security measures to protect your personal information and payment details.',
      'category': 'Safety'
    },
    {
      'question': 'How do I receive Booking Details?',
      'answer': 'Booking details are automatically sent to your registered email and phone number. You can also view them in the app under the Bookings section.',
      'category': 'Services'
    },
    {
      'question': 'How can I edit my profile information?',
      'answer': 'Go to Profile > Your Profile to edit your personal information, including name, phone number, and profile picture.',
      'category': 'Account'
    },
    {
      'question': 'How to cancel Taxi?',
      'answer': 'You can cancel a taxi booking through the app by going to Bookings > Active Bookings and selecting the cancel option.',
      'category': 'Services'
    },
    {
      'question': 'Is Voice call or Chat Feature there?',
      'answer': 'Yes, we provide both voice call and in-app chat features to communicate with your driver and our support team.',
      'category': 'General'
    },
    {
      'question': 'How to see pre-booked Taxi?',
      'answer': 'All your pre-booked taxis can be viewed in the Bookings section under the "Upcoming" tab.',
      'category': 'Services'
    },
  ];

  final List<Map<String, dynamic>> _contactOptions = [
    {
      'title': 'Customer Service',
      'icon': Icons.headset_mic,
      'details': 'Available 24/7 for immediate assistance',
      'action': 'Call Now',
      'actionType': 'call',
    },
    {
      'title': 'WhatsApp',
      'icon': Icons.chat_bubble,
      'details': '(480) 555-0103',
      'action': 'Chat Now',
      'actionType': 'whatsapp',
    },
    {
      'title': 'Website',
      'icon': Icons.language,
      'details': 'www.taxiapp.com/support',
      'action': 'Visit',
      'actionType': 'website',
    },
    {
      'title': 'Facebook',
      'icon': Icons.facebook,
      'details': 'facebook.com/taxiapp',
      'action': 'Follow',
      'actionType': 'facebook',
    },
    {
      'title': 'Twitter',
      'icon': Icons.flutter_dash,
      'details': '@taxiapp',
      'action': 'Follow',
      'actionType': 'twitter',
    },
    {
      'title': 'Instagram',
      'icon': Icons.camera_alt,
      'details': '@taxiapp',
      'action': 'Follow',
      'actionType': 'instagram',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildTabs(),
            if (_selectedTabIndex == 0) ...[
              _buildCategoryFilters(),
              Expanded(child: _buildFaqList()),
            ] else ...[
              Expanded(child: _buildContactList()),
            ],
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
                'Help Center',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: AppColors.hintText),
          prefixIcon: Icon(Icons.search, color: AppColors.primary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        onChanged: (value) {
          // Implement search functionality
        },
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: _tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == _selectedTabIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? AppColors.primary : AppColors.secondaryText,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.light,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                _categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.secondaryText,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFaqList() {
    final filteredFaqItems = _selectedCategoryIndex == 0
        ? _faqItems
        : _faqItems.where((item) => item['category'] == _categories[_selectedCategoryIndex]).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredFaqItems.length,
      itemBuilder: (context, index) {
        final item = filteredFaqItems[index];
        final isExpanded = index == _expandedFaqIndex;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ExpansionTile(
            initiallyExpanded: isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _expandedFaqIndex = expanded ? index : -1;
              });
            },
            title: Text(
              item['question'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: AppColors.primary,
            ),
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  item['answer'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _contactOptions.length,
      itemBuilder: (context, index) {
        final item = _contactOptions[index];
        final isExpanded = index == _expandedContactIndex;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ExpansionTile(
            initiallyExpanded: isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _expandedContactIndex = expanded ? index : -1;
              });
            },
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                item['icon'],
                color: AppColors.primary,
                size: 20,
              ),
            ),
            title: Text(
              item['title'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item['action'],
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.secondaryText,
                  size: 16,
                ),
              ],
            ),
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      item['details'],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
