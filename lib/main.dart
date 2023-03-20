import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notbook/Screen/HomePage/view/Home_Page.dart';
import 'package:notbook/Screen/HomePage/view/Room_Page.dart';
import 'package:notbook/Time_Screen/View/time_Page.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // initialRoute: 'Home',
          routes: {
            '/': (p0) => Time_Screen(),
            'Home': (p0) => Home_Page(),
            'Room': (p0) => Room_Page(),
          },
        );
      },
    ),
  );
}
