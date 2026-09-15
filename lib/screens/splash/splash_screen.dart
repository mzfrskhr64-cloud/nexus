import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexus/cubit/auth/auth_cubit.dart';
import 'package:nexus/cubit/auth/auth_state.dart';

import '../home/home_screen.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<AuthCubit>().checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          return;
        }

        if (state.isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:(_)=> const HomeScreen(),
            ),
          );

        } else {
          // لاحقًا → LoginScreen
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        ),
        );

        }

        if(state.errorMessage!=null){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage!)));
        }
      },
      child: const Scaffold(
        body: Center(
          child: Text('NEXUS'),
        ),
      ),
    );
  }
}