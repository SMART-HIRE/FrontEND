// ignore_for_file: prefer_const_constructors

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shire/Screens/Auth/screens/login_screen.dart';
import 'package:shire/Screens/Auth/screens/signup_screen.dart';
import 'package:shire/Screens/Auth/widgets/customized_button.dart';
import 'package:flutter/material.dart';
import 'package:shire/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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

            //   // height: 130,
            //   // width: 180,
            //   // child: Image(
            //   //     image: AssetImage("assets/icons/pic1.jpeg"), fit: BoxFit.cover),
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
              buttonText: "Login",
              buttonColor: Colors.lightBlueAccent,
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
            ),
            CustomizedButton(
              buttonText: "Register",
              buttonColor: Colors.black,
              textColor: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
            ),
            const SizedBox(height: 20),
           
          ],
        ),
      ),
    );
  }
}
