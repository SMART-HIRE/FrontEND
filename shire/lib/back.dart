// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseFileDownloader extends StatefulWidget {
  @override
  _FirebaseFileDownloaderState createState() => _FirebaseFileDownloaderState();
}

class _FirebaseFileDownloaderState extends State<FirebaseFileDownloader> {
  List<String> fileNames = [];
  List<String> downloadUrls = [];

  @override
  void initState() {
    super.initState();
    _getFileNamesAndUrls();
  }

  Future<void> _getFileNamesAndUrls() async {
    // Create a reference to the Firebase Storage folder
    final storageRef = FirebaseStorage.instance.ref().child('files');

    // Get a list of all the files in the folder
    final ListResult result = await storageRef.listAll();

    // Extract the file names and download URLs from the metadata
    final names = result.items.map((item) => item.name).toList();
    final urls = await Future.wait(result.items.map((item) => item.getDownloadURL()));

    // Update the state with the file names and download URLs
    setState(() {
      fileNames = names;
      downloadUrls = urls;
    });
  }

  Future<void> _downloadFile(int index) async {
    // Get the local directory where the file will be saved
    final directory = await getExternalStorageDirectory();
    final localPath = directory?.path;

    // Create a reference to the Firebase Storage file
    final storageRef = FirebaseStorage.instance.ref().child('files/${fileNames[index]}');

    // Download the file to local storage
    final downloadTask = storageRef.writeToFile(File('$localPath/${fileNames[index]}'));
    final snapshot = await downloadTask.whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Download complete!'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidate Resumes'),
      ),
      body: ListView.builder(
        itemCount: fileNames.length,
        itemBuilder: (context, index) {
          final fileName = fileNames[index];
          final downloadUrl = downloadUrls[index];
          return ListTile(
            title: Text(fileName),
            onTap: () => _downloadFile(index),
            trailing: Icon(Icons.download_rounded),
          );
        },
      ),
    );
  }
}
