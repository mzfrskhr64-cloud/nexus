import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/core/constants/app_colors.dart';

import 'package:nexus/core/constants/tool.dart';

import '../../cubit/transaction/transaction_cubit.dart';
import '../../models/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({
    super.key,
    required this.partnerId,
  });

  final int? partnerId;

  @override
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState
    extends State<AddTransactionScreen> {
  final amountController = TextEditingController();
  final notesController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String transactionType = 'sale';

  @override
  void dispose() {
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة تعاملة'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: transactionType,
                  decoration: const InputDecoration(
                    labelText: 'نوع التعاملة',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'sale',
                      child: Text('بيع'),
                    ),
                    DropdownMenuItem(
                      value: 'purchase',
                      child: Text('شراء'),
                    ),
                    DropdownMenuItem(
                      value: 'paymentReceived',
                      child: Text('دفعة مستلمة'),
                    ),
                    DropdownMenuItem(
                      value: 'paymentMade',
                      child: Text('دفعة مدفوعة'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        transactionType = value;
                      });
                    }
                  },
                ),

                verticalSpace(16),

                defaultTextField(
                  controller: amountController,
                  label: 'المبلغ',
                  prefixIcon: Icons.payments_outlined,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'أدخل المبلغ';
                    }

                    if (double.tryParse(value) == null) {
                      return 'أدخل مبلغًا صحيحًا';
                    }

                    if (double.parse(value) <= 0) {
                      return 'يجب أن يكون المبلغ أكبر من صفر';
                    }

                    return null;
                  },
                ),

                verticalSpace(16),

                defaultTextField(
                  controller: notesController,
                  label: 'ملاحظات',
                  prefixIcon: Icons.notes_outlined,
                ),

                verticalSpace(24),

                defaultButton(
                  backgroundColor: AppColors.primary,
                  text: 'حفظ التعاملة',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final transaction = TransactionModel(
                          partnerId: widget.partnerId ?? 0,
                          amount: double.parse(amountController.text.trim()),
                          type: transactionType,
                          date: DateTime.now(),
                          notes: notesController.text.trim().isEmpty
                              ? null
                              : notesController.text.trim(),
                        );

                        context.read<TransactionCubit>().addTransaction(
                          transaction,
                        );

                        Navigator.pop(context);
                      }

                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}