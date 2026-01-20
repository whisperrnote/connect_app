import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/colors.dart';
import 'chat_detail_screen.dart';

import '../widgets/glass_card.dart';

import 'settings_screen.dart';
import 'discover_screen.dart';
import 'chat_detail_screen.dart';
import '../core/theme/glass_route.dart';

class ChatListScreen extends StatelessWidget {
  final bool isDesktop;
  const ChatListScreen({super.key, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBg,
      body: Stack(
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

          SafeArea(
            child: Column(
              children: [
                // Header
                GlassCard(
                  borderRadius: BorderRadius.zero,
                  opacity: 0.8,
                  border: const Border(bottom: BorderSide(color: AppColors.borderSubtle)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'COMMUNICATIONS',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: AppColors.electric,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Messages',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: isDesktop ? 36 : 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.titanium,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (isDesktop) ...[
                            _DesktopHeaderAction(LucideIcons.messageSquare, () {
                              // New message logic
                            }, isPrimary: true),
                            const SizedBox(width: 8),
                          ],
                          Container(
                            decoration: BoxDecoration(
                               color: AppColors.surface2,
                               borderRadius: BorderRadius.circular(12),
                               border: Border.all(color: AppColors.borderSubtle),
                            ),
                            child: IconButton(
                               onPressed: () {
                                 Navigator.push(
                                   context,
                                   GlassRoute(page: const DiscoverScreen()),
                                 );
                               },
                               icon: const Icon(LucideIcons.globe, size: 20, color: AppColors.electric),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                GlassRoute(page: const SettingsScreen()),
                              );
                            },
                            child: Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.electric,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.voidBg, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  'U',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.voidBg,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Search
                Padding(
                  padding: EdgeInsets.fromLTRB(24, isDesktop ? 32 : 24, 24, 16),
                  child: GlassCard(
                    opacity: 0.4,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      style: GoogleFonts.inter(color: AppColors.titanium),
                      decoration: InputDecoration(
                        hintText: 'Search encrypted channels...',
                        hintStyle: GoogleFonts.inter(color: AppColors.gunmetal),
                        prefixIcon: const Icon(LucideIcons.search, color: AppColors.gunmetal, size: 18),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
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
                  child: isDesktop 
                    ? _buildDesktopGrid()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return _buildChatTile(context, index);
                        },
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: isDesktop ? null : _buildMobileFAB(),
    );
  }

  Widget _buildDesktopGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return _buildChatTile(context, index);
      },
    );
  }

  Widget _buildMobileFAB() {
    return Container(
      height: 64, width: 64,
      decoration: BoxDecoration(
        color: AppColors.electric,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.electric.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        highlightElevation: 0,
        child: const Icon(LucideIcons.messageCircle, color: AppColors.voidBg, size: 28),
      ),
    );
  }
}

class _DesktopHeaderAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _DesktopHeaderAction(this.icon, this.onTap, {this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.electric : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isPrimary ? AppColors.electric : AppColors.borderSubtle),
        ),
        child: Icon(icon, size: 16, color: isPrimary ? AppColors.voidBg : AppColors.electric),
      ),
    );
  }
}


  Widget _buildTab(String label, bool isActive) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isActive ? AppColors.electric : AppColors.surface2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isActive ? AppColors.electric : AppColors.borderSubtle),
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

  Widget _buildChatTile(BuildContext context, int index) {
    final bool isUnread = index < 2;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            GlassRoute(page: const ChatDetailScreen()),
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
                        index == 0 ? 'JD' : 'AS',
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
                        width: 12,
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
                          index == 0 ? 'John Doe' : 'Alice Smith',
                          style: GoogleFonts.inter(
                            fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                            color: AppColors.titanium,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '10:42 AM',
                          style: GoogleFonts.inter(
                            color: isUnread ? AppColors.electric : AppColors.gunmetal,
                            fontSize: 11,
                            fontWeight: isUnread ? FontWeight.w700 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isUnread 
                        ? 'Hey, did you see the new crypto update?' 
                        : 'Sounds good, let\'s meet tomorrow.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: isUnread ? AppColors.titanium : AppColors.gunmetal,
                        fontWeight: isUnread ? FontWeight.w500 : FontWeight.w400,
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
