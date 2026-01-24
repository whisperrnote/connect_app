import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/colors.dart';
import '../widgets/glass_card.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Gradient
        Positioned(
          top: -150,
          right: -150,
          child: Container(
            width: 400,
            height: 400,
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

        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DISCOVER',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: AppColors.electric,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ecosystem',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titanium,
                ),
              ).animate().fadeIn().slideY(begin: 0.1, end: 0),
              
              const SizedBox(height: 8),
              Text(
                'Find and connect with awesome people across Whisperr',
                style: GoogleFonts.inter(
                  color: AppColors.gunmetal,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 32),

              GlassCard(
                opacity: 0.4,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.inter(color: AppColors.titanium),
                  decoration: InputDecoration(
                    hintText: 'Search by @username...',
                    hintStyle: GoogleFonts.inter(color: AppColors.gunmetal),
                    prefixIcon: const Icon(
                      LucideIcons.search,
                      color: AppColors.gunmetal,
                      size: 18,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              _buildUserGrid(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildUserCard(index);
      },
    );
  }

  Widget _buildUserCard(int index) {
    final names = ['Alex Rivers', 'Sarah Chen', 'Jordan Smith', 'Maria Garcia'];
    final usernames = ['@arivers', '@sarahc', '@jsmith', '@mgarcia'];
    
    return GlassCard(
      opacity: 0.3,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.surface2,
            child: Text(
              names[index][0],
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.electric,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            names[index],
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: AppColors.titanium,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            usernames[index],
            style: GoogleFonts.spaceMono(
              color: AppColors.electric,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.electric.withOpacity(0.1),
              foregroundColor: AppColors.electric,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: AppColors.electric.withOpacity(0.2)),
              ),
            ),
            child: Text(
              'CONNECT',
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w900,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 100).ms).scale(begin: const Offset(0.9, 0.9));
  }
}