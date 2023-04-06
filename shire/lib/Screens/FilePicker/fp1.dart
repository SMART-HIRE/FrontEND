// ignore_for_file: unused_import, unnecessary_import

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shire/Screens/FilePicker/api/firebase_api.dart';
import 'package:shire/Screens/FilePicker/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shire/Screens/Welcome/component/welcome_image.dart';

class FP1 extends StatelessWidget {
  static final String title = 'Resume Upload';

  const FP1({Key? key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.green),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<UploadTask?> taskList = [];
  List<File?> fileList = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(FP1.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset("assets/images/LOGO 1.png"),
                ),
                ButtonWidget(
                  text: 'Select Files',
                  icon: Icons.attach_file,
                  onClicked: selectFiles,
                ),
                SizedBox(height: 8),
                Text(
                  'Number of Files Selected: ${fileList.length}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 48),
                ButtonWidget(
                  text: 'Upload Files',
                  icon: Icons.cloud_upload_outlined,
                  onClicked: uploadFiles,
                ),
                SizedBox(height: 20),
                taskList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: taskList.length,
                          itemBuilder: (context, index) =>
                              buildUploadStatus(taskList[index]!),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      );

  Future selectFiles() async {
    final result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;

  List<File> files = result.paths.map((path) => File(path!)).toList();

    setState(() => fileList = files);
  }

  Future uploadFiles() async {
    for (final file in fileList) {
      final fileName = basename(file!.path);
      final destination = 'senior_engineer/$fileName';

      final task = FirebaseApi.uploadFile(destination, file);

      taskList.add(task);
    }

    setState(() {});
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
