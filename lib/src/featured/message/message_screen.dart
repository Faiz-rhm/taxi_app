import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';
import 'chat_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        elevation: 0,
      ),
      body: _buildChatList(),
    );
  }

  Widget _buildChatList() {
    final List<ChatConversation> conversations = [
      ChatConversation(
        name: "Esther Howard",
        lastMessage: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        timestamp: "08:04 pm",
        isOnline: true,
        unreadCount: 2,
        profileImage: "assets/images/user1.png",
      ),
      ChatConversation(
        name: "Jenny Wilson",
        lastMessage: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        timestamp: "07:30 pm",
        isOnline: false,
        unreadCount: 0,
        profileImage: "assets/images/user6.jpg",
      ),
      ChatConversation(
        name: "Robert Johnson",
        lastMessage: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        timestamp: "06:15 pm",
        isOnline: true,
        unreadCount: 1,
        profileImage: "assets/images/user3.png",
      ),
      ChatConversation(
        name: "Sarah Davis",
        lastMessage: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        timestamp: "05:45 pm",
        isOnline: false,
        unreadCount: 0,
        profileImage: "assets/images/user4.png",
      ),
      ChatConversation(
        name: "Michael Brown",
        lastMessage: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        timestamp: "04:20 pm",
        isOnline: false,
        unreadCount: 0,
        profileImage: "assets/images/user5.jpg",
      ),
    ];

    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return _buildChatTile(context, conversation);
      },
    );
  }

  Widget _buildChatTile(BuildContext context, ChatConversation conversation) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          children: [
            // Profile Picture
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(conversation.profileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Online Status Indicator
            if (conversation.isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                conversation.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              conversation.timestamp,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                conversation.lastMessage,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (conversation.unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  conversation.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                             builder: (context) => ChatScreen(
                 contactName: conversation.name,
                 isOnline: conversation.isOnline,
               ),
            ),
          );
        },
      ),
    );
  }
}

class ChatConversation {
  final String name;
  final String lastMessage;
  final String timestamp;
  final bool isOnline;
  final int unreadCount;
  final String profileImage;

  ChatConversation({
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.isOnline,
    required this.unreadCount,
    required this.profileImage,
  });
}
