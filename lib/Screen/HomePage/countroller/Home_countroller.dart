import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Home_Countroller extends GetxController {
  Rx<TextEditingController> txtbook = TextEditingController().obs;
  Rx<TextEditingController> txtupdetbook = TextEditingController().obs;
  RxList DataList = [].obs;
  RxInt compTask = 0.obs;
  RxString Day = "".obs;
  RxString Manth = "".obs;
  Rx<GlobalKey<FormState>> datakey = GlobalKey<FormState>().obs;
  Rx<GlobalKey<FormState>> updetkey = GlobalKey<FormState>().obs;

  void daydata() {
    if (DateTime.now().weekday == 1) {
      Day.value = "Monday";
    } else if (DateTime.now().weekday == 2) {
      Day.value = "Tuesday";
    } else if (DateTime.now().weekday == 3) {
      Day.value = "Wednsday";
    } else if (DateTime.now().weekday == 4) {
      Day.value = "Thursday";
    } else if (DateTime.now().weekday == 5) {
      Day.value = "Friday";
    } else if (DateTime.now().weekday == 6) {
      Day.value = "Saturday";
    } else if (DateTime.now().weekday == 7) {
      Day.value = "Sunday";
    }
  }

  void manthdata() {
    if (DateTime.now().month == 1) {
      Manth.value = "January";
    } else if (DateTime.now().month == 2) {
      Manth.value = "February";
    } else if (DateTime.now().month == 3) {
      Manth.value = "March";
    } else if (DateTime.now().month == 4) {
      Manth.value = "April";
    } else if (DateTime.now().month == 5) {
      Manth.value = "May";
    } else if (DateTime.now().month == 6) {
      Manth.value = "June";
    } else if (DateTime.now().month == 7) {
      Manth.value = "July";
    } else if (DateTime.now().month == 8) {
      Manth.value = "August";
    } else if (DateTime.now().month == 9) {
      Manth.value = "September";
    } else if (DateTime.now().month == 10) {
      Manth.value = "October";
    } else if (DateTime.now().month == 11) {
      Manth.value = "November";
    } else if (DateTime.now().month == 12) {
      Manth.value = "December";
    }
  }
}
