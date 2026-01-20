import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/colors.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [
    Message(content: 'Hey there! How is the project going?', isMe: false, time: '10:00 AM'),
    Message(content: 'Making great progress. The Flutter port is coming along nicely.', isMe: true, time: '10:05 AM'),
    Message(content: 'That is awesome to hear! Did you implement the biometric auth?', isMe: false, time: '10:06 AM'),
    Message(content: 'Yes, just finished mirroring the UI flows.', isMe: true, time: '10:08 AM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBg,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.titanium),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surface2,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('JD', style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.titanium,
                  ),
                ),
                Text(
                  'Online',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.electric,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.phone, color: AppColors.electric),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LucideIcons.video, color: AppColors.electric),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderSubtle, height: 1),
        ),
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              reverse: true, // Typically chats are reversed, but for static list we'll just render top down? No, reverse is standard.
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // Reverse index for display
                final msg = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(msg);
              },
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.borderSubtle)),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.paperclip, color: AppColors.gunmetal),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _controller,
                      style: GoogleFonts.inter(color: AppColors.titanium),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: GoogleFonts.inter(color: AppColors.gunmetal),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.electric,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          _messages.add(Message(
                            content: _controller.text, 
                            isMe: true, 
                            time: 'Now'
                          ));
                          _controller.clear();
                        });
                      }
                    },
                    icon: const Icon(LucideIcons.send, color: AppColors.voidBg, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message msg) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: msg.isMe ? AppColors.electric : AppColors.surface2,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: msg.isMe ? const Radius.circular(20) : const Radius.circular(4),
            bottomRight: msg.isMe ? const Radius.circular(4) : const Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msg.content,
              style: GoogleFonts.inter(
                color: msg.isMe ? AppColors.voidBg : AppColors.titanium,
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              msg.time,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: msg.isMe ? AppColors.voidBg.withOpacity(0.7) : AppColors.gunmetal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String content;
  final bool isMe;
  final String time;

  Message({required this.content, required this.isMe, required this.time});
}
