import 'package:flutter/material.dart';

class AddConsumptionLogScreen extends StatelessWidget {
  const AddConsumptionLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1B2559),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Log Consumption',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fact_check_rounded,
              size: 100,
              color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
            ),
            const SizedBox(height: 24),
            const Text(
              'Log Usage Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Implementing material usage tracking...',
              style: TextStyle(color: Color(0xFFA3AED0)),
            ),
          ],
        ),
      ),
    );
  }
}
