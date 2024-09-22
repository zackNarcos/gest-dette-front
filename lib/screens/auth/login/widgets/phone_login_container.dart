import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../widgets/forms/custom_button.dart';
import '../../../../widgets/forms/custom_text_field.dart';

class PhoneLoginContainer extends StatefulWidget {
  const PhoneLoginContainer({Key? key}) : super(key: key);

  @override
  _PhoneLoginContainerState createState() => _PhoneLoginContainerState();
}

class _PhoneLoginContainerState extends State<PhoneLoginContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          const SizedBox(height: 8),
          CustomButton(
            text: 'Suivant',
            filled: true,
            fillColor: DLivColors.primary,
            textColor: Colors.white,
            onPressed: () async {
              try {
                // await context.read<AuthService>().login(
                //   _phoneController.text,
                //   _passwordController.text,
                // );
                Navigator.pushNamed(context, '/auth/confirm-token');
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Erreur de connexion'),
                    content: Text(e.toString()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ]
      ),
    );
  }
}