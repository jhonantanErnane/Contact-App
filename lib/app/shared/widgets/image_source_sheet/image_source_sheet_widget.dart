import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheetWidget extends StatelessWidget {
  final Function(File) onImageSelected;
  const ImageSourceSheetWidget({Key key, this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker imagePicker = ImagePicker();
    return BottomSheet(
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            child: Text('Câmera'),
            onPressed: () async {
              PickedFile file = await imagePicker.getImage(source: ImageSource.camera);
              _imageSelected(file);
            },
          ),
          FlatButton(
            child: Text('Galeria'),
            onPressed: () async {
              PickedFile file = await imagePicker.getImage(source: ImageSource.gallery);
              _imageSelected(file);
            },
          )
        ],
      ),
      onClosing: () {},
    );
  }

  Future _imageSelected(PickedFile image) async {
    if (image != null) {
      try {
        File croppedImage = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          androidUiSettings: AndroidUiSettings(
              statusBarColor: Colors.black,
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              toolbarTitle: 'Editar Foto'),
        );
        onImageSelected(croppedImage);
      } catch (e) {
        print(e.toString());
        onImageSelected(null);
      }
    } else
      onImageSelected(null);
  }
}
