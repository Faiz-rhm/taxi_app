import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  final List<Map<String, dynamic>> _contacts = [
    {
      'name': 'Carla Schoen',
      'phone': '207.555.0119',
      'profileImage': 'assets/images/user1.png',
      'isInvited': false,
    },
    {
      'name': 'Esther Howard',
      'phone': '702.555.0122',
      'profileImage': 'assets/images/user2.png',
      'isInvited': false,
    },
    {
      'name': 'Robert Fox',
      'phone': '239.555.0108',
      'profileImage': 'assets/images/user3.png',
      'isInvited': false,
    },
    {
      'name': 'Jacob Jones',
      'phone': '316.555.0116',
      'profileImage': 'assets/images/user4.png',
      'isInvited': false,
    },
    {
      'name': 'Jacob Jones',
      'phone': '629.555.0129',
      'profileImage': 'assets/images/user5.jpg',
      'isInvited': false,
    },
    {
      'name': 'Darlene Robertson',
      'phone': '629.555.0129',
      'profileImage': 'assets/images/user6.jpg',
      'isInvited': false,
    },
    {
      'name': 'Ralph Edwards',
      'phone': '203.555.0106',
      'profileImage': 'assets/images/user7.png',
      'isInvited': false,
    },
    {
      'name': 'Ronald Richards',
      'phone': '209.555.0104',
      'profileImage': 'assets/images/user8.png',
      'isInvited': false,
    },
    {
      'name': 'Courtney Henry',
      'phone': '209.555.0104',
      'profileImage': 'assets/images/user1.png',
      'isInvited': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Invite Friends', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF242424)),),
      ),
      body: _buildContactsList(),
    );
  }

  Widget _buildContactsList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _contacts.length,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFF0F0F0),
        indent: 80,
        endIndent: 20,
      ),
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        return _buildContactItem(contact, index);
      },
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Profile Picture
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                  image: AssetImage(contact['profileImage']),
                  fit: BoxFit.cover,
                ),
              // Fallback if image doesn't exist
              color: const Color(0xFFE0E0E0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF9E9E9E),
                size: 30,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Contact Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  contact['phone'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),

          // Invite Button
          _buildInviteButton(contact, index),
        ],
      ),
    );
  }

  Widget _buildInviteButton(Map<String, dynamic> contact, int index) {
    final isInvited = contact['isInvited'];

    return GestureDetector(
      onTap: () {
        setState(() {
          _contacts[index]['isInvited'] = !isInvited;
        });

        if (!isInvited) {
          _showInviteSentSnackBar(contact['name']);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isInvited ? AppColors.success : AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: (isInvited ? AppColors.success : AppColors.primary).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          isInvited ? 'Invited' : 'Invite',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showInviteSentSnackBar(String contactName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invite sent to $contactName!'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            // Find the contact and revert the invite status
            final contactIndex = _contacts.indexWhere((contact) => contact['name'] == contactName);
            if (contactIndex != -1) {
              setState(() {
                _contacts[contactIndex]['isInvited'] = false;
              });
            }
          },
        ),
      ),
    );
  }
}
