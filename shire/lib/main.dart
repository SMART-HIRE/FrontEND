import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shire/Screens/Auth/auth.dart';
import 'package:shire/Screens/Dashboard/canddash.dart';
import 'package:shire/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shire/Screens/Auth/widgets/customized_button.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();  

  @override  
  Widget build(BuildContext context) {  
    return FutureBuilder(  
      // Initialize FlutterFire:  
  future: _initialization,  
      builder: (context, snapshot) {  
        // Check for errors  
  if (snapshot.hasError) {  
          return Text('Error in Firebase Initilisation');  
        }  
        // Once complete, show your application  
  if (snapshot.connectionState == ConnectionState.done) {  
          return MaterialApp(  
            title: 'Smart Hire',  
            theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
            home: ButtonSelection(),  
            
          );  
        }  
        // Otherwise, show something whilst waiting for initialization to complete  
  return CircularProgressIndicator();  
      },  
    );  
  }  
}

class ButtonSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/background.png"))),
        
        child: Column(
          
          
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            const SizedBox(
              
              height: defaultPadding * 2
            ),
            Text('Smart Hire'),
             LoadingAnimationWidget.halfTriangleDot( 
              // LoadingAnimationwidget that call the
        color: Colors.lightBlue,      
                            // staggereddotwave animation
        size: 50,

    
      ),
      Spacer(),

          Row(
            
          children: 
          [

            Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/images/LOGO 1.png",

              ),
              
            ),
            Spacer(),
          ],
        ),



            const SizedBox(height: 40),
            CustomizedButton(
              buttonText: "CANDIDATE",
              buttonColor: Colors.lightBlueAccent,
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CandDash()));
              },
            ),
            CustomizedButton(
              buttonText: "HR",
              buttonColor: Colors.black,
              textColor: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Auth()));
              },
            ),
            const SizedBox(height: 20),
           
          ],
        ),
      ),
    );
  }
  
}



 