import 'dart:async';

import 'package:d_liv/models/repositories/auth/auth_repository.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class ConfirmPasswordTokenScreen extends StatefulWidget {

  const ConfirmPasswordTokenScreen({super.key});


  @override
  _ConfirmPasswordTokenScreenState createState() => _ConfirmPasswordTokenScreenState();
}

class _ConfirmPasswordTokenScreenState extends State<ConfirmPasswordTokenScreen> {
  final TextEditingController _codeController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late GlobalKey<FormState> formKey;
  bool _isLoading = false;
  String _errorMessage = '';
  late String email;
  int _resendTokenTimeCount = 0;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Récupération de l'email via ModalRoute.of(context)
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    email = args ?? '';
  }

  @override
  void dispose() {
    _codeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _sendNewToken() async {
    //reset error message
    _errorMessage = '';
    // reset controller
    _codeController.clear();
    _resendTokenTimeCount = 60;
    //start interval
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTokenTimeCount == 0) {
        timer.cancel();
      } else {
        setState(() {
          _resendTokenTimeCount--;
        });
      }
    });
    await AuthRepository().forgotPassword(
      email
    ).catchError((error) {
      // Convertir l'erreur en chaîne de caractères
      String errorMessage = error.toString();

      // Utiliser une expression régulière pour extraire le message d'erreur JSON
      RegExp regExp = RegExp(r'"message":"([^"]+)"');
      Match? match = regExp.firstMatch(errorMessage);

      if (match != null) {
        // Extraire le message d'erreur
        String extractedMessage = match.group(1) ?? 'Erreur inconnue';
        print('Message d\'erreur extrait: $extractedMessage');
        _errorMessage = extractedMessage;
        // Afficher le message d'erreur à l'utilisateur
      } else {
        print('Message d\'erreur brut: $errorMessage');
        _errorMessage = 'Impossible d''envoyer le lien de réinitialisation de mot de passe';
        // Si aucune correspondance n'est trouvée, afficher le message d'erreur brut
      }
    });

    // Désactiver l'état de chargement
    setState(() {
      _isLoading = false;
    });
  }



  void _verifyToken() async {
    // set loading state
    setState(() {
      _isLoading = true;
    });

    try {
      final verifyResponse = await AuthRepository().verifyPasswordResetToken(
        email,
        _codeController.text,
      ).then((authResponse) {
        // Naviguez vers la page de réinitialisation du mot de passe
        Navigator.pushNamed(
            context, '/auth/reset-password',
            // get email and token
            arguments: {
              'email': email,
              'token': _codeController.text,
            });
      }).catchError((error) {
        // Convertir l'erreur en chaîne de caractères
        String errorMessage = error.toString();

        // Utiliser une expression régulière pour extraire le message d'erreur JSON
        RegExp regExp = RegExp(r'"message":"([^"]+)"');
        Match? match = regExp.firstMatch(errorMessage);

        if (match != null) {
          // Extraire le message d'erreur
          String extractedMessage = match.group(1) ?? 'Erreur inconnue';
          print('Message d\'erreur extrait: $extractedMessage');
          _errorMessage = extractedMessage;
          // Afficher le message d'erreur à l'utilisateur
        } else {
          _errorMessage = 'Code invalide ou expiré';
          // Si aucune correspondance n'est trouvée, afficher le message d'erreur brut
        }
      });

      // Désactiver l'état de chargement
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      // Convertir l'erreur en chaîne de caractères
      String errorMessage = error.toString();

      // Utiliser une expression régulière pour extraire le message d'erreur JSON
      RegExp regExp = RegExp(r'"message":"([^"]+)"');
      Match? match = regExp.firstMatch(errorMessage);

      if (match != null) {
        // Extraire le message d'erreur
        String extractedMessage = match.group(1) ?? 'Erreur inconnue';
        print('Message d\'erreur extrait: $extractedMessage');
        _errorMessage = extractedMessage;

        // Afficher le message d'erreur à l'utilisateur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(extractedMessage)),
        );
      } else {
        _errorMessage = errorMessage;
      }
      // Désactiver l'état de chargement
      setState(() {
        _isLoading = false;
      });
    }
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
        title: const Text("Réinitialisation du mot de passe"),
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
                              'Entrez le code envoyé sur votre mail, ',
                              style: DLivTextStyles.body1g,
                            ),
                          ]
                      ),
                    ],
                  ),
                ],
              ),
              // Afficher le message d'erreur global
              if (_errorMessage.isNotEmpty)
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.red[400],
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            heightFactor: 1,
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
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
                      return null;
                      // return value == '2222' ? null : 'Code de vérification invalide';
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
              ElevatedButton(
                onPressed: _verifyToken,
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
                child: _isLoading
                  ? SizedBox(
                      height: 20,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  : const Text(
                    'Valider',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Vous n'avez pas recu de code ?"),
                  TextButton(
                    onPressed: _sendNewToken,
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
              if (_resendTokenTimeCount > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Renvoyer le code dans "),
                    Text(
                      '$_resendTokenTimeCount secondes',
                      style: const TextStyle(
                        color: DLivColors.primary,
                        fontSize: 16,
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