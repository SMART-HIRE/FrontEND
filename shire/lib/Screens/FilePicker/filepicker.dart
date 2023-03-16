// // ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, sort_child_properties_last, avoid_print, use_key_in_widget_constructors, unused_local_variable, unnecessary_null_comparison

// import 'dart:io';
// import 'package:flutter_document_picker/flutter_document_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter/material.dart';

// class UploadPdf extends StatefulWidget {
//   @override
//   _UploadPdf createState() => _UploadPdf();
// }

// class _UploadPdf extends State<UploadPdf> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      backgroundColor: Colors.green[100],
//         body: Center(
//           child: MaterialButton(

//         onPressed: () async {
//           final path = await FlutterDocumentPicker.openDocument();
//           print(path);
//           File file = File(path!);
//           firebase_storage.UploadTask task = await uploadFile(file);
//         },
//         child: Text(
//               'Pick and Upload file',
//               style: TextStyle(color: Colors.white),
//             ),
//             color: Colors.green,
//           ),
//         ),
//       );
    
//   }


// Future<firebase_storage.UploadTask> uploadFile(File file) async {  
//   if (file == null) {  
//     (SnackBar(content: Text("Unable to Upload")));  
      
//   } 

//   firebase_storage.UploadTask uploadTask;  
  
//   // Create a Reference to the file  
//   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance  
//   .ref()  
//       .child('playground')  
//       .child('/some-files.pdf');  
  
//   final metadata = firebase_storage.SettableMetadata(  
//       contentType: 'file/pdf',  
//       customMetadata: {'picked-file-path': file.path});  
//   print("Uploading..!");  
  
//   uploadTask = ref.putData(await file.readAsBytes(), metadata);  
  
//   print("done..!");  
//   return Future.value(uploadTask);  
// }


// }
