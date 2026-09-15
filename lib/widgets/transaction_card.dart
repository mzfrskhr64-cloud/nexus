import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexus/core/constants/formatters.dart';

import '../core/constants/app_colors.dart';
import '../cubit/transaction/transaction_cubit.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
  });

  final int? id;
  final double amount;
  final String type;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final transactionColor = _getTypeColor();

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),

        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: transactionColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            _getTypeIcon(),
            color: transactionColor,
            size: 22,
          ),
        ),

        title: Text(
          '${formatAmount(amount)} ريال',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          _getTypeName(),
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
          ),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              onPressed: () {
                if (id == null) {
                  return;
                }

                context.read<TransactionCubit>().archiveTransaction(id!);
              },
              icon: const Icon(Icons.archive_outlined),
              tooltip: 'أرشفة',
            ),
          ],
        ),
      ),
    );
  }

  String _getTypeName() {
    switch (type) {
      case 'sale':
        return 'بيع';

      case 'purchase':
        return 'شراء';

      case 'paymentReceived':
        return 'دفعة مستلمة';

      case 'paymentMade':
        return 'دفعة مدفوعة';

      default:
        return 'تعاملة';
    }
  }

  IconData _getTypeIcon() {
    switch (type) {
      case 'sale':
        return Icons.shopping_cart_outlined;

      case 'purchase':
        return Icons.shopping_bag_outlined;

      case 'paymentReceived':
        return Icons.arrow_downward;

      case 'paymentMade':
        return Icons.arrow_upward;

      default:
        return Icons.receipt_long_outlined;
    }
  }

  Color _getTypeColor() {
    switch (type) {
      case 'paymentReceived':
        return AppColors.positive;

      case 'paymentMade':
        return AppColors.negative;

      case 'sale':
        return AppColors.secondary;

      case 'purchase':
        return AppColors.warning;

      default:
        return Colors.grey;
    }
  }
}