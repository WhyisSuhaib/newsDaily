import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsdaily/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Timer( const Duration(seconds:2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
      const HomeScreen()));
    });
  }


  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.sizeOf(context).height*1;
    final width= MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height*0.04,),
            Text("News Daily",style: GoogleFonts.pacifico
              (fontSize: 50,letterSpacing: 0.6,
            color: Colors.black),),
            SizedBox(height: height*0.04,),
             const SpinKitFadingCube(
              color: Colors.blue,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
