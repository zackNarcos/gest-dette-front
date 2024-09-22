import 'dart:io';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMultiplePhotosWidget extends StatefulWidget {
  @override
  _AddMultiplePhotosWidgetState createState() => _AddMultiplePhotosWidgetState();
}

class _AddMultiplePhotosWidgetState extends State<AddMultiplePhotosWidget> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile>? _images = [];
  final int _imageLimit = 6;


  //pick images from gallery
  Future<void> _pickImages() async {
    if (_images!.length >= _imageLimit) {
      // Si la limite est atteinte, ne permet pas de sélectionner plus d'images
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: DLivColors.secondary,
          padding: EdgeInsets.all(20),
          content: Text(
            'Limite de photos atteinte',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
        ),
      );

      return;
    }

    final List<XFile> selectedImages = await _picker.pickMultiImage(
      imageQuality: 50,
      maxWidth: 1920,
      maxHeight: 1200,
    );

    setState(() {
      if (_images.length + selectedImages.length <= _imageLimit) {
        _images.addAll(selectedImages);
      } else {
        int remainingSlots = _imageLimit - _images.length;
        _images.addAll(selectedImages.take(remainingSlots));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: DLivColors.secondary,
            padding: EdgeInsets.all(20),
            content: Text(
              'Limite de photos atteinte',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
          ),
        );
      }
    });
    }

  //pick images from camera
  Future<void> _pickImage() async {
    //TODO:check if the user has granted permission to access the camera
    //check length of images
    if (_images!.length >= 6) {
      return;
    }
    final XFile? selectedImage = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 1920,
      maxHeight: 1200
    );
    if (selectedImage != null) {
      setState(() {
        _images.add(selectedImage);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images!.removeAt(index);
    });
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choisir une image'),
          content: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Row(
                    children: [
                      Icon(Icons.photo),
                      SizedBox(width: 10),
                      Text('Galerie'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImages();
                  },
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(Icons.camera_alt),
                      SizedBox(width: 10),
                      Text('Appareil photo'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: DLivColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            if (_images!.length < 6)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _showImageDialog,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: DLivColors.label,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (_images.length < 6)
            AnimatedContainer(duration: const Duration(milliseconds: 300),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ajouter des photos du coli',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            _images.isNotEmpty
                ? GridView.builder(
              shrinkWrap: true,
              itemCount: _images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(_images[index].path)),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 10,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () { _removeImage(index); },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.all(0),
                            ),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: DLivColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
