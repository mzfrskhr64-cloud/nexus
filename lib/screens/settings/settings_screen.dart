import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../../cubit/theme/theme_cubit.dart';
import '../../cubit/theme/theme_state.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.dark_mode_outlined,
                ),
                title: const Text('المظهر'),
                subtitle: const Text(
                  'تغيير الوضع بين الفاتح والداكن',
                ),
                trailing: BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return Switch(
                      value: state.themeMode == ThemeMode.dark,
                      onChanged: (_) {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.star_outline,
                ),
                title: const Text('تقييم التطبيق'),
                subtitle: const Text(
                  'ساعدنا بتقييم تجربتك مع NEXUS',
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {
                  // سنربطه لاحقًا
                },
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                ),
                title: const Text('تسجيل الخروج'),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('تسجيل الخروج'),
                        content: const Text(
                          'هل أنت متأكد من أنك تريد تسجيل الخروج؟',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('إلغاء'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text('تسجيل الخروج'),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldLogout != true) return;

                  await context.read<AuthCubit>().logout();

                  if (!context.mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                        (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}