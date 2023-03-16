// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shire/Screens/Auth/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shire/Screens/Auth/screens/welcome_screen.dart';
import 'package:shire/Screens/Dashboard/dashboard.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Hire',
      
      theme: ThemeData(
        textTheme: GoogleFonts.urbanistTextTheme(),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const DashBoard();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}


  
