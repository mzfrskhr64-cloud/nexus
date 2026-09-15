
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/core/constants/app_colors.dart';
import 'package:nexus/core/constants/tool.dart';
import 'package:nexus/cubit/auth/auth_cubit.dart';
import 'package:nexus/cubit/auth/auth_state.dart';

import '../home/home_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
@override
void dispose() {
emailController.dispose();
passwordController.dispose();

super.dispose();
}
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener:(context, state){
          if(state.isLoading){
            return;
          }
          if (state.isLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
            );
          }
          if(state.errorMessage != null){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                ),);
          }
        },
      child:Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text(
                  'NEXUS',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 32),
                Form(
                    key: formKey,
                  child: Column(
                    children: [
                      defaultTextField(
                        controller: emailController,
                        label: 'البريد الإلكتروني',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'أدخل البريد الإلكتروني';
                          }

                          return null;
                        },
                      ),

                      verticalSpace(16),

                      defaultTextField(
                        controller: passwordController,
                        label: 'كلمة المرور',
                        prefixIcon: Icons.lock_outline,
                        obscureText: !isPasswordVisible,
                        suffixIcon: isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onSuffixPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },

                        validator: (value){
                          if(value==null||value.isEmpty){
                            return 'ادخل كمة المرور';
                          }
                          return null;
                        },
                      ),

                    ],
                  ),

                ),



                const SizedBox(height: 24),

                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return defaultButton(
                      text: state.isLoading
                          ? 'جارٍ تسجيل الدخول...'
                          : 'تسجيل الدخول',
                      backgroundColor: AppColors.primary,
                      onPressed: state.isLoading
                          ? () {}
                          : () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                    );
                  },
                ),



              ],
            ),
          ),
        ),
      )
        );
  }
}