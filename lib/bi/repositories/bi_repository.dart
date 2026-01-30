import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BiRepository {
  Future<Map<String, dynamic>> getOverviewMetrics() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    return {
      'kpis': [
        {
          'title': 'Total Revenue',
          'value': '\$2.4M',
          'subtitle': '+12.5% vs last month',
          'color': const Color(0xFF4318FF),
          'icon': Iconsax.money_recive,
        },
        {
          'title': 'Net Profit',
          'value': '\$482k',
          'subtitle': '+8.2% vs last month',
          'color': const Color(0xFF05CD99),
          'icon': Iconsax.wallet_check,
        },
        {
          'title': 'Total Costs',
          'value': '\$1.2M',
          'subtitle': '-2.4% vs last month',
          'color': const Color(0xFFEE5D50),
          'icon': Iconsax.money_send,
        },
        {
          'title': 'Active Projects',
          'value': '42',
          'subtitle': 'On Track',
          'color': const Color(0xFFFFB547),
          'icon': Iconsax.task_square,
        },
      ],
      'insights': [
        {
          'title': 'Inventory Alert',
          'description': 'Stock levels for "Product X" are below 20%.',
          'icon': Iconsax.warning_2,
          'color': const Color(0xFFEE5D50),
        },
        {
          'title': 'Sales Spike',
          'description': 'Revenue is up 12% compared to last week.',
          'icon': Iconsax.trend_up,
          'color': const Color(0xFF05CD99),
        },
        {
          'title': 'Task Completion',
          'description': 'Project "Alpha" is ahead of schedule.',
          'icon': Iconsax.tick_circle,
          'color': const Color(0xFF4318FF),
        },
      ],
      'charts': {
        'revenue_vs_expenses': [0.6, 0.8, 0.5, 0.9, 0.7, 0.4, 0.6],
        'sales_trend': [
          {'month': 'Jan', 'value': 20},
          {'month': 'Feb', 'value': 35},
          {'month': 'Mar', 'value': 28},
          {'month': 'Apr', 'value': 45},
          {'month': 'May', 'value': 40},
          {'month': 'Jun', 'value': 55},
        ],
        'category_distribution': [
          {
            'name': 'Electronics',
            'value': 45,
            'color': const Color(0xFF4318FF),
          },
          {'name': 'Fashion', 'value': 30, 'color': const Color(0xFF05CD99)},
          {'name': 'Home', 'value': 15, 'color': const Color(0xFFFFB547)},
          {'name': 'Others', 'value': 10, 'color': const Color(0xFFEE5D50)},
        ],
      },
      'top_products': [
        {
          'id': '#PROD-001',
          'name': 'Ergonomic Chair',
          'category': 'Furniture',
          'price': '\$249.00',
          'sold': '1.2k',
          'revenue': '\$298k',
          'status': 'In Stock',
        },
        {
          'id': '#PROD-002',
          'name': 'Wireless Keyboard',
          'category': 'Electronics',
          'price': '\$89.00',
          'sold': '850',
          'revenue': '\$75k',
          'status': 'Low Stock',
        },
        {
          'id': '#PROD-003',
          'name': 'Smart Watch Gen 5',
          'category': 'Electronics',
          'price': '\$399.00',
          'sold': '2.4k',
          'revenue': '\$957k',
          'status': 'In Stock',
        },
        {
          'id': '#PROD-004',
          'name': 'Running Shoes',
          'category': 'Fashion',
          'price': '\$120.00',
          'sold': '540',
          'revenue': '\$64k',
          'status': 'Out of Stock',
        },
      ],
    };
  }
}
