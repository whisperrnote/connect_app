import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../core/theme/colors.dart';
import 'chat_detail_screen.dart';
import '../core/providers/auth_provider.dart';
import '../core/services/chat_service.dart';
import '../core/models/conversation_model.dart';
import '../widgets/glass_card.dart';
import 'settings_screen.dart';
import 'discover_screen.dart';
import '../core/theme/glass_route.dart';

class ChatListScreen extends StatefulWidget {
  final bool isDesktop;
  const ChatListScreen({super.key, this.isDesktop = false});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ChatService _chatService = ChatService();
  List<Conversation> _conversations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchChats();
  }

  Future<void> _fetchChats() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user != null) {
      try {
        final conversations = await _chatService.listConversations(
          authProvider.user!.$id,
        );
        if (mounted) {
          setState(() {
            _conversations = conversations;
            _isLoading = false;
          });
        }
      } catch (e) {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Ambient Glow
        Positioned(
          bottom: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.electric.withOpacity(0.05),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        Column(
          children: [
            // Search & Filters Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MESSAGES',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    opacity: 0.4,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      style: GoogleFonts.inter(color: AppColors.titanium),
                      decoration: InputDecoration(
                        hintText: 'Search encrypted channels...',
                        hintStyle: GoogleFonts.inter(color: AppColors.gunmetal),
                        prefixIcon: const Icon(
                          LucideIcons.search,
                          color: AppColors.gunmetal,
                          size: 18,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildTab('Direct', true),
                  _buildTab('Groups', false),
                  _buildTab('Secure', false),
                  _buildTab('Archive', false),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // List
            Expanded(
              child: RefreshIndicator(
                onRefresh: _fetchChats,
                color: AppColors.electric,
                backgroundColor: AppColors.surface,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.electric,
                        ),
                      )
                    : _conversations.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              LucideIcons.messageSquare,
                              size: 48,
                              color: AppColors.gunmetal,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No conversations yet.',
                              style: GoogleFonts.inter(
                                color: AppColors.gunmetal,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                        itemCount: _conversations.length,
                        itemBuilder: (context, index) {
                          return _buildChatTile(
                            context,
                            _conversations[index],
                            index,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isActive ? AppColors.electric : AppColors.surface2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive ? AppColors.electric : AppColors.borderSubtle,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          color: isActive ? AppColors.voidBg : AppColors.gunmetal,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildChatTile(
    BuildContext context,
    Conversation conversation,
    int index,
  ) {
    final bool isUnread = index < 2; // Placeholder
    final String participantName =
        conversation.name ??
        (conversation.participants.length > 1 ? 'Group' : 'Contact');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            GlassRoute(page: ChatDetailScreen(conversation: conversation)),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: GlassCard(
          opacity: 0.3,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Center(
                      child: Text(
                        participantName.substring(0, 1),
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          color: AppColors.titanium,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.electric,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.voidBg, width: 2),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          participantName,
                          style: GoogleFonts.inter(
                            fontWeight: isUnread
                                ? FontWeight.w700
                                : FontWeight.w600,
                            color: AppColors.titanium,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '10:42 AM',
                          style: GoogleFonts.inter(
                            color: isUnread
                                ? AppColors.electric
                                : AppColors.gunmetal,
                            fontSize: 11,
                            fontWeight: isUnread
                                ? FontWeight.w700
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Secure Channel',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: isUnread
                            ? AppColors.titanium
                            : AppColors.gunmetal,
                        fontWeight: isUnread
                            ? FontWeight.w500
                            : FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.05, end: 0);
  }
}