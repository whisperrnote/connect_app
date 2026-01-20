import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/colors.dart';

import '../widgets/glass_card.dart';

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
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Header
                GlassCard(
                  borderRadius: BorderRadius.zero,
                  opacity: 0.8,
                  border: const Border(bottom: BorderSide(color: AppColors.borderSubtle)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.arrowLeft, color: AppColors.gunmetal, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.surface2,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.borderSubtle),
                        ),
                        child: Center(
                          child: Text(
                            'JD', 
                            style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.electric)
                          ),
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
                              fontSize: 15,
                              color: AppColors.titanium,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 6, height: 6,
                                decoration: const BoxDecoration(color: AppColors.electric, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Secure Channel',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: AppColors.gunmetal,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(LucideIcons.phone, color: AppColors.gunmetal, size: 20),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.moreVertical, color: AppColors.gunmetal, size: 20),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                // Messages
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(24),
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[_messages.length - 1 - index];
                      return _buildMessageBubble(msg);
                    },
                  ),
                ),

                // Input Area
                GlassCard(
                  borderRadius: BorderRadius.zero,
                  opacity: 0.9,
                  border: const Border(top: BorderSide(color: AppColors.borderSubtle)),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                  child: Row(
                    children: [
                      _buildInputAction(LucideIcons.plus),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface2,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.borderSubtle),
                          ),
                          child: TextField(
                            controller: _controller,
                            style: GoogleFonts.inter(color: AppColors.titanium, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Transmit message...',
                              hintStyle: GoogleFonts.inter(color: AppColors.gunmetal, fontSize: 14),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          if (_controller.text.isNotEmpty) {
                            setState(() {
                              _messages.add(Message(
                                content: _controller.text, 
                                isMe: true, 
                                time: 'JUST NOW'
                              ));
                              _controller.clear();
                            });
                          }
                        },
                        child: Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.electric,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(LucideIcons.send, color: AppColors.voidBg, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputAction(IconData icon) {
    return Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Icon(icon, size: 18, color: AppColors.gunmetal),
    );
  }

  Widget _buildMessageBubble(Message msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 280),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: msg.isMe ? AppColors.electric : AppColors.surface2,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: msg.isMe ? const Radius.circular(20) : const Radius.circular(4),
                  bottomRight: msg.isMe ? const Radius.circular(4) : const Radius.circular(20),
                ),
                border: msg.isMe ? null : Border.all(color: AppColors.borderSubtle),
              ),
              child: Text(
                msg.content,
                style: GoogleFonts.inter(
                  color: msg.isMe ? AppColors.voidBg : AppColors.titanium,
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: msg.isMe ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                msg.time.toUpperCase(),
                style: GoogleFonts.spaceMono(
                  fontSize: 8,
                  color: AppColors.gunmetal,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
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
