import 'package:flutter/material.dart';

class ManufacturingHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;
  final bool showMenuButton;
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const ManufacturingHeader({
    super.key,
    required this.title,
    this.subtitle = 'Production Floor Control',
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
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFFE65100), // Orange tint
                size: 20,
              ),
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            ),
          )
        else
          const SizedBox(width: 45),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.menu_rounded, color: Color(0xFFE65100)),
              onPressed: onMenu ?? () => Scaffold.of(context).openEndDrawer(),
            ),
          )
        else
          const SizedBox(width: 45),
      ],
    );
  }
}
