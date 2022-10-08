import 'dart:io';

import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatelessWidget {
  final File image;
  final double imageWidth;
  final double imageHeight;
  final ValueChanged<ImageSource> onClicked;
  final ValueChanged<bool> onRemove;

  const ImageWidget({
    Key? key,
    required this.image,
    required this.imageWidth,
    required this.imageHeight,
    required this.onClicked,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        _buildImage(context),
        Positioned(
          bottom: 5,
          right: 60,
          child: _builView(context),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: _builDelete(),
        ),
      ],
    ));
  }

  Widget _buildImage(BuildContext context) {
    final imagePath = this.image.path;
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return Material(
        color: Colors.transparent,
        child: Ink.image(
            image: image as ImageProvider,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 160,
            child: InkWell(
              onTap: () async {
                final source = await showImageSource(context);
                if (source == null) return;
                onClicked(source);
              },
            )));
  }

  showImageSource(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt_outlined),
                  title: Text('Camara'),
                  onTap: () => Navigator.of(context).pop(ImageSource.camera),
                ),
                ListTile(
                  leading: Icon(Icons.image_outlined),
                  title: Text('Galeria'),
                  onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                ),
              ],
            ));
  }

  Widget _builDelete() {
    return GestureDetector(
      child: ClipOval(
        child: Container(
            color: Envinronment.colorBackground,
            padding: EdgeInsets.all(10),
            child:
                Icon(FontAwesomeIcons.trash, color: Envinronment.colorDanger)),
      ),
      onTap: () {
        onRemove(true);
      },
    );
  }

  Widget _builView(BuildContext context) {
    return GestureDetector(
      child: ClipOval(
        child: Container(
            color: Envinronment.colorBackground,
            padding: EdgeInsets.all(10),
            child: Icon(FontAwesomeIcons.eye, color: Envinronment.colorSecond)),
      ),
      onTap: () => _dialogBuilder(context),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.file(image),
          actions: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 1.0, color: Envinronment.colorButton),
                  backgroundColor: Envinronment.colorWhite,
                  shape: StadiumBorder(),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cerrar',
                    style: TextStyle(
                        color: Envinronment.colorBlack,
                        fontWeight: FontWeight.normal)))
          ],
        );
      },
    );
  }
}
