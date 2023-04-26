// // ignore_for_file: prefer_const_constructors, sort_child_properties_last

// import 'package:file_picker/file_picker.dart';
// import 'package:open_file/open_file.dart';
// import 'package:flutter/material.dart';
  
  
// class FileP extends StatelessWidget {
//   const FileP({super.key});

//   void _pickFile() async {
      
    
//     final result = await FilePicker.platform.pickFiles(allowMultiple: true);
  
//     // if no file is picked
//     if (result == null) return;
  
//     // we get the file from result object
//     final file = result.files.first;
  
//     _openFile(file);
//   }
  
//   void _openFile(PlatformFile file) {
//     OpenFile.open(file.path);
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.green[100],
//         body: Center(
//           child: MaterialButton(
//             onPressed: () {
//               _pickFile();
//             },
//             child: Text(
//               'Pick and Upload file',
//               style: TextStyle(color: Colors.white),
//             ),
//             color: Colors.green,
//           ),
//         ),
//       ),
//     );
//   }
// }