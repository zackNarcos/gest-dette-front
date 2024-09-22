import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../widgets/forms/custom_button.dart';

class ConfirmTokenScreen extends StatefulWidget {

  const ConfirmTokenScreen({super.key});

  @override
  _ConfirmTokenScreenState createState() => _ConfirmTokenScreenState();
}

class _ConfirmTokenScreenState extends State<ConfirmTokenScreen> {
  final TextEditingController _codeController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _codeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: DLivColors.border),
    ),
  );

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = DLivColors.primary;
    const fillColor = Colors.transparent;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 40),
                      const Text(
                        'Vérification',
                        style: TextStyle(
                          color: DLivColors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Entrez le code envoyé sur votre numéro, ',
                              style: DLivTextStyles.body1g,
                            ),
                          ]
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Pinput(
                    controller: _codeController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    validator: (value) {
                      return value == '2222' ? null : 'Code de vérification invalide';
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Connexion',
                filled: true,
                fillColor: DLivColors.primary,
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    // await context.read<AuthService>().login(
                    //   _phoneController.text,
                    //   _passwordController.text,
                    // );
                    Navigator.pushReplacementNamed(context, '/delivery');
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Vous n'avez pas recu de code ?"),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Renvoyer le code",
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
      ),
    );
  }
}