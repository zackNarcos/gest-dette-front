import 'dart:convert';

import 'package:d_liv/models/repositories/auth/auth_repository.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../blocs/auth/auth_event.dart';
import '../../../../blocs/auth/auth_state.dart';
import '../../../../widgets/forms/custom_button.dart';
import '../../../../widgets/forms/custom_text_field.dart';

class EmailLoginContainer extends StatefulWidget {
  const EmailLoginContainer({super.key});

  @override
  _EmailLoginContainerState createState() => _EmailLoginContainerState();
}

class _EmailLoginContainerState extends State<EmailLoginContainer> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // error message
  String _emailError = '';
  String _passwordError = '';

  @override
  void initState() {
    super.initState();
    // _emailController.setText('zackabess@gmail.com');
    _emailController.setText('zackabess95@gmail.com');
    // _passwordController.setText('Zackariabessolo2@');
    _passwordController.setText('Stro@ngPass123');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _emailError = '';
      _passwordError = '';

      // Validation des champs

      // Validation de l'email avec une expression régulière
      if (_emailController.text.isEmpty) {
        _emailError = 'Veuillez entrer votre email';
        return;
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
        _emailError = 'Veuillez entrer un email valide';
        return;
      }

      // Validation du mot de passe
      if (_passwordController.text.isEmpty) {
        _passwordError = 'Veuillez entrer votre mot de passe';
        return;
      } else if (_passwordController.text.length < 6) {
        _passwordError = 'Le mot de passe doit contenir au moins 6 caractères';
        return;
      }

      _authenticate();
    });
  }


  void _authenticate() async {
    // Authentification
    context.read<AuthBloc>().add(
      LoginEmail(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Afficher le message d'erreur global
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.error != null && state.error!.isNotEmpty
                    ? Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.red[400],
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            heightFactor: 1,
                            child: Text(
                              state.error!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 20),
            CustomTextField(
              controller: _emailController,
              label: 'Email',
              placeholder: 'Email',
              prefixIcon: const Icon(Icons.email),
              keyboardType: TextInputType.emailAddress,
              errorText: _emailError.isNotEmpty  ? _emailError : null,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _passwordController,
              label: 'Mot de passe',
              placeholder: 'Mot de passe',
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
              errorText: _passwordError.isNotEmpty  ? _passwordError : null,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Naviguez vers la page de récupération de mot de passe
                  Navigator.pushNamed(context, '/auth/forgot-password');
                },
                child: const Text(
                  'Mot de passe oublié ?',
                  style: TextStyle(
                    color: DLivColors.primary,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.isLoading
                    ? ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            DLivColors.primary.withOpacity(0.8),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 0,
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 50),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          height: 20,
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            DLivColors.primary,
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 0,
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 50),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Se connecter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                    );
              },
            ),
          ]
        ),
      ),
    );
  }
}