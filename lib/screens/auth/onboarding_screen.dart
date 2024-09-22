import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:flutter/material.dart';
import '../../widgets/forms/custom_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 50),
              decoration: const BoxDecoration(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(30),
                //   topRight: Radius.circular(30),
                // ),
                color: Colors.white,
              ),
              // height: MediaQuery.of(context).size.height * 0.8,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: CircleAvatar(
                      radius: 60,
                      child: Image.asset(
                        'assets/images/logo.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Envoyez vos colis en toute sécurité, rapidement et à moindre coût',
                    textAlign: TextAlign.center,
                    style: DLivTextStyles.body1,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'S\'inscrire',
                    filled: true,
                    fillColor: DLivColors.primary,
                    textColor: Colors.white,
                    onPressed: () async {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Se connecter',
                    filled: true,
                    fillColor: DLivColors.secondary,
                    textColor: Colors.white,
                    onPressed: () async {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ],
        ),
    );
  }
}