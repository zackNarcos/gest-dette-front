import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:d_liv/screens/auth/login/widgets/email_login_container.dart';
import 'package:d_liv/screens/auth/login/widgets/phone_login_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_event.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AppInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40), // Add this line
                    Text(
                      'Bienvenue',
                      style: TextStyle(
                        color: DLivColors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Veuillez renseigner vos identifiant, Pour vous connecter à votre compte.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),

             Expanded(child: SingleChildScrollView(
               physics: const BouncingScrollPhysics(),
              // padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height * 0.6,
                child: ContainedTabBarView(
                  initialIndex: 1,
                  tabs: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Icon(Icons.phone, size: 28),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Icon(Icons.email_outlined, size: 28),
                    ),
                  ],

                  tabBarProperties:  const TabBarProperties(
                    // width: MediaQuery.of(context).size.width * 0.65,
                    width: 120,
                    indicatorColor: DLivColors.primary,
                    indicatorWeight: 2.0,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: DLivColors.primary,
                    ),
                    unselectedLabelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey
                    ),

                  ),
                  views: const [
                    PhoneLoginContainer(),
                    EmailLoginContainer(),
                  ],
                  onChange: (index) => print(index),
                ),
              ),
            )),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Vous n'avez pas de compte ?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(
                      color: DLivColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}