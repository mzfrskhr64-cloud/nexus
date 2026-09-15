import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/screens/login/login_screen.dart';
// import 'package:nexus/cubit/auth/auth_cubit.dart';
import 'package:nexus/screens/splash/splash_screen.dart';
import 'core/theme_core/dark_theme.dart';
import 'core/theme_core/light_theme.dart';
import 'cubit/partner/partner_cubit.dart';
import 'cubit/theme/theme_cubit.dart';
import 'cubit/theme/theme_state.dart';
import 'cubit/transaction/transaction_cubit.dart';
import 'services/shared_preferences_service.dart';
import 'cubit/auth/auth_cubit.dart' ;
void main() {
  final preferencesService = SharedPreferencesService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          ThemeCubit(preferencesService)..loadTheme(),
        ),

        BlocProvider(
          create: (context) =>
              AuthCubit(preferencesService),
        ),
        BlocProvider(
          create: (context) => PartnerCubit(),
        ),
        BlocProvider(
          create: (context) => TransactionCubit(),
        ),
      ],
      child: const NexusApp(),
    ),
  );
}

class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(

          locale: const Locale('ar'),
          debugShowCheckedModeBanner: false,

          theme: LightTheme.theme,
          darkTheme: DarkTheme.theme,
          themeMode: state.themeMode,

          home: const  SplashScreen(),
        );
      },
    );
  }
}