import 'package:d_liv/blocs/auth/auth_bloc.dart';
import 'package:d_liv/blocs/auth/auth_event.dart';
import 'package:d_liv/blocs/auth/auth_state.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/widgets/forms/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/forms/custom_button.dart';

class EditPhoneScreen extends StatefulWidget {
  const EditPhoneScreen({super.key});

  @override
  _EditPhoneScreenState createState() => _EditPhoneScreenState();

}

class _EditPhoneScreenState extends State<EditPhoneScreen> {

  //TODO:: add edi password
  final TextEditingController _phoneController = TextEditingController();

  late String errorMesssage = '';
  final bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _phoneController.text = context.read<AuthBloc>().state.user?.phone ?? '';
    // _phoneController.text = '+12647750687';
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading,
                    builder: (context, state) {
                      if (state.isLoading) {
                        EasyLoading.show();
                      } else {
                        EasyLoading.dismiss();
                      }
                      return const SizedBox();
                    }),
                const Text(
                  'Ce numéro de téléphone sera utilisé pour assurer le suivi de vos commandes, recevoir des notifications et plus encore.',
                ),
                const SizedBox(height: 20),
                if (errorMesssage.isNotEmpty)
                  Text(
                    errorMesssage,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                // phone
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
                  initialValue: _phoneController.text,
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
                    _phoneController.text = phone.number;
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country  changed to: ' + country.name);
                  },
                ),

                // Expanded(child: Container()),
                const SizedBox(height: 20),
                if(_phoneController.text != state.user?.phone)
                CustomButton(
                    text: 'Vérifier',
                    fillColor: DLivColors.primary,
                    textColor: Colors.white,
                    onPressed: _onEditPhone
                ),
              ],
            );
          }),
      ),
    );
  }

  void _onEditPhone() {

  }
}