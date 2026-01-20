import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/colors.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Messages',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: AppColors.titanium,
                      height: 1.1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      shape: const CircleBorder(),
                    ),
                    icon: const Icon(LucideIcons.edit3, size: 20, color: AppColors.electric),
                  ),
                ],
              ),
            ),

            // Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: TextField(
                  style: GoogleFonts.inter(color: AppColors.titanium),
                  decoration: InputDecoration(
                    hintText: 'Search encrypted chats...',
                    hintStyle: GoogleFonts.inter(color: AppColors.gunmetal),
                    prefixIcon: const Icon(LucideIcons.search, color: AppColors.gunmetal),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Tabs / Filters (Optional, but good for "Private" vs "Group")
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildTab('All', true),
                  _buildTab('Direct', false),
                  _buildTab('Groups', false),
                  _buildTab('Archived', false),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: 8,
                separatorBuilder: (context, index) => const Divider(
                  color: AppColors.borderSubtle, 
                  height: 1, 
                  indent: 80,
                ),
                itemBuilder: (context, index) {
                  return _buildChatTile(context, index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.electric,
        child: const Icon(LucideIcons.messageSquarePlus, color: AppColors.voidBg),
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 24),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: isActive ? const Border(bottom: BorderSide(color: AppColors.electric, width: 2)) : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: isActive ? AppColors.titanium : AppColors.gunmetal,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildChatTile(BuildContext context, int index) {
    final bool isUnread = index < 2;
    
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatDetailScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: Center(
                    child: Text(
                      'JD',
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                        color: AppColors.titanium,
                      ),
                    ),
                  ),
                ),
                if (index == 0) // Online status
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 14,
                      height: 14,
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
                        'John Doe',
                        style: GoogleFonts.inter(
                          fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                          color: AppColors.titanium,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '10:42 AM',
                        style: GoogleFonts.inter(
                          fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
                          color: isUnread ? AppColors.electric : AppColors.gunmetal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (index == 2) // Sent icon example
                        const Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(LucideIcons.checkCheck, size: 14, color: AppColors.electric),
                        ),
                      Expanded(
                        child: Text(
                          isUnread 
                            ? 'Hey, did you see the new crypto update?' 
                            : 'Sounds good, let\'s meet tomorrow.',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: isUnread ? AppColors.titanium : AppColors.gunmetal,
                            fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (isUnread)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.electric,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
