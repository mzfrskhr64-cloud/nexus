import 'package:flutter/material.dart';

import 'package:nexus/core/constants/app_colors.dart';
import 'package:nexus/core/constants/formatters.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({
    super.key,
    required this.name,
    required this.balance,
    this.onTap,
  });

  final String name;
  final double balance;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isPositive = balance >= 0;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),

        leading: CircleAvatar(
          radius: 24,
          backgroundColor: (isPositive
              ? AppColors.positive
              : AppColors.negative)
              .withValues(alpha: 0.1),
          child: Text(
            name.isNotEmpty ? name[0] : '?',
            style: TextStyle(
              color: isPositive
                  ? AppColors.positive
                  : AppColors.negative,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),

        subtitle: Text(
          isPositive ? 'لك عنده' : 'عليك له',
          style: TextStyle(
            color: isPositive
                ? AppColors.positive
                : AppColors.negative,
          ),
        ),

        trailing: Text(
          '${formatAmount(balance.abs())} ريال',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: isPositive
                ? AppColors.positive
                : AppColors.negative,
          ),
        ),
      ),
    );
  }
}