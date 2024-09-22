import 'package:d_liv/blocs/auth/auth_bloc.dart';
import 'package:d_liv/blocs/auth/auth_event.dart';
import 'package:d_liv/blocs/auth/auth_state.dart';
import 'package:d_liv/shared/constants/routes.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/widgets/forms/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/forms/custom_button.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({super.key});

  @override
  _MeScreenState createState() => _MeScreenState();

}

class _MeScreenState extends State<MeScreen> {

  //TODO:: add edi password
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  late bool isLastNameEditing = false;

  late String errorMesssage = '';
  final bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _firstNameController.text = context.read<AuthBloc>().state.user?.firstName ?? '';
    _lastNameController.text = context.read<AuthBloc>().state.user?.lastName ?? '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading,
                    builder: (context, state) {
                      if (state.isLoading) {
                        // EasyLoading.showToast('Enregistrement en cours...');
                        EasyLoading.show();
                      } else {
                        EasyLoading.dismiss();
                      }
                      return const SizedBox();
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${state.user?.firstName} ${state.user?.lastName}',
                    style: const TextStyle(
                      // color: DLivColors.label,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // email
                ListTile(
                  title: Text(
                    state.user?.email ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: const Text(
                    'Email',
                    style: TextStyle(
                      color: DLivColors.label,
                      fontSize: 16,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {
                    Get.toNamed(Routes.editEmail);
                  },
                ),
                // phone
                ListTile(
                  title: Text(
                    state.user?.phone ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: const Text(
                    'Téléphone',
                    style: TextStyle(
                      color: DLivColors.label,
                      fontSize: 16,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {
                    Get.toNamed(Routes.editPhone);
                  },
                ),
                // firstName
                ListTile(
                  title: Text(
                    state.user?.firstName ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: const Text(
                    'Nom',
                    style: TextStyle(
                      color: DLivColors.label,
                      fontSize: 16,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {
                    isLastNameEditing = false;
                    _onEditUser();
                  },
                ),
                // lastName
                ListTile(
                  title: Text(
                    state.user?.lastName ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: const Text(
                    'Prénom',
                    style: TextStyle(
                      color: DLivColors.label,
                      fontSize: 16,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {
                    isLastNameEditing = true;
                    _onEditUser();
                  },
                ),
                ListTile(
                  title: Text(
                    'Mot de passe',
                    style: const TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.editPassword);
                  },
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: 'Se déconnecter',
                    fillColor: DLivColors.primary,
                    textColor: Colors.white,
                    onPressed: () {
                      context.read<AuthBloc>().add(ResetState());
                    },
                  ),
                ),
              ],
            );
          }),
      ),
    );
  }

  void _onEditUser() {
    _lastNameController.text = context
        .read<AuthBloc>()
        .state
        .user
        ?.lastName ?? '';
    _firstNameController.text = context
        .read<AuthBloc>()
        .state
        .user
        ?.firstName ?? '';

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            child: SafeArea(
                child: Wrap(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(20),
                          // rounded top
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextField(
                                  controller: isLastNameEditing
                                      ? _lastNameController
                                      : _firstNameController,
                                  errorText: errorMesssage != ''
                                      ? errorMesssage
                                      : null,
                                  label: isLastNameEditing ? 'Prénom' : 'Nom',
                                  placeholder: isLastNameEditing
                                      ? 'Renseignez votre prénom'
                                      : 'Renseignez votre nom',
                                  maxLength: 50,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        text: 'Annuler',
                                        fillColor: DLivColors.secondary,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomButton(
                                          text: 'Enregistrer',
                                          fillColor: DLivColors.primary,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            //check if the fields are edited
                                            if (
                                              _firstNameController.text.trim() == context
                                                .read<AuthBloc>().state.user?.firstName &&
                                              _lastNameController.text.trim() == context
                                                .read<AuthBloc>().state.user?.lastName
                                            ) {
                                              Navigator.pop(context);
                                              return;
                                            }


                                            if (_firstNameController.text.trim().isEmpty ||
                                                _lastNameController.text.trim().isEmpty) {
                                              EasyLoading.showError('Le prénom et le nom ne doivent pas être vides.');
                                              return;
                                            }

                                            // Vérification avec regex pour n'accepter que les lettres alphabétiques + espace
                                            RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]*$');

                                            if(_firstNameController.text.trim().length < 2 || _lastNameController.text.trim().length < 2) {
                                              EasyLoading.showError('Le prénom et le nom doivent contenir au moins 2 caractères.');
                                              return;
                                            }

                                            if (!nameRegExp.hasMatch(_firstNameController.text.trim())) {
                                              EasyLoading.showError('Le nom ne doit contenir que des lettres.');
                                              return;
                                            }

                                            if (!nameRegExp.hasMatch(_lastNameController.text.trim())) {
                                              EasyLoading.showError('Le prénom ne doit contenir que des lettres.');
                                              return;
                                            }
                                            context.read<AuthBloc>().add(
                                                UpdateUser(
                                                  firstName: _firstNameController
                                                      .text.trim(),
                                                  lastName: _lastNameController
                                                      .text.trim(),
                                                )
                                            );
                                            Navigator.pop(context);
                                          }
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                          )
                      )
                    ]
                )
            ),
          );
        });
  }
}