import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakm/pages/Favorite.dart';
import 'package:hakm/pages/Second_Page.dart';
import 'package:hakm/sidebar/sidebar.dart';

import 'db/MyBinding.dart';
import 'sidebar/sidebar_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: '/home', page: () => (SideBarLayout()), binding: MyBinding()),
        GetPage(
            name: '/SideBar', page: () => (SideBar()), binding: MyBinding()),
        GetPage(
            name: '/SecondPage',
            page: () => (SecondPage(0, 0, "")),
            binding: MyBinding()),
        GetPage(
            name: '/favorite',
            page: () => (Favorite(0, "")),
            binding: MyBinding()),
      ],
      initialRoute: '/home',
      defaultTransition: Transition.native,
      title: 'وصايا الرسول ﷺ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      )));
}
