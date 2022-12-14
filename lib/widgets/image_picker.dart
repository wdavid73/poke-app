import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poke_app/utils/responsive.dart';

class ImagePickerCustom extends StatelessWidget {
  final Responsive responsive;
  final File? image;
  final bool imageNull;
  final ValueChanged<File?> onFileChanged;
  final picker = ImagePicker();

  ImagePickerCustom({
    Key? key,
    required this.responsive,
    required this.onFileChanged,
    this.image,
    this.imageNull = false,
  }) : super(key: key);

  Future<dynamic> getImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onFileChanged(File(image.path));
    } else {
      onFileChanged(null);
    }
    /*.then((image) async {
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return image == null
        ? InkWell(
            onTap: () => getImage(),
            child: Container(
              width: responsive.wp(50),
              height: responsive.hp(25),
              decoration: BoxDecoration(
                color: Colors.grey,
                border: imageNull
                    ? Border.all(
                        color: Colors.redAccent,
                        width: responsive.width * 0.01,
                      )
                    : null,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Icon(
                      Icons.photo_library,
                      color: Colors.white,
                      size: responsive.dp(5),
                    ),
                  ),
                  Text(
                    "Select a Image",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.dp(2),
                    ),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            onTap: () => getImage(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.file(
                image!,
                fit: BoxFit.cover,
                width: responsive.width * 0.5,
                height: responsive.width * 0.5,
              ),
            ),
          );
  }
}
