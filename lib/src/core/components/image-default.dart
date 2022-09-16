import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageDefault extends StatelessWidget {
  final ValueChanged<ImageSource> onClicked;

  const ImageDefault({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        _buildImage(context),
      ],
    ));
  }

  _buildImage(BuildContext context) {
    return InkWell(
      onTap: () async {
        final source = await showImageSource(context);
        if (source == null) return;
        onClicked(source);
      },
      child: Container(
        width: double.infinity,
        child: Icon(FontAwesomeIcons.image,size: 160),
      ),
    );
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
}
