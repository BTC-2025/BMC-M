import 'package:flutter/material.dart';

/// Standardized loading indicator for consistent UX across the app.
/// Use this instead of raw CircularProgressIndicator.
class LoadingState extends StatelessWidget {
  final String? message;
  final Color? color;

  const LoadingState({super.key, this.message, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? const Color(0xFF4318FF),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: const TextStyle(
                color: Color(0xFFA3AED0),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
