import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/colors.dart';
import 'logo.dart';

class ConnectSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const ConnectSidebar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: AppColors.voidBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Logo(),
          ),
          const SizedBox(height: 8),
          _SidebarItem(
            icon: LucideIcons.home,
            label: 'Home',
            isActive: selectedIndex == 0,
            onTap: () => onTap(0),
          ),
          _SidebarItem(
            icon: LucideIcons.messageSquare,
            label: 'Chats',
            isActive: selectedIndex == 1,
            onTap: () => onTap(1),
          ),
          _SidebarItem(
            icon: LucideIcons.phone,
            label: 'Calls',
            isActive: selectedIndex == 2,
            onTap: () => onTap(2),
          ),
          _SidebarItem(
            icon: LucideIcons.user,
            label: 'Profile',
            isActive: selectedIndex == 3,
            onTap: () => onTap(3),
          ),
          
          const Spacer(),
          
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'THEME',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.carbon,
                    letterSpacing: 1.5,
                  ),
                ),
                const Icon(LucideIcons.moon, size: 18, color: AppColors.gunmetal),
              ],
            ),
          ),

          _SidebarItem(
            icon: LucideIcons.settings,
            label: 'Settings',
            onTap: () {},
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.electric.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive ? Border.all(color: AppColors.electric.withOpacity(0.2)) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? AppColors.electric : AppColors.gunmetal,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? Colors.white : AppColors.gunmetal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
