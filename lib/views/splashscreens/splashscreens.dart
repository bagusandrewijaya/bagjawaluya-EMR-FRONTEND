import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sibagjaapps/views/home/homes.dart';
import 'package:sibagjaapps/views/login/V_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../login/components/initGorouter.dart';

class SplashScreens extends StatelessWidget {
   List<Color> colorizeColors = [
  Color(0xff4793AF),
 Color.fromARGB(255, 177, 234, 255),
 Color.fromARGB(255, 240, 251, 255),
];


TextStyle colorizeTextStyle = GoogleFonts.roboto(
  fontSize: 32.0,
);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Check login status when the app starts
      future: _checkLoginStatus(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Container(
         decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(
                    'assets/images/frame-medical-equipment-desk.jpg'),fit: BoxFit.cover)
         ),
            child: Center(child: Container(
              decoration: BoxDecoration(

                color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8)
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              width:  MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 SpinKitFadingCircle(
              color: Color(0xff4793AF),
              size: 90.0,
            ),
                  SizedBox(height: 16,),
               SizedBox(
               
                child: Material(
                  color: Colors.transparent,
                  child: SizedBox(
              
                child: AnimatedTextKit(
                  
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Yayasan Bagja Waluya',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                    ColorizeAnimatedText(
                      'Melayani Dengan Hati',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                    
                  ],
                  isRepeatingAnimation: true,
                  pause: Duration(microseconds: 100),
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
                ),
              )
                ],
              ),
            )));// or any loading widget
        } else {
          return LoginScreens();
        }
      },
    );

    
  }



Future<bool> _checkLoginStatus(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Check if the user is logged in
  await Future.delayed(Duration(seconds: 8));
  bool isLoggedIn = prefs.getBool('isLoggedIn') == null ? false : true;
if (isLoggedIn) {
  G.R(context,'/home');
}
  return isLoggedIn;
}

}