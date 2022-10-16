import 'package:get/get.dart';
import 'package:hakm/db/Data.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class MyController extends GetxController with SingleGetTickerProviderMixin {
  var db = Data();
  RxString titleHome = "الكتّاب".obs;
  RxBool read = false.obs;
  List<String> querK = [];
  List<String> querKK = [];
  List<int> querIk = [];
  List<int> querIKK = [];
  List<int> list2 = [];
  List<String> list2_2 = [];
  List<int> list1 = [];
  RxBool bg_t = true.obs;
  List<Map> fav_part = [];
  Future<void> readFav_part() async {
    fav_part = await db.getFav_Part();
    update();
  }

  List<String> list = [
    'الوقت',
    'الحياة',
    'الناس',
    'الحب',
    'العلم',
    'العمل',
    'الدنيا',
    'القلب',
    'الموت',
    'المال',
    'الحرب',
    'النجاح',
    'العقل',
    'الصديق',
    'التسامح',
    'الوطن',
    'السياسة',
    'الجهل',
    'الحقيقة',
    'العمر',
    'الكذب',
    'القوة',
    'السعادة',
    'الصبر',
    'الحزن',
    'الأمل',
    'الأم',
    'الغباء',
    'الصمت',
    'الثقة',
    'الحرية',
    'الماضي',
    'الفشل'
  ];
  void toogleKutab() {
    if (titleHome.value == "الكتّاب")
      titleHome.value = "الاقسام";
    else
      titleHome.value = "الكتّاب";
    update();
  }

  RxBool home = true.obs;
  onPress(id) {
    if (id == 1)
      home = true.obs;
    else if (id == 2)
      home = false.obs;
    else {}
    update();
  }

  Future<void> readData() async {
    await db.inti();
    list.forEach((e) async {
      var value = await db.getCatword(e);
      value.forEach((element) {
        list1.add(int.parse(element["count"].toString()));
      });
    });
    var value = await db.getCatAuthor();
    value.forEach((element) async {
      list2_2.add(element['name']);
      list2.add(int.parse(element['count'].toString()));
    });
    querK = list2_2;
    querKK = list;
    querIk = list2;
    querIKK = list1;
    read.value = true;
    readFav_part();
  }

  int length = 0;
  String text = "";
  onchangeLengthFav(text) {
    length = text.toString().length;
    this.text = text;
    update();
  }

  updateFav_part(id) async {
    await db.updateFav_part(text, id);
    readFav_part();
  }

  deleteFa(id) async {
    await db.deleteFav_part(id);
    readFav_part();
  }

  addFav_part() async {
    if (text != "") {
      try {
        print("add");
        await db.add_Part(text);
        await readFav_part();
      } catch (e) {}
      update();
    }
  }

  late AnimationController animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  final animationDuration = const Duration(milliseconds: 500);
  void toogleDark() {
    bg_t.value = !bg_t.value;
    update();
  }

  @override
  void onInit() async {
    animationController =
        AnimationController(vsync: this, duration: animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
    await readData();
    super.onInit();
  }

  void onIconPressed() {
    final animationStatus = animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      animationController.forward();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  Icon searchIcon = Icon(
    Icons.search,
    color: Colors.indigo,
  );
  bool isSearchClicked = false;
  final TextEditingController filter = new TextEditingController();
  void searchPressed() {
    if (this.searchIcon.icon == Icons.search) {
      this.searchIcon = Icon(
        Icons.close,
        color: Colors.indigo,
      );
      isSearchClicked = true;
    } else {
      this.searchIcon = Icon(
        Icons.search,
        color: Colors.indigo,
      );
      isSearchClicked = false;
      filter.clear();
      list2_2 = querK;
      list = querKK;
      list2 = querIk;
      list1 = querIKK;
    }
    update();
  }

  void onChangeText(text) {
    List<String> list3 = [];
    List<int> list3_3 = [];
    if (titleHome == "الكتّاب".obs) {
      int m = 0;
      querK.forEach((element) {
        if (element.contains(text)) {
          list3.add(element);
          list3_3.add(querIk[m]);
        }
        m++;
      });
      list2_2 = list3;
      list2 = list3_3;
    } else {
      int m = 0;
      querKK.forEach((element) {
        if (element.contains(text)) {
          list3.add(element);
          list3_3.add(querIKK[m]);
        }
        m++;
      });
      list = list3;
      list1 = list3_3;
    }
    update();
  }
}
