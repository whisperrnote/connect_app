import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/colors.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chats',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.titanium,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(LucideIcons.lock, size: 14, color: AppColors.electric),
                          const SizedBox(width: 8),
                          Text(
                            'ENCRYPTED',
                            style: GoogleFonts.spaceMono(
                              color: AppColors.electric,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => context.read<AuthProvider>().logout(),
                    icon: const Icon(LucideIcons.logOut, color: AppColors.gunmetal),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                style: GoogleFonts.inter(color: AppColors.titanium),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surface,
                  hintText: 'Search encrypted chats...',
                  hintStyle: GoogleFonts.inter(color: AppColors.gunmetal),
                  prefixIcon: const Icon(LucideIcons.search, color: AppColors.gunmetal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Chat List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: 8,
                separatorBuilder: (_, __) => const Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Divider(color: AppColors.borderSubtle, height: 1),
                ),
                itemBuilder: (context, index) => _buildChatTile(index),
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

  Widget _buildChatTile(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.transparent, // For hit testing
      child: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.surface2,
                child: Text('JD', style: TextStyle(color: AppColors.titanium)),
              ),
              Positioned(
                right: 0, bottom: 0,
                child: Container(
                  width: 12, height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.electric,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(BorderSide(color: AppColors.voidBg, width: 2)),
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
                        fontWeight: FontWeight.w600,
                        color: AppColors.titanium,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '10:42 AM',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.gunmetal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Hey, did you see the new crypto update?',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: index == 0 ? AppColors.electric : AppColors.gunmetal,
                    fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
