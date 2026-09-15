import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexus/cubit/partner/partner_cubit.dart';
import 'package:nexus/cubit/partner/partner_details_screen.dart';
import 'package:nexus/cubit/partner/partner_state.dart';
import 'package:nexus/cubit/transaction/transaction_cubit.dart';
import 'package:nexus/cubit/transaction/transaction_state.dart';
import 'package:nexus/models/partner_model.dart';
import 'package:nexus/widgets/partner_card.dart';
import 'package:nexus/widgets/section_list.dart';

import 'add_partner_screen.dart';

class PartnersScreen extends StatelessWidget {
  const PartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الشركاء'),
      ),
      body: BlocBuilder<PartnerCubit, PartnerState>(
        builder: (context, partnerState) {
          return BlocBuilder<TransactionCubit, TransactionState>(
            builder: (context, transactionState) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SectionList<PartnerModel>(
                  items: partnerState.partners,
                  emptyMessage: 'لا يوجد شركاء حتى الآن',
                  emptyIcon: Icons.people_outline,
                  itemBuilder: (context, partner) {
                    double balance = 0;

                    for (final transaction
                    in transactionState.transactions) {
                      if (transaction.partnerId != partner.id) {
                        continue;
                      }

                      if (transaction.isArchived) {
                        continue;
                      }

                      switch (transaction.type) {
                        case 'sale':
                          balance += transaction.amount;
                          break;

                        case 'purchase':
                          balance -= transaction.amount;
                          break;

                        case 'paymentReceived':
                          balance -= transaction.amount;
                          break;

                        case 'paymentMade':
                          balance += transaction.amount;
                          break;
                      }
                    }

                    return PartnerCard(
                      name: partner.name,
                      balance: balance,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PartnerDetailsScreen(
                              partnerId: partner.id,
                              partnerName: partner.name,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddPartnerScreen(),
            ),
          );
        },
        icon: const Icon(Icons.person_add_outlined),
        label: const Text('إضافة شريك'),
      ),
    );
  }
}