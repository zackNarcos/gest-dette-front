import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:d_liv/widgets/forms/custom_button.dart';
import 'package:d_liv/widgets/forms/custom_text_button.dart';
import 'package:d_liv/widgets/profils/Info_section.dart';
import 'package:d_liv/widgets/profils/annexe_section.dart';
import 'package:flutter/material.dart';

class MePanelContent extends StatefulWidget {
  final ValueNotifier<bool> isPanelShow;
  const MePanelContent({
    required this.isPanelShow,
    super.key
  });

  @override
  _MePanelContentState createState() => _MePanelContentState();
}

class _MePanelContentState extends State<MePanelContent> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(
          children: <Widget>[
            CustomTextButton(
                content: const InfoSection(),
                onPressed: () {
                  Navigator.of(context).pushNamed('/profile');
                }
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              color: DLivColors.muted,
            ),
            //payment section
            CustomTextButton(
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // rating section
                    children: [
                      Text(
                        'Paramètre de paiement',
                        style: DLivTextStyles.body1,
                      ),
                      const Icon(
                        Icons.credit_card,
                        color: DLivColors.label,
                        size: 30,
                      ),

                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/profile/payments');
                }
            ),
            Container(
              height: 10,
              color: DLivColors.placeholder,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: CustomButton(
                  text: 'Historique des livraisons',
                  outlineBorder: true,
                  borderColor: DLivColors.primary,
                  textColor: DLivColors.primary,
                  onPressed: () async {
                    Navigator.of(context).pushNamed('/profile/histories');
                  },
                ),
              ),
            ),
            //assistance, security and settings section
            Container(
              height: 10,
              color: DLivColors.placeholder,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextButton(
                    displayBgOnPressed: false,
                    content: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // rating section
                        children: [
                          const CircleAvatar(
                            backgroundColor: DLivColors.placeholder,
                            radius: 30.0,
                            child: Icon(
                              Icons.message,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),

                          Text(
                            'Assistance',
                            style: DLivTextStyles.body2g,
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile/assistance');
                    }
                ),
                CustomTextButton(
                    displayBgOnPressed: false,
                    content: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // rating section
                        children: [
                          const CircleAvatar(
                            backgroundColor: DLivColors.placeholder,
                            radius: 30.0,
                            child: Icon(
                              Icons.security_sharp,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),

                          Text(
                            'Sécurité',
                            style: DLivTextStyles.body2g,
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile/security');
                    }
                ),
                CustomTextButton(
                    displayBgOnPressed: false,
                    content: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // rating section
                        children: [
                          const CircleAvatar(
                            backgroundColor: DLivColors.placeholder,
                            radius: 30.0,
                            child: Icon(
                              Icons.settings_rounded,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),

                          Text(
                            'Paramètres',
                            style: DLivTextStyles.body2g,
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile/settings');
                    }
                ),
              ],
            ),
            //upgrades to delivery
            Container(
              height: 10,
              color: DLivColors.placeholder,
            ),
            //annexe section
            const AnnexesSection(),
          ],
        ),
      ),
    ));
  }
}