import 'package:d_liv/models/repositories/auth/auth_repository.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/widgets/forms/custom_text_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';


class ForgotPasswordScreen extends StatefulWidget {

  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  // error message
  String _emailError = '';
  String _errorMessage = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _emailError = '';

      // Validation des champs

      // Validation de l'email avec une expression régulière
      if (_emailController.text.isEmpty) {
        _emailError = 'Veuillez entrer votre email';
        return;
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
        _emailError = 'Veuillez entrer un email valide';
        return;
      }

      _authenticate();
    });
  }

  void _authenticate() async {
    // set loading state
    setState(() {
      _isLoading = true;
    });
    // Authentification
    try {
      final authResponse = await AuthRepository().forgotPassword(
          _emailController.text,
      ).then((authResponse) {
        // Naviguez vers la page de confirmation de token
        Navigator.pushNamed(context, '/auth/confirm-password-token', arguments: _emailController.text);
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
          print('Message d\'erreur brut: $errorMessage');
          _errorMessage = 'Impossible d''envoyer le lien de réinitialisation de mot de passe';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mot de passe oublié"),
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
                      'Réinitialiser votre mot de passe',
                      style: TextStyle(
                        color: DLivColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Text(
                'Entrez votre email, pour réinitialiser votre mot de passe.',
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
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        ElevatedButton(
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
                          child: _isLoading
                              ? SizedBox(
                            height: 20,
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                              : const Text(
                            'Continuer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ]
                  ),
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