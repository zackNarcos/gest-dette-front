import 'package:d_liv/models/repositories/auth/auth_repository.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:d_liv/widgets/forms/custom_text_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';


class ResetPasswordScreen extends StatefulWidget {

  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // error message
  String _passwordError = '';
  String _confirmPasswordError = '';
  String _errorMessage = '';
  bool _isLoading = false;
  late String email;
  late String token;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    email = routeArgs['email']!;
    token = routeArgs['token']!;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _passwordError = '';
      _confirmPasswordError = '';

      // Validation des champs

      // Validation du mdp avec une expression régulière

      if (_passwordController.text.isEmpty) {
        _passwordError = 'Veuillez entrer votre mot de passe';
        return;
      // } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(_passwordController.text)) {
      } else
        // 8 caractères, une lettre, un chiffre et un caractère spécial
        if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$').hasMatch(_passwordController.text)) {
        _errorMessage = 'Le mot de passe doit contenir au moins 8 caractères, une lettre, un chiffre et un caractère spécial';
        return;
      }

      // Validation de la confirmation du mdp
      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = 'Veuillez confirmer votre mot de passe';
        return;
      } else if (_confirmPasswordController.text != _passwordController.text) {
        print('Les mots de passe ne correspondent pas');
        _confirmPasswordError = 'Les mots de passe ne correspondent pas';
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
      final authResponse = await AuthRepository().resetPassword(
        token,
        _passwordController.text,
        email
      ).then((authResponse) {
        // Naviguez vers la page de connexion
        Navigator.pushNamed(context, '/login', arguments: _passwordController.text);
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
          _errorMessage = 'Impossible de réinitialiser le mot de passe';
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
                'Entrez votre email pour réinitialiser votre mot de passe.',
                textAlign: TextAlign.center,
                style: DLivTextStyles.body1g,
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
                           controller: _passwordController,
                           label: 'Nouveau mot de passe',
                           placeholder: 'Entrez votre nouveau mot de passe',
                           obscureText: true,
                           // prefixIcon: const Icon(Icons.lock),
                           errorText: _passwordError.isNotEmpty  ? _passwordError : null,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          label: 'Confirmer le mot de passe',
                          placeholder: 'Confirmer votre mot de passe',
                          obscureText: true,
                          // prefixIcon: const Icon(Icons.lock),
                          errorText: _confirmPasswordError.isNotEmpty  ? _confirmPasswordError : null,
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
                              ?
                              SizedBox(
                                height: 20,
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                              :
                              const Text(
                                'Valider',
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