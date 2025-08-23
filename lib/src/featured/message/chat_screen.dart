import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';
import 'call_screen.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;
  final bool isOnline;

  const ChatScreen({
    super.key,
    required this.contactName,
    this.isOnline = false,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadSampleMessages();
  }

  void _loadSampleMessages() {
    _messages.addAll([
      ChatMessage(
        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        isSent: false,
        timestamp: "08:04 pm",
        senderName: "Jenny Wilson",
      ),
      ChatMessage(
        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        isSent: true,
        timestamp: "08:04 pm",
        senderName: "Jenny Wilson",
      ),
      ChatMessage(
        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        isSent: false,
        timestamp: "08:04 pm",
        senderName: "Jenny Wilson",
      ),
      ChatMessage(
        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        isSent: true,
        timestamp: "08:04 pm",
        senderName: "Jenny Wilson",
      ),
      ChatMessage(
        isVoiceMessage: true,
        duration: "0:13",
        isSent: true,
        timestamp: "08:04 pm",
        senderName: "Jenny Wilson",
      ),
    ]);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _messageController.text.trim(),
            isSent: true,
            timestamp: _getCurrentTime(),
            senderName: "Jenny Wilson",
          ),
        );
      });
      _messageController.clear();
      _scrollToBottom();
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    final period = hour >= 12 ? 'pm' : 'am';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          _buildHeader(),

          // Chat Area
          Expanded(
            child: _buildChatArea(),
          ),

          // Message Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Row(
        children: [
          // Back Button
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ),
              padding: EdgeInsets.zero,
            ),
          ),

          const SizedBox(width: 12),

          // Contact Info
          Expanded(
            child: Row(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    widget.contactName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Name and Status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.contactName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.isOnline ? "Online" : "Offline",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Call Button
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CallScreen(
                      callerName: widget.contactName,
                      callerImage: "assets/images/profile_placeholder.png",
                      isVideoCall: true,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.call,
                color: AppColors.primary,
                size: 20,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatArea() {
    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          // Today Label
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "TODAY",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: message.isSent
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // Message Bubble
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: message.isSent ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(message.isSent ? 20 : 4),
                bottomRight: Radius.circular(message.isSent ? 4 : 20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: message.isVoiceMessage
                ? _buildVoiceMessage()
                : Text(
                    message.text!,
                    style: TextStyle(
                      color: message.isSent ? Colors.white : AppColors.primaryText,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
          ),

          const SizedBox(height: 8),

          // Message Info Row
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (message.isSent) ...[
                // Timestamp for sent messages
                Text(
                  message.timestamp,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
                const SizedBox(width: 8),
              ],

              // Profile Picture
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey[300],
                child: Text(
                  message.senderName.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: 6),

              // Sender Name
              Text(
                message.senderName,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),

              if (!message.isSent) ...[
                const SizedBox(width: 8),
                // Timestamp for received messages
                Text(
                  message.timestamp,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceMessage() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Play Button
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.play_arrow,
            color: AppColors.primary,
            size: 16,
          ),
        ),

        const SizedBox(width: 12),

        // Waveform
        Row(
          children: List.generate(5, (index) {
            return Container(
              margin: const EdgeInsets.only(right: 2),
              width: 3,
              height: 20 - (index * 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),

        const SizedBox(width: 12),

        // Duration
        Text(
          "• 0:13",
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Message Input Field
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: "Type a message here...",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),

          const SizedBox(width: 12),

          // Voice Message Button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                // Handle voice message recording
              },
              icon: const Icon(
                Icons.mic,
                color: Colors.white,
                size: 20,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String? text;
  final bool isSent;
  final String timestamp;
  final String senderName;
  final bool isVoiceMessage;
  final String? duration;

  ChatMessage({
    this.text,
    required this.isSent,
    required this.timestamp,
    required this.senderName,
    this.isVoiceMessage = false,
    this.duration,
  }) : assert(text != null || isVoiceMessage, 'Either text or isVoiceMessage must be provided');
}
