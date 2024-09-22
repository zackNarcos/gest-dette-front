import 'package:d_liv/blocs/auth/auth_bloc.dart';
import 'package:d_liv/blocs/auth/auth_event.dart';
import 'package:d_liv/shared/constants/routes.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // _navigateToLogin();
    _checkIfUserIsLoggedIn();
  }

  _checkIfUserIsLoggedIn() {
    context.read<AuthBloc>().add(AppStarted());
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Get.toNamed(Routes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                      // DLivColors.primary,
                      // DLivColors.primary,
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: CircleAvatar(
                  radius: 60,
                  child: Image.asset(
                    'assets/images/logo.jpg',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}