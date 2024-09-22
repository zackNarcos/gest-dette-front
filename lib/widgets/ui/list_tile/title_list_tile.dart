import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:flutter/material.dart';
class TitleListTile extends StatelessWidget {
  const TitleListTile({
    super.key,
    this.label,
    this.leading,
  });

  final String? label;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: leading,
          style: ListTileStyle.drawer,
          title:Container(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child:  Text(
                label!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: DLivTextStyles.h3,
              ),
            ),
          )
        ),
      ],
    );
  }
}