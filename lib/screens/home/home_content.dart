import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../cubit/transaction/transaction_cubit.dart';
import '../../cubit/transaction/transaction_state.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/summary_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: const BoxDecoration(),
          child: BlocBuilder<TransactionCubit, TransactionState>(
            builder: (context, state) {
              double receivable = 0;
              double payable = 0;

              for (final transaction in state.transactions) {
                if (transaction.isArchived) {
                  continue;
                }

                switch (transaction.type) {
                  case 'sale':
                    receivable += transaction.amount;
                    break;

                  case 'purchase':
                    payable += transaction.amount;
                    break;

                  case 'paymentReceived':
                    receivable -= transaction.amount;
                    break;

                  case 'paymentMade':
                    payable -= transaction.amount;
                    break;
                }
              }

              final netBalance = receivable - payable;

              return Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'مرحبًا أحمد 👋',

                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                          fontWeight: FontWeight.bold,
                          backgroundColor: Color(0xFFF4F0F0)
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'إليك ملخص تعاملاتك',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(18),
                      // margin: EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF224681)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,

                      children: [


                                      //
                        BalanceCard(
                          balance: netBalance,
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: SummaryCard(
                                title: 'لك عندهم',
                                amount: receivable,
                                icon: Icons.arrow_downward,
                                color: AppColors.positive,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: SummaryCard(
                                title: 'عليك لهم',
                                amount: payable,
                                icon: Icons.arrow_upward,
                                color: AppColors.negative,
                              ),
                            ),
                          ],
                        ),
                      ],),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}