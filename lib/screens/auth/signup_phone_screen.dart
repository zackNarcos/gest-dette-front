import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../widgets/forms/custom_button.dart';

class SignupPhoneScreen extends StatefulWidget {

  const SignupPhoneScreen({super.key});

  @override
  _SignupPhoneScreenState createState() => _SignupPhoneScreenState();
}

class _SignupPhoneScreenState extends State<SignupPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dialController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    _phoneController.dispose();
    _dialController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dialController.text = '+33';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40), // Add this line
                    Text(
                      'Vérification du numéro',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Veuillez renseigner le code reçu par SMS',
                        style: DLivTextStyles.body1g,
                      ),
                      Text(
                        'Pour vous connecter à votre compte.',
                        style: DLivTextStyles.body1g,
                      ),
                    ]
                ),
              ],
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  IntlPhoneField(
                    // focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: 'Numéro de téléphone',
                      labelStyle: const TextStyle(
                        color: DLivColors.label,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: DLivColors.label,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: DLivColors.label),
                        borderRadius: BorderRadius.circular(16.0),
                      )
                    ),
                    controller: _phoneController,
                    initialCountryCode: 'FR',
                    languageCode: "fr",
                    invalidNumberMessage: 'Numéro invalide',
                    searchText: 'Rechercher',
                    pickerDialogStyle: PickerDialogStyle(
                      backgroundColor: Colors.white,
                      listTilePadding: const EdgeInsets.all(0),
                      listTileDivider: const Divider(
                          color: DLivColors.muted,
                          height: 1,
                          thickness: 1
                      ),
                      searchFieldCursorColor: DLivColors.primary,
                      searchFieldInputDecoration: const InputDecoration(
                        hintText: 'Rechercher',
                        hintStyle: TextStyle(
                          color: DLivColors.label,
                        ),
                        //border only bottom
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: DLivColors.label),
                        ),
                      ),
                    ),
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                  ),
                ],
              ),
            ),
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
                  Navigator.pushNamed(context, '/auth/confirm-token');
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
        ),
      ),
    );
  }
}