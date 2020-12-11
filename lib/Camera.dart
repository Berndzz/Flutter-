import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_project_04/Upload.dart';

class camera extends StatefulWidget {
  @override
  _cameraState createState() => _cameraState();
}

class _cameraState extends State<camera> {

  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          //new Padding(padding: EdgeInsets.only(bottom: 500.0),),
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: _clear,
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
            Uploader(file:_imageFile),
          ],
        ],
      ),
    );
  }
}
