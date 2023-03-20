import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Time_Screen extends StatefulWidget {
  const Time_Screen({Key? key}) : super(key: key);

  @override
  State<Time_Screen> createState() => _Time_ScreenState();
}

class _Time_ScreenState extends State<Time_Screen> {
  @override
  void initState() {
    Timer(Duration(seconds: 9), () {
      Get.offNamed('Home');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Container(
                child: Lottie.asset("assets/lotti/note.json"),
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                "Form",
                style: GoogleFonts.poppins(fontSize: 25),
              ),
            ),
            Text(
              "Dharmik Bhaliya",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
