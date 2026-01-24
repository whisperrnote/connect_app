import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/colors.dart';
import '../widgets/glass_card.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Ambient Glow
        Positioned(
          top: -100,
          right: -100,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CALLS',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  Text(
                    'Voice and video history',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.gunmetal,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildCallTile(index);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCallTile(int index) {
    final names = ['Sarah Chen', 'Jordan Smith', 'Maria Garcia'];
    final types = ['Incoming', 'Outgoing', 'Missed'];
    final icons = [LucideIcons.phoneIncoming, LucideIcons.phoneOutgoing, LucideIcons.phoneMissed];
    final colors = [Colors.greenAccent, Colors.blueAccent, Colors.redAccent];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        opacity: 0.3,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surface2,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Center(
                child: Text(
                  names[index][0],
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.bold,
                    color: AppColors.titanium,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    names[index],
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: AppColors.titanium,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(icons[index], size: 12, color: colors[index]),
                      const SizedBox(width: 6),
                      Text(
                        types[index],
                        style: GoogleFonts.inter(
                          color: AppColors.gunmetal,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '2h ago',
                        style: GoogleFonts.inter(
                          color: AppColors.carbon,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(LucideIcons.phone, size: 18, color: AppColors.electric),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.05, end: 0);
  }
}