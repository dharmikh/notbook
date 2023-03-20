import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notbook/Screen/HomePage/countroller/Home_countroller.dart';
import 'package:notbook/utils/Fr_helper/Fr_Halper.dart';
import 'package:sizer/sizer.dart';

class Room_Page extends StatefulWidget {
  const Room_Page({Key? key}) : super(key: key);

  @override
  State<Room_Page> createState() => _Room_PageState();
}

class _Room_PageState extends State<Room_Page> {
  Home_Countroller home_countroller = Get.put(Home_Countroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () =>  Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.green,
            title: Text("Create Note"),
            centerTitle: true,
          ),
          backgroundColor: Colors.green.shade100,
          body: Form(
            key: home_countroller.datakey.value,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: TextFormField(
                      maxLength: 50,
                      controller: home_countroller.txtbook.value,
                      cursorColor: Colors.green,
                      style: TextStyle(fontSize: 15.sp),
                      decoration: InputDecoration(
                        hintText: "Wright  Note",
                        prefixIcon: Icon(
                          Icons.sticky_note_2_rounded,
                          size: 21.sp,
                        ),
                        prefixIconColor: Colors.green,
                        hintStyle: TextStyle(fontSize: 15.sp),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Add Anything";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offNamed('Home');
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5.w),
                        height: 7.h,
                        width: 35.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (home_countroller.datakey.value.currentState!
                            .validate()) {
                           FirebaseHelper.firebaseHelper.InsertData(
                              note: home_countroller.txtbook.value.text);
                         Get.back();
                        }

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5.w),
                        height: 7.h,
                        width: 35.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green),
                        child: Text(
                          "Create",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
