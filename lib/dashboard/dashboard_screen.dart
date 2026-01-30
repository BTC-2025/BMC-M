import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../navigation/side_menu.dart';
import 'dashboard_home_screen.dart';
import 'profile_screen.dart';
import 'stock_screen.dart';
import 'sales_screen.dart';
import 'widgets/beautiful_nav_bar.dart';
import '../config/app_colors.dart';
import 'ai_assistant_screen.dart';
import '../navigation/route_names.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _isNavBarVisible = true;
  double _lastScrollOffset = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardHomeScreen(),
    const StockScreen(),
    const SalesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isNavBarVisible = true;
      _isNavBarVisible = true;
    });
  }

  void _onAiTapped() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AIAssistantScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutQuart;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_selectedIndex == 3) return;

    final currentOffset = _scrollController.offset;
    final delta = currentOffset - _lastScrollOffset;

    if (delta > 10 && _isNavBarVisible) {
      setState(() => _isNavBarVisible = false);
    } else if (delta < -10 && !_isNavBarVisible) {
      setState(() => _isNavBarVisible = true);
    }

    _lastScrollOffset = currentOffset;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: const SideMenu(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (_selectedIndex == 3) return false;

          if (notification is ScrollUpdateNotification) {
            final delta = notification.scrollDelta ?? 0;
            if (delta > 8 && _isNavBarVisible) {
              setState(() => _isNavBarVisible = false);
            } else if (delta < -8 && !_isNavBarVisible) {
              setState(() => _isNavBarVisible = true);
            }
          }
          return false;
        },
        child: Stack(
          children: [
            Column(
              children: [
                // App Bar with dynamic height
                _buildAppBar(isSmallScreen),
                // Main Content
                Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
              ],
            ),
            // Simple, stable Bottom Navigation Bar (Old version)
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: BeautifulNavBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                onAiTap: _onAiTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(bool isSmallScreen) {
    final Map<int, AppBarConfig> configs = {
      0: AppBarConfig(
        title: 'Dashboard',
        subtitle: 'Business Overview',
        actions: [
          _buildHeaderAction(Iconsax.notification, () {}),
          _buildHeaderAction(
            Iconsax.message,
            () => Navigator.pushNamed(context, RouteNames.chatList),
          ),
        ],
      ),
      1: AppBarConfig(
        title: 'Stock',
        subtitle: 'Product Management',
        actions: [
          _buildHeaderAction(Iconsax.add, () {}),
          _buildHeaderAction(Iconsax.scan, () {}),
        ],
      ),
      2: AppBarConfig(
        title: 'Sales',
        subtitle: 'Orders & Transactions',
        actions: [
          _buildHeaderAction(Iconsax.add, () {}),
          _buildHeaderAction(Iconsax.filter, () {}),
        ],
      ),
      3: AppBarConfig(
        title: 'Profile',
        subtitle: 'Account Settings',
        actions: [_buildHeaderAction(Iconsax.setting, () {})],
      ),
    };

    final config = configs[_selectedIndex]!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, const Color(0xFF1E40AF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16 : 24,
            vertical: isSmallScreen ? 12 : 24,
          ),
          child: Row(
            children: [
              if (_selectedIndex == 0)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Iconsax.menu_1,
                        color: Colors.white,
                        size: isSmallScreen ? 20 : 24,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      config.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 22 : 26,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      config.subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: isSmallScreen ? 12 : 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              ...config.actions,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

class AppBarConfig {
  final String title;
  final String subtitle;
  final List<Widget> actions;

  AppBarConfig({
    required this.title,
    required this.subtitle,
    required this.actions,
  });
}
