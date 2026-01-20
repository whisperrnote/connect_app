import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/colors.dart';
import '../widgets/glass_card.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

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
                      Text(
                        'DISCOVER CONNECTIONS',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: AppColors.electric,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      // Search Bar
                      GlassCard(
                        opacity: 0.4,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          style: GoogleFonts.inter(color: AppColors.titanium),
                          decoration: InputDecoration(
                            hintText: 'Search by username or ID...',
                            hintStyle: GoogleFonts.inter(color: AppColors.gunmetal, fontSize: 14),
                            prefixIcon: const Icon(LucideIcons.search, color: AppColors.gunmetal, size: 18),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      _buildSectionLabel('SUGGESTED FOR YOU'),
                      const SizedBox(height: 16),
                      _buildDiscoverItem('CyberSentinel', 'Security Researcher', true),
                      _buildDiscoverItem('NeuralLink', 'AI Architect', false),
                      _buildDiscoverItem('FluxDev', 'Workflow Optimizer', false),

                      const SizedBox(height: 32),

                      _buildSectionLabel('GLOBAL CHANNELS'),
                      const SizedBox(height: 16),
                      _buildChannelItem('Whisperr Core', 'General ecosystem discussion', 1240),
                      _buildChannelItem('Dev Portal', 'Build on top of Whisperr', 850),
                      _buildChannelItem('Privacy Advocates', 'Securing the digital frontier', 3200),
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

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 10,
        fontWeight: FontWeight.w900,
        color: AppColors.gunmetal,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildDiscoverItem(String name, String role, bool isVerified) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        opacity: 0.3,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: const Icon(LucideIcons.user, color: AppColors.titanium),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppColors.titanium)),
                      if (isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(LucideIcons.shieldCheck, size: 14, color: AppColors.electric),
                      ],
                    ],
                  ),
                  Text(role, style: GoogleFonts.inter(fontSize: 12, color: AppColors.gunmetal)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface2,
                foregroundColor: AppColors.titanium,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Connect', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelItem(String title, String desc, int members) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        opacity: 0.3,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: AppColors.electricDim,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(LucideIcons.hash, color: AppColors.electric),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold, color: AppColors.titanium)),
                  Text(desc, style: GoogleFonts.inter(fontSize: 11, color: AppColors.gunmetal), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(LucideIcons.users, size: 14, color: AppColors.gunmetal),
                const SizedBox(height: 4),
                Text('$members', style: GoogleFonts.spaceMono(fontSize: 10, color: AppColors.gunmetal)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
