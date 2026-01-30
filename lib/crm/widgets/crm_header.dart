import 'package:flutter/material.dart';

class CrmHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;
  final bool showMenuButton;
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const CrmHeader({
    super.key,
    required this.title,
    this.subtitle = 'Customer Relationship Management',
    this.showBackButton = true,
    this.showMenuButton = true,
    this.onBack,
    this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (showBackButton)
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF1B2559),
                size: 20,
              ),
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            ),
          )
        else
          const SizedBox.shrink(),

        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: showBackButton ? 16 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2559),
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA3AED0),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showMenuButton)
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE0E5F2).withValues(alpha: 0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.menu_rounded, color: Color(0xFF1B2559)),
              onPressed: onMenu ?? () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
      ],
    );
  }
}
