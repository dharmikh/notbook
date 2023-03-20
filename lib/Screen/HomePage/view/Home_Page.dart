import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notbook/Screen/HomePage/countroller/Home_countroller.dart';
import 'package:notbook/Screen/HomePage/view/Room_Page.dart';
import 'package:notbook/utils/Fr_helper/Fr_Halper.dart';
import 'package:sizer/sizer.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  Home_Countroller home_countroller = Get.put(Home_Countroller());

  @override
  void initState() {
    home_countroller.daydata();
    home_countroller.manthdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade100,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(25),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 17.w),
                      child: Text(
                        "${home_countroller.Day.value},",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "${DateTime.now().day}",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "${home_countroller.Manth.value}",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  ],
                ),
                // Text("${home_countroller.DataList.length}")
              ],
            ),
          ),
        ),
        backgroundColor: Colors.green.shade100,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseHelper.firebaseHelper.ReadNotesData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              home_countroller.DataList.value.clear();
              var docs = snapshot.data!.docs;
              // print("==========${docs.length}");
              for (var doc in docs) {
                Map docData = doc.data() as Map;
                // print("===== ${docData['note']}");
                home_countroller.DataList.add(
                  {
                    "note": docData['note'],
                    "id": doc.id,
                    "status": docData['status']
                  },
                );
                // print("============ ${home_countroller.DataList.value.length}");
              }
              home_countroller.compTask.value = 0;
              for (int i = 0; i < home_countroller.DataList.length; i++) {
                if (home_countroller.DataList[i]['status'] == true) {
                  home_countroller.compTask.value++;
                }
              }
              return Obx(
                () => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            // color: Colors.red,
                            width: 60.w,
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(right: 13.w, top: 10.h),
                                  child: Text(
                                      "${home_countroller.DataList.value.length}"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5.w, top: 0),
                                  child: Text("Created tasks"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.bottomRight,
                            // color: Colors.red,
                            width: 35.w,
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 23.w, top: 10.h),
                                  child: Text(
                                      "${home_countroller.compTask.value}"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: Text("Completed tasks"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Expanded(
                      child: Container(
                        height: 10.h,

                        // color: Colors.white,
                        child: Obx(
                          () => ListView.builder(
                            itemCount: home_countroller.DataList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  FirebaseHelper.firebaseHelper.UpdateData(
                                      id: home_countroller.DataList[index]
                                          ['id'],
                                      note: home_countroller.DataList[index]
                                          ['note'],
                                      status: home_countroller.DataList[index]
                                                  ['status'] ==
                                              true
                                          ? false
                                          : true);
                                  home_countroller.DataList[index]['status'] ==
                                          false
                                      ? Get.snackbar(
                                          "Alert", "Your task is Done")
                                      : Get.snackbar(
                                          "Alert", "Your task is Undone");
                                },
                                leading: Icon(
                                  Icons.check_circle_outlined,
                                  color: home_countroller.DataList[index]
                                              ['status'] ==
                                          true
                                      ? Colors.green
                                      : Colors.grey,
                                  size: 35,
                                ),
                                title: Text(
                                    "${home_countroller.DataList[index]['note']}",
                                    style: TextStyle(
                                      color: home_countroller.DataList[index]
                                                  ['status'] ==
                                              true
                                          ? Colors.grey
                                          : Colors.black,
                                    )),
                                trailing: Container(
                                  height: 10.h,
                                  width: 20.w,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          home_countroller.txtupdetbook.value
                                              .clear();
                                          Get.defaultDialog(
                                              content: Form(
                                                key: home_countroller
                                                    .updetkey.value,
                                                child: TextFormField(
                                                  maxLength: 50,
                                                  controller: home_countroller
                                                      .txtupdetbook.value,
                                                  cursorColor: Colors.green,
                                                  style: TextStyle(
                                                      fontSize: 15.sp),
                                                  decoration: InputDecoration(
                                                    hintText: "Wright  Note",
                                                    prefixIcon: Icon(
                                                      Icons
                                                          .sticky_note_2_rounded,
                                                      size: 21.sp,
                                                    ),
                                                    prefixIconColor:
                                                        Colors.green,
                                                    hintStyle: TextStyle(
                                                        fontSize: 15.sp),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.grey)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
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
                                              actions: [
                                                InkWell(
                                                  onTap: () {
                                                    if (home_countroller
                                                        .updetkey
                                                        .value
                                                        .currentState!
                                                        .validate()) {
                                                      FirebaseHelper
                                                          .firebaseHelper
                                                          .UpdateData(
                                                              id: home_countroller
                                                                      .DataList[
                                                                  index]['id'],
                                                              note: home_countroller
                                                                  .txtupdetbook
                                                                  .value
                                                                  .text,
                                                              status: home_countroller
                                                                      .DataList[
                                                                  index]['status']);
                                                      Get.back();
                                                      Get.snackbar("Alert",
                                                          "${home_countroller.txtupdetbook.value.text} Is Update");
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 8.h,
                                                    width: 30.w,
                                                    alignment: Alignment.center,
                                                    child: Text("Update"),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Colors.green),
                                                  ),
                                                )
                                              ]);
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          size: 30,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            FirebaseHelper.firebaseHelper
                                                .DeleteData(
                                                    id: home_countroller
                                                        .DataList[index]['id']);
                                            Get.snackbar("Hello User",
                                                "${home_countroller.DataList[index]['note']} is Delet");
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            home_countroller.txtbook.value.clear();
            Get.to(const Room_Page(),
                transition: Transition.upToDown,
                duration: Duration(milliseconds: 500));
          },
          child: Icon(
            Icons.add,
            size: Get.width / 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
