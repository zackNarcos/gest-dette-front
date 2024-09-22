import 'dart:ffi';

import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:d_liv/widgets/forms/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../models/entity/transaction_model.dart';

class DetailOrderPanelContent extends StatefulWidget {
  final ValueNotifier<Transaction> transaction;
  final ValueNotifier<bool> isPanelOpened;

  const DetailOrderPanelContent({
    required this.transaction,
    required this.isPanelOpened,
    super.key
  });

  @override
  _DetailOrderPanelContentState createState() => _DetailOrderPanelContentState();
}

class _DetailOrderPanelContentState extends State<DetailOrderPanelContent> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // delivery details location
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Prise en charge
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Prise en charge',
                              style: DLivTextStyles.h6,
                            ),
                          ],
                        ),
                        Row(
                            children: [
                              Expanded(child: TextButton(
                                  onPressed: null,
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
                                        const Icon(Icons.adjust_rounded),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Position actuelle',
                                          style: DLivTextStyles.body2g,
                                        ),
                                      ],
                                    ),
                                  )
                              ))
                            ]
                        )
                      ],
                    ),
                    // Destination
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Destination',
                              style: DLivTextStyles.h6,
                            ),
                          ],
                        ),
                        Row(
                            children: [
                              Expanded(child: TextButton(
                                  onPressed: null,
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
                                        const Icon(Icons.location_on_rounded),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Ex: 123 rue de la paix, Paris, France',
                                          style: DLivTextStyles.body2g,
                                        ),
                                      ],
                                    ),
                                  )
                              ))
                            ]
                        )
                      ],
                    ),
                  ],
                ),
              )
          ),

          // Delivery details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                      'Ajouter des détails',
                      style: TextStyle(
                        color: DLivColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationColor: DLivColors.primary,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationThickness: 1.2,
                      )
                  ),
                ),
              ],
            ),
          ),

          // Destinataire details
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Prise en charge
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Details du destinataire',
                              style: DLivTextStyles.h4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                            children: [
                              CustomTextField(
                                label: 'Nom complet',
                                prefixIcon: Icon(Icons.person),
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                label: 'Téléphone',
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ],
                ),
              )
          ),

          // ACTIONS
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const Divider(color: DLivColors.muted),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            color: DLivColors.primary,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Total:',
                            style: DLivTextStyles.h2,
                          ),
                        ],
                      ),


                      const Spacer(),
                      Text(
                        '€ 0.00',
                        style: DLivTextStyles.h2,
                      ),
                    ]
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ));
  }
}

