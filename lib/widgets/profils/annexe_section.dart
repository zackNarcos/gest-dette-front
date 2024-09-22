import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/widgets/forms/custom_text_button.dart';
import 'package:flutter/material.dart';

class AnnexesSection extends StatelessWidget{
  const AnnexesSection({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTextButton(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // rating section
                children: [
                  Text(
                    'Lieux favoris',
                    style: DLivTextStyles.body1,
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: DLivColors.label,
                    size: 28,
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile/favoris');
            }
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 1,
          color: DLivColors.muted,
        ),
        CustomTextButton(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // rating section
                children: [
                  Text(
                    'Devenir livreur',
                    style: DLivTextStyles.body1,
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: DLivColors.label,
                    size: 28,
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile/upgrade');
            }
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 1,
          color: DLivColors.muted,
        ),
        CustomTextButton(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // rating section
                children: [
                  Text(
                    'Informations',
                    style: DLivTextStyles.body1,
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: DLivColors.label,
                    size: 28,
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile/info');
            }
        ),
      ],
    );
  }
}
