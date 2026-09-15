import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/partner/partner_cubit.dart';
import '../../cubit/transaction/transaction_cubit.dart';
import '../../cubit/transaction/transaction_state.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/transaction_card.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأرشيف'),
      ),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          final archivedTransactions = state.transactions
              .where((transaction) => transaction.isArchived)
              .toList();

          if (archivedTransactions.isEmpty) {
            return const EmptyState(
              message: 'الأرشيف فارغ',
              icon: Icons.archive_outlined,
            );
          }

          final partners = context.read<PartnerCubit>().state.partners;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: archivedTransactions.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 12);
            },
            itemBuilder: (context, index) {
              final transaction = archivedTransactions[index];

              final partner = partners
                  .where(
                    (partner) => partner.id == transaction.partnerId,
              )
                  .firstOrNull;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (partner != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8,
                        bottom: 6,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 18,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'الشريك: ${partner.name}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                  Row(
                    children: [
                      Expanded(
                        child: TransactionCard(
                          id: transaction.id,
                          amount: transaction.amount,
                          type: transaction.type,
                          date: transaction.date,
                        ),
                      ),

                      const SizedBox(width: 4),

                      IconButton(
                        onPressed: transaction.id == null
                            ? null
                            : () {
                          context
                              .read<TransactionCubit>()
                              .unarchiveTransaction(
                            transaction.id!,
                          );
                        },
                        icon: const Icon(
                          Icons.unarchive_outlined,
                        ),
                        tooltip: 'إلغاء الأرشفة',
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}