import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/transaction_model.dart';
import '../../screens/transactions/add_transaction_screen.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/section_list.dart';
import '../../widgets/transaction_card.dart';
import '../transaction/transaction_cubit.dart';
import '../transaction/transaction_state.dart';

class PartnerDetailsScreen extends StatelessWidget {
  const PartnerDetailsScreen({
    super.key,
    required this.partnerId,
    required this.partnerName,
  });

  final int? partnerId;
  final String partnerName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(partnerName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ما بيننا',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                title: const Text('لك عنده'),
                subtitle: const Text('0 ريال'),
                leading: const Icon(
                  Icons.arrow_downward,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                title: const Text('عليك له'),
                subtitle: const Text('0 ريال'),
                leading: const Icon(
                  Icons.arrow_upward,
                  color: Colors.red,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'التعاملات',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 12),

            Expanded(
              child: BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, state) {
                  final transactions = state.transactions
                      .where(
                        (transaction) =>
                    transaction.partnerId == partnerId &&
                        !transaction.isArchived,
                  )
                      .toList();
                  return SectionList<TransactionModel>(

                    items: transactions,
                    emptyMessage: 'لا توجد تعاملات حتى الآن',
                    emptyIcon: Icons.receipt_long_outlined,
                    itemBuilder: (context, transaction) {
                      return TransactionCard(
                        id: transaction.id,
                        amount: transaction.amount,
                        type: transaction.type,
                        date: transaction.date,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTransactionScreen(
                partnerId: partnerId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('إضافة تعاملة'),
      ),
    );
  }
}