import 'package:d_liv/blocs/auth/auth_bloc.dart';
import 'package:d_liv/blocs/auth/auth_event.dart';
import 'package:d_liv/models/entity/user_model.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/forms/custom_text_field.dart';
import '../../widgets/forms/custom_button.dart';

class SignUpGuestScreen extends StatefulWidget {
  const SignUpGuestScreen({super.key});

  @override
  SignUpGuestScreenState createState() => SignUpGuestScreenState();
}

class SignUpGuestScreenState extends State<SignUpGuestScreen> {
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _surnameController.text = 'zackabess';
    _addressController.text = 'Point E';
    _phoneController.text = '+221 775068721';
    _balanceController.text = '0';
  }

  @override
  void dispose() {
    _surnameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un client"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              'Surnom',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextField(
              controller: _surnameController,
              placeholder: 'Surnom',
            ),

            const SizedBox(height: 15),
            // lastname
            const Text(
              'Adresse',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextField(
              controller: _addressController,
              placeholder: 'Adresse',
            ),

            const SizedBox(height: 15),
            // email
            const Text(
              'Telephone',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextField(
              controller: _phoneController,
              placeholder: 'Telephone',
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 15),
            //password
            const Text(
              'Solde du compte',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextField(
              controller: _balanceController,
              placeholder: 'Solde du compte',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "Enregistrer",
              filled: true,
              fillColor: DLivColors.primary,
              textColor: Colors.white,
              onPressed: () {
                late User client = User(
                    surname: _surnameController.text,
                    address: _surnameController.text,
                    balance: int.tryParse(_surnameController.text),
                    phone: _phoneController.text
                );
                context.read<AuthBloc>().add(
                  SignUpGuest(guest: client)
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}