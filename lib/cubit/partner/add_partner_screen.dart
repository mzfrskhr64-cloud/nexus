import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/core/constants/app_colors.dart';

import 'package:nexus/core/constants/tool.dart';
import 'package:nexus/cubit/partner/partner_cubit.dart';

import '../../models/partner_model.dart';

class AddPartnerScreen extends StatefulWidget {
  const AddPartnerScreen({super.key});

  @override
  State<AddPartnerScreen> createState() => _AddPartnerScreenState();
}

class _AddPartnerScreenState extends State<AddPartnerScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final notesController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    companyController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة شريك'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 6,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                defaultTextField(
                  controller: nameController,
                  label: 'اسم الشريك',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'أدخل اسم الشريك';
                    }
                    return null;
                  },
                ),

                verticalSpace(16),

                defaultTextField(
                  controller: phoneController,
                  label: 'رقم الهاتف',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                verticalSpace(16),

                defaultTextField(
                  controller: companyController,
                  label: 'اسم الشركة',
                  prefixIcon: Icons.business_outlined,
                ),

                verticalSpace(16),

                defaultTextField(
                  controller: notesController,
                  label: 'ملاحظات',
                  prefixIcon: Icons.notes_outlined,
                ),

                verticalSpace(24),

                defaultButton(
                  text: 'حفظ الشريك',
                  backgroundColor: AppColors.primary,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final partner = PartnerModel(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        companyName: companyController.text.trim().isEmpty
                            ? null
                            : companyController.text.trim(),
                        notes: notesController.text.trim().isEmpty
                            ? null
                            : notesController.text.trim(),
                      );

                      context.read<PartnerCubit>().addPartner(partner);

                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}