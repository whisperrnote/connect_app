import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/colors.dart';
import '../widgets/glass_card.dart';

import '../core/services/social_service.dart';
import '../core/models/moment_model.dart';
import '../widgets/whisperr_shimmer.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final SocialService _socialService = SocialService();
  List<Moment> _moments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMoments();
  }

  Future<void> _fetchMoments() async {
    try {
      final moments = await _socialService.listMoments();
      setState(() {
        _moments = moments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

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
                  border: const Border(
                    bottom: BorderSide(color: AppColors.borderSubtle),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          LucideIcons.arrowLeft,
                          color: AppColors.gunmetal,
                          size: 20,
                        ),
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
                  child: RefreshIndicator(
                    onRefresh: _fetchMoments,
                    color: AppColors.electric,
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
                              hintStyle: GoogleFonts.inter(
                                color: AppColors.gunmetal,
                                fontSize: 14,
                              ),
                              prefixIcon: const Icon(
                                LucideIcons.search,
                                color: AppColors.gunmetal,
                                size: 18,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        _buildSectionLabel('MOMENTS FEED'),
                        const SizedBox(height: 16),

                        if (_isLoading)
                          ...List.generate(
                            3,
                            (index) => const Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: WhisperrShimmer(
                                height: 150,
                                width: double.infinity,
                              ),
                            ),
                          )
                        else if (_moments.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Text(
                                'No moments found.',
                                style: GoogleFonts.inter(
                                  color: AppColors.gunmetal,
                                ),
                              ),
                            ),
                          )
                        else
                          ..._moments.map((moment) => _buildMomentItem(moment)),

                        const SizedBox(height: 32),

                        _buildSectionLabel('SUGGESTED FOR YOU'),
                        const SizedBox(height: 16),
                        _buildDiscoverItem(
                          'CyberSentinel',
                          'Security Researcher',
                          true,
                        ),
                        _buildDiscoverItem('NeuralLink', 'AI Architect', false),

                        const SizedBox(height: 32),

                        _buildSectionLabel('GLOBAL CHANNELS'),
                        const SizedBox(height: 16),
                        _buildChannelItem(
                          'Whisperr Core',
                          'General ecosystem discussion',
                          1240,
                        ),
                        _buildChannelItem(
                          'Dev Portal',
                          'Build on top of Whisperr',
                          850,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMomentItem(Moment moment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassCard(
        opacity: 0.3,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    LucideIcons.user,
                    size: 20,
                    color: AppColors.electric,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User ${moment.userId.substring(0, 6)}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: AppColors.titanium,
                      ),
                    ),
                    Text(
                      moment.createdAt.toIso8601String(),
                      style: GoogleFonts.spaceMono(
                        fontSize: 10,
                        color: AppColors.gunmetal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              moment.content,
              style: GoogleFonts.inter(color: AppColors.titanium, height: 1.5),
            ),
            if (moment.images != null && moment.images!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.surface2,
                ),
                child: const Icon(LucideIcons.image, color: AppColors.gunmetal),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                _buildMomentAction(
                  LucideIcons.heart,
                  moment.likes?.length.toString() ?? '0',
                ),
                const SizedBox(width: 16),
                _buildMomentAction(
                  LucideIcons.messageSquare,
                  moment.comments?.length.toString() ?? '0',
                ),
                const Spacer(),
                const Icon(
                  LucideIcons.share2,
                  size: 18,
                  color: AppColors.gunmetal,
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildMomentAction(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.gunmetal),
        const SizedBox(width: 6),
        Text(
          count,
          style: GoogleFonts.spaceMono(fontSize: 12, color: AppColors.gunmetal),
        ),
      ],
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
              width: 48,
              height: 48,
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
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: AppColors.titanium,
                        ),
                      ),
                      if (isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          LucideIcons.shieldCheck,
                          size: 14,
                          color: AppColors.electric,
                        ),
                      ],
                    ],
                  ),
                  Text(
                    role,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.gunmetal,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface2,
                foregroundColor: AppColors.titanium,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
              width: 48,
              height: 48,
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
                  Text(
                    title,
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.bold,
                      color: AppColors.titanium,
                    ),
                  ),
                  Text(
                    desc,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.gunmetal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(
                  LucideIcons.users,
                  size: 14,
                  color: AppColors.gunmetal,
                ),
                const SizedBox(height: 4),
                Text(
                  '$members',
                  style: GoogleFonts.spaceMono(
                    fontSize: 10,
                    color: AppColors.gunmetal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
