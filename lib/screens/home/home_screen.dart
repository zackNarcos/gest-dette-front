
import 'package:d_liv/blocs/transactions/transactions_bloc.dart';
import 'package:d_liv/blocs/transactions/transactions_event.dart';
import 'package:d_liv/blocs/transactions/transactions_state.dart';
import 'package:d_liv/models/entity/user_model.dart';
import 'package:d_liv/shared/constants/routes.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:d_liv/widgets/forms/custom_text_field.dart';
import 'package:d_liv/widgets/profils/MePanelContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../widgets/ui/sliding_up_panel_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final PanelController _detailsPanelController = PanelController();
  final PanelController _profilePanelController = PanelController();
  final ValueNotifier<bool> _isProfilePanelVisible = ValueNotifier(false);
  final ValueNotifier<bool> _isProfilePanelOpened = ValueNotifier(true);
  late bool _dette = true;

  final List<User> clients = [
    User(
      surname: 'Jane Doe',
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      phone: '+221 775068721',
      deleted: null,
      isActivate: null,
      lastLogin: '',
      roles: [],
      resetPasswordToken: '',
      resetPasswordExpires: '',
      balance: 0,
      address: '',
    ),
    User(
      surname: 'Jane Doe',
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      phone: '+221 775068721',
      deleted: null,
      isActivate: null,
      lastLogin: '',
      roles: [],
      resetPasswordToken: '',
      resetPasswordExpires: '',
      balance: 0,
      address: '',
    ),
    User(
      surname: 'Jane Doe',
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      phone: '+221 775068721',
      deleted: null,
      isActivate: null,
      lastLogin: '',
      roles: [],
      resetPasswordToken: '',
      resetPasswordExpires: '',
      balance: 0,
      address: '',
    ),
    User(
      surname: 'Jane Doe',
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      phone: '+221 775068721',
      deleted: null,
      isActivate: null,
      lastLogin: '',
      roles: [],
      resetPasswordToken: '',
      resetPasswordExpires: '',
      balance: 0,
      address: '',
    ),
    User(
      surname: 'Jane Doe',
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      phone: '+221 775068721',
      deleted: null,
      isActivate: null,
      lastLogin: '',
      roles: [],
      resetPasswordToken: '',
      resetPasswordExpires: '',
      balance: 0,
      address: '',
    ),
    User(
      surname: 'Jane Doe',
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      phone: '+221 775068721',
      deleted: null,
      isActivate: null,
      lastLogin: '',
      roles: [],
      resetPasswordToken: '',
      resetPasswordExpires: '',
      balance: 0,
      address: '',
    ),
  ];

  @override
  initState() {
    super.initState();
    context.read<TransactionsBloc>().add(const LoadTransactions());
  }

  @override
  void dispose() {
    _isProfilePanelVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  Text(
                    "Gestions de Bons",
                    style: DLivTextStyles.h2,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {  },
                      child: const TextButton(
                        onPressed: null,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Filtrer par',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const CustomTextField(
                    label: 'Rechercher',
                    placeholder: 'Renseigner le nom du client',
                    borderColor: DLivColors.primary,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView(
                      children: [
                        ...clients.map((client) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(client.surname!),
                                subtitle: Text(client.phone!),
                                selectedColor: DLivColors.label,
                                selectedTileColor: DLivColors.primary,
                                focusColor: DLivColors.primary,
                                onTap: () {
                                  context.read<TransactionsBloc>().add(SelectClient(client: client));
                                },
                              ),
                               Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.grey[200],
                                ),
                              )
                            ],
                          );
                        }),
                        // if (_selectedOrder.value != null)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: 16,
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black, size: 30),
                    onPressed: () {
                      toggleMePanelVisibility();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_reaction_outlined, color: Colors.black, size: 30),
                    onPressed: () {
                      gotoMeLocation();
                    },
                  )
                ],
              ),
            ),
          ),
          // Details panel
          SlidingUpPanelWidget(
            panelController: _detailsPanelController,
            content:Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3 + 50 ,
                    width: MediaQuery.of(context).size.width -10 * 2,

                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Ajouter une dette',
                            style: DLivTextStyles.h3,
                          ),
                          const SizedBox(height: 15),
                          // delivery details location
                          Row(
                            children: [
                              Text(
                                'Client',
                                style: DLivTextStyles.h6,
                              ),
                            ],
                          ),
                          Row(
                              children: [
                                Expanded(child: TextButton(
                                    onPressed: () {
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: DLivColors.placeholder),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.adjust_rounded, color: DLivColors.primary),
                                          const SizedBox(width: 10),
                                          BlocBuilder<TransactionsBloc, TransactionsState>(
                                            // buildWhen: (previous, current) => previous.newDelivery?.sourceName != current.newDelivery?.sourceName,
                                              builder: (context, state) {
                                                return Expanded(
                                                  child: Text(
                                                    state.selectedUser?.surname ?? 'Selectionner un client',
                                                    style: DLivTextStyles.body2,
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    )
                                ))
                              ]
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Montant',
                                style: DLivTextStyles.h6,
                              ),
                            ],
                          ),
                          const CustomTextField(
                            label: 'Montant',
                            placeholder: '2,000.0',
                            keyboardType: TextInputType.number,
                          ),
                          Row(
                            children: [
                              Switch(
                                value: _dette,
                                activeColor: DLivColors.primary,
                                inactiveThumbColor: DLivColors.secondary,
                                onChanged: (bool value) {
                                  setState(() {
                                    _dette = value;
                                    _onDetteChanged(value);
                                  });
                                },
                              ),
                              Text(
                                'Decocher si c\'est un payemnts de bons',
                                style: DLivTextStyles.h6,
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          // ACTIONS
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _onSubmited();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(DLivColors.primary),
                                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 14)),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                  ),
                                  child: Text(
                                    'Enregistrer',
                                    style: DLivTextStyles.h4.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            minPanelHeight: 180,
            marginTop: 501,
          ),
          // Profile panel
          SlidingUpPanelWidget(
            panelController: _profilePanelController,
            content: MePanelContent(
              isPanelShow: _isProfilePanelVisible,
            ),
            minPanelHeight: 0,
            marginTop: 30,
            isClosable: true,
          ),
        ],
      ),
    );
  }

  gotoMeLocation() {
    Get.offNamed(Routes.signUpGuest);
  }

  void _onSubmited() {}

  void _onDetteChanged(bool value) {
  }

  void toggleMePanelVisibility() {
    _isProfilePanelVisible.value = !_isProfilePanelVisible.value;
    _isProfilePanelOpened.value = true;
    if (_profilePanelController.isAttached) {
      _isProfilePanelVisible.value ? _profilePanelController.show() : _profilePanelController.hide();
      _isProfilePanelOpened.value ? _profilePanelController.open() : _profilePanelController.close();
    }
  }
}

