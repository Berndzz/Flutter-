import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';


class Uploader extends StatefulWidget {
  final File file;
  Uploader({Key key, this.file}) : super(key: key);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://mini-project-4-5c843.appspot.com/');

  StorageUploadTask _uploadTask;

  void _startUpload() {

    /// Unique file name for the file
    String filePath = '${DateTime.now()}';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {

      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;
            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            return Column(
              children: [
                  new Icon(Icons.directions_run),
                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text(
                    '${(progressPercent * 100).toInt()} % '
                ),
              ],
            );
          });
    } else {
      return FlatButton.icon(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}

