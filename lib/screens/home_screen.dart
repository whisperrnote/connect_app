import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/colors.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/app_bar.dart';
import '../widgets/sidebar.dart';
import '../widgets/ecosystem_portal.dart';
import '../widgets/ai_command_modal.dart';
import 'chat_list_screen.dart';
import 'discover_screen.dart';
import 'call_screen.dart';
import 'settings_screen.dart';
import '../core/theme/glass_route.dart';
import '../core/providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    const _HomePlaceholder(), // Replaces "/" or initial view
    const ChatListScreen(),
    const CallScreen(),
    const _ProfilePlaceholder(),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userInitials = authProvider.user?.name.substring(0, 1).toUpperCase() ?? 'U';

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.voidBg,
      drawer: ResponsiveLayout.isDesktop(context) 
        ? null 
        : Drawer(
            width: 280,
            backgroundColor: AppColors.voidBg,
            child: ConnectSidebar(
              selectedIndex: _selectedIndex,
              onTap: (index) {
                setState(() => _selectedIndex = index);
                Navigator.pop(context);
              },
            ),
          ),
      body: ResponsiveLayout(
        mobile: Stack(
          children: [
            Column(
              children: [
                ConnectAppBar(
                  onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                  userInitials: userInitials,
                  onEcosystemTap: () => showDialog(
                    context: context,
                    builder: (context) => const EcosystemPortal(),
                  ),
                  onAITap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const AICommandModal(),
                  ),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _screens,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ConnectBottomNav(
                currentIndex: _selectedIndex,
                onTap: (index) => setState(() => _selectedIndex = index),
              ),
            ),
          ],
        ),
        desktop: Row(
          children: [
            ConnectSidebar(
              selectedIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
            ),
            const VerticalDivider(width: 1, color: AppColors.borderSubtle),
            Expanded(
              child: Column(
                children: [
                  ConnectAppBar(
                    onMenuTap: () {},
                    userInitials: userInitials,
                    onEcosystemTap: () => showDialog(
                      context: context,
                      builder: (context) => const EcosystemPortal(),
                    ),
                    onAITap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const AICommandModal(),
                    ),
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: _screens.map((s) {
                        if (s is ChatListScreen) {
                          return const ChatListScreen(isDesktop: true);
                        }
                        return s;
                      }).toList(),
                    ),
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

class _HomePlaceholder extends StatelessWidget {
  const _HomePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const DiscoverScreen(); // The home usually shows discover/feed in connect
  }
}

class _ProfilePlaceholder extends StatelessWidget {
  const _ProfilePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.user, size: 64, color: AppColors.gunmetal),
          const SizedBox(height: 16),
          Text(
            'User Profile',
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.gunmetal,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your identity across the ecosystem.',
            style: GoogleFonts.inter(
              color: AppColors.carbon,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
