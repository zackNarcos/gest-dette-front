import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/repositories/auth/auth_repository.dart';
import '../../widgets/forms/custom_text_field.dart';
import '../../widgets/forms/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fisrtnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inscription"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              const Text(
                'Créer un compte',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: DLivColors.primary
                ),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 15),
              // firstname
              const Text(
                'Nom',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                controller: _fisrtnameController,
                placeholder: 'Nom',
              ),

              const SizedBox(height: 15),
              // lastname
              const Text(
                'Prénom',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                controller: _lastnameController,
                placeholder: 'Prénom',
              ),

              const SizedBox(height: 15),
              // email
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                controller: _emailController,
                placeholder: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 15),
              //password
              const Text(
                'Mot de passe',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                controller: _passwordController,
                placeholder: 'Mot de passe',
                obscureText: true,
              ),

              //confirm password
              const SizedBox(height: 15),
              const Text(
                'Confirmer le mot de passe',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                controller: _confirmPasswordController,
                placeholder: 'Confirmer le mot de passe',
                obscureText: true,
              ),


              const SizedBox(height: 20),
              const Expanded(child: SizedBox()),
              CustomButton(
                text: "Suivant",
                filled: true,
                fillColor: DLivColors.primary,
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    // await context.read<AuthService>().signup(
                    //   _emailController.text,
                    //   _passwordController.text,
                    // );
                    // Naviguez vers la page de connexion ou autre après l'inscription réussie
                    Navigator.pushNamed(context, '/auth/signup-phone');
                  } catch (e) {
                    // Affichez un message d'erreur
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Row(
                  children: [
                    Text('Déjà un compte? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text('Se connecter',
                      style: TextStyle(
                        color: DLivColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          )
        ),
      ),
    );
  }
}