import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/colors.dart';
import '../widgets/glass_card.dart';

class CallScreen extends StatelessWidget {
  final String name;
  const CallScreen({super.key, this.name = 'John Doe'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBg,
      body: Stack(
        children: [
          // Simulated Video Background (Blurred Avatar)
          Positioned.fill(
            child: Container(
              color: AppColors.surface,
              child: Center(
                child: Container(
                  width: 200, height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.electric.withOpacity(0.2), width: 2),
                  ),
                  child: Center(
                    child: Text(
                      name[0],
                      style: GoogleFonts.spaceGrotesk(fontSize: 80, fontWeight: FontWeight.w900, color: AppColors.electric),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Glass Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 64),
                
                // Call Header
                const Icon(LucideIcons.shieldCheck, color: AppColors.electric, size: 24),
                const SizedBox(height: 12),
                Text(
                  'ENCRYPTED P2P CALL',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: AppColors.electric,
                    letterSpacing: 3,
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // User Identity
                Text(
                  name,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.titanium,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '00:42',
                  style: GoogleFonts.spaceMono(
                    fontSize: 16,
                    color: AppColors.gunmetal,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                // Call Controls
                GlassCard(
                  opacity: 0.4,
                  borderRadius: BorderRadius.circular(32),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCallAction(LucideIcons.micOff, false),
                      _buildCallAction(LucideIcons.video, false),
                      _buildCallAction(LucideIcons.volume2, true),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 64, height: 64,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(LucideIcons.phoneOff, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallAction(IconData icon, bool isActive) {
    return Container(
      width: 52, height: 52,
      decoration: BoxDecoration(
        color: isActive ? AppColors.electric.withOpacity(0.1) : AppColors.surface2,
        shape: BoxShape.circle,
        border: Border.all(color: isActive ? AppColors.electric : AppColors.borderSubtle),
      ),
      child: Icon(icon, color: isActive ? AppColors.electric : AppColors.titanium, size: 20),
    );
  }
}
