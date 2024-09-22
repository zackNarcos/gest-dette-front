import 'dart:async';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:d_liv/blocs/auth/auth_bloc.dart';
import 'package:d_liv/blocs/auth/auth_state.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class InfoSection extends StatefulWidget {
  const InfoSection({
    super.key
  });

  @override
  _MePanelContentState createState() => _MePanelContentState();
}

class _MePanelContentState extends State<InfoSection> {
  File? _image;
  final ImagePicker picker = ImagePicker();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  final TextEditingController limitController = TextEditingController();

  get maxWidth => double.tryParse(maxWidthController.text) ?? 1000;
  get maxHeight => double.tryParse(maxHeightController.text) ?? 1000;
  get quality => int.tryParse(qualityController.text) ?? 100;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    dynamic _pickImageError;
    String? _retrieveDataError;

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
      setState(() {
        _image = File(pickedFile!.path);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      // profile image
        TextButton(
            onPressed: _pickImage,
            child: AvatarGlow(
              glowColor: DLivColors.primaryLight,
              glowShape: BoxShape.circle,
              animate: false,
              child: Material(     // Replace this child with your own
                // elevation: 12.0,
                shape: const CircleBorder(),
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                child: CircleAvatar(
                  backgroundColor: DLivColors.placeholder,
                  radius: 40.0,
                  child: _image == null
                      ? const Icon(
                    Icons.camera_alt_outlined,
                    size: 50,
                    color: Colors.black,
                  )
                      : Image.file(
                    _image!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
        ),
        const SizedBox(height: 5),
        // name and rating
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            Expanded(child: Container()),
            BlocBuilder<AuthBloc, AuthState>(
              // buildWhen: (previous, current) => previous.newDelivery?.sourceName != current.newDelivery?.sourceName,
                builder: (context, state) {
                  return
                    Column(
                      children: [
                        Text(
                          state.user!.lastName!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )
                        ),
                        Text(
                          state.user!.firstName!,
                          style: const TextStyle(
                            color: DLivColors.label,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                }),
            const Expanded(child: Align(
              alignment: Alignment.centerRight,
              child:
              Icon(
                Icons.chevron_right_outlined,
                color: DLivColors.label,
                size: 28,
              ),
            )),
          ],
        ),
      ]
    );
  }
}
