import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakm/MyController/MyController.dart';
import 'package:hakm/pages/Favorite.dart';
import 'package:hakm/pages/Second_Page.dart';
import '../MyController/ControllerSecondPage.dart';
import 'sidebar.dart';

class SideBarLayout extends GetView<MyController> {
  var secondController = Get.put(ControllerSecondPage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GetBuilder<MyController>(builder: (_) {
            return controller.home.value
                ? Scaffold(
                    backgroundColor:
                        controller.read.value ? Colors.indigo : Colors.white,
                    body: controller.read.value
                        ? CustomScrollView(
                            slivers: <Widget>[
                              GetBuilder<MyController>(
                                  builder: (context) => SliverAppBar(
                                        backgroundColor: controller.bg_t.value
                                            ? Colors.white
                                            : Colors.grey[900],
                                        actions: <Widget>[
                                          RawMaterialButton(
                                            elevation: 0.0,
                                            child: controller.searchIcon,
                                            onPressed: () {
                                              controller.searchPressed();
                                            },
                                            shape: CircleBorder(),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                                Icons.swap_horiz_outlined,
                                                color: Colors.indigo),
                                            onPressed: () {
                                              controller.toogleKutab();
                                            },
                                          )
                                        ],
                                        expandedHeight: 150,
                                        floating: false,
                                        pinned: true,
                                        flexibleSpace: FlexibleSpaceBar(
                                          titlePadding:
                                              EdgeInsets.only(bottom: 15),
                                          centerTitle: true,
                                          title: Container(
                                            margin: EdgeInsets.only(top: 40),
                                            child: controller.isSearchClicked
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 2),
                                                    constraints: BoxConstraints(
                                                        minHeight: 40,
                                                        maxHeight: 40),
                                                    width: 220,
                                                    child: CupertinoTextField(
                                                      controller:
                                                          controller.filter,
                                                      onChanged: (text) {
                                                        controller
                                                            .onChangeText(text);
                                                      },
                                                      keyboardType:
                                                          TextInputType.text,
                                                      placeholder: "ابحث هنا..",
                                                      placeholderStyle:
                                                          TextStyle(
                                                        color: controller
                                                                .bg_t.value
                                                            ? Colors.white
                                                            : Colors.grey[900],
                                                        fontSize: 14.0,
                                                        fontFamily: 'Brutal',
                                                      ),
                                                      prefix: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                9.0,
                                                                6.0,
                                                                9.0,
                                                                6.0),
                                                        child: Icon(
                                                          Icons.search,
                                                          color: controller
                                                                  .bg_t.value
                                                              ? Colors.white
                                                              : Colors
                                                                  .grey[900],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        color: !controller
                                                                .bg_t.value
                                                            ? Colors.white
                                                            : Colors.grey[900],
                                                      ),
                                                    ),
                                                  )
                                                : Text(
                                                    controller.titleHome.value,
                                                    style: TextStyle(
                                                        color: Colors.indigo,
                                                        fontSize: 25,
                                                        fontWeight: FontWeight
                                                            .w800) //TextStyle
                                                    ),
                                          ),
                                        ),
                                      )), //SliverAppBar
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 100,
                                        margin: EdgeInsets.all(5),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Get.to(SecondPage(
                                                  -1, -1, "كل الحكم"));
                                            },
                                            child: Text(
                                              'كل الحكم',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateColor.resolveWith(
                                                        (states) =>
                                                            Colors.blueGrey),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                18.0),
                                                        side: BorderSide(
                                                            color:
                                                                Colors.blueGrey))))),
                                      ),
                                      Container(
                                          width: double.infinity,
                                          height: 100,
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "2472",
                                            style:
                                                TextStyle(color: Colors.amber),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              GetBuilder<MyController>(
                                builder: (e) => SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 100,
                                            margin: EdgeInsets.all(5),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  controller.titleHome ==
                                                          "الاقسام"
                                                      ? Get.to(SecondPage(
                                                          0,
                                                          1,
                                                          controller
                                                              .list[index]))
                                                      : Get.to(SecondPage(
                                                          0,
                                                          0,
                                                          controller
                                                              .list2_2[index]
                                                              .toString()));
                                                },
                                                child: Text(
                                                  controller.titleHome ==
                                                          "الاقسام"
                                                      ? controller.list[index]
                                                      : controller
                                                          .list2_2[index],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateColor.resolveWith(
                                                            (states) => Colors
                                                                .lightBlue),
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    18.0),
                                                            side: BorderSide(
                                                                color: Colors.lightBlue))))),
                                          ),
                                          Container(
                                              width: double.infinity,
                                              height: 100,
                                              padding: EdgeInsets.all(10),
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                controller.titleHome ==
                                                        "الاقسام"
                                                    ? controller.list1[index]
                                                        .toString()
                                                    : controller.list2[index]
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                ),
                                              ))
                                        ],
                                      );
                                    },
                                    childCount:
                                        controller.titleHome == "الاقسام"
                                            ? controller.list.length
                                            : controller.list2.length,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                    childAspectRatio: 2.0,
                                  ),
                                ),
                              ),
                              //SliverList
                            ], //<Widget>[]
                          )
                        : Center(
                            child: CircularProgressIndicator(
                            backgroundColor: Colors.grey,
                          )) //CustonScrollView
                    )
                : Scaffold(
                    backgroundColor:
                        controller.read.value ? Colors.indigo : Colors.white,
                    body: CustomScrollView(
                      slivers: <Widget>[
                        GetBuilder<MyController>(
                            builder: (context) => SliverAppBar(
                                  backgroundColor: controller.bg_t.value
                                      ? Colors.white
                                      : Colors.grey[900],
                                  expandedHeight: 150,
                                  floating: false,
                                  pinned: true,
                                  flexibleSpace: FlexibleSpaceBar(
                                    titlePadding: EdgeInsets.only(bottom: 15),
                                    centerTitle: true,
                                    title: Container(
                                      margin: EdgeInsets.only(top: 40),
                                      child: Text("المفضلة",
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 25,
                                              fontWeight:
                                                  FontWeight.w800) //TextStyle
                                          ),
                                    ),
                                  ),
                                )), //SliverAppBar
                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              margin: EdgeInsets.all(5),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(Favorite(1, "كل المفضلة"));
                                  },
                                  child: Text(
                                    'كل المفضلة',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.blueGrey),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.blueGrey))))),
                            ),
                          ),
                        ),

                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    margin: EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(Favorite(
                                              controller.fav_part[index + 1]
                                                  ["id"],
                                              controller.fav_part[index + 1]
                                                  ["name"]));
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              controller.fav_part[index + 1]
                                                  ["name"],
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        context: context,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        builder: (context) {
                                                          TextEditingController
                                                              myController =
                                                              TextEditingController()
                                                                ..text = controller
                                                                        .fav_part[
                                                                    index +
                                                                        1]["name"];
                                                          return Padding(
                                                            padding:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets,
                                                            child: GetBuilder<
                                                                MyController>(
                                                              builder: (_) =>
                                                                  Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .indigo,
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              20),
                                                                          topRight:
                                                                              Radius.circular(20)),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                            child:
                                                                                Text(
                                                                          "اسم الملف",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        )),
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              controller.updateFav_part(controller.fav_part[index + 1]["id"]);
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              Icons.add,
                                                                              color: Colors.red,
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .folder,
                                                                    color: Colors
                                                                        .brown,
                                                                    size: 80,
                                                                  ),
                                                                  Container(
                                                                    width: 200,
                                                                    child:
                                                                        CupertinoTextField(
                                                                      controller:
                                                                          myController,
                                                                      onChanged:
                                                                          (text) {
                                                                        controller
                                                                            .onchangeLengthFav(text);
                                                                      },
                                                                      autofocus:
                                                                          true,
                                                                      maxLength:
                                                                          25,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      "${controller.length}/25"),
                                                                  Row(
                                                                    children: [
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          icon:
                                                                              Icon(Icons.cancel)),
                                                                      Expanded(
                                                                          child:
                                                                              Text(""))
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).whenComplete(() {
                                                        controller.length = 0;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors.red,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      secondController
                                                          .deleteAll(controller
                                                                  .fav_part[
                                                              index + 1]["id"]);
                                                      controller.deleteFa(
                                                          controller.fav_part[
                                                              index + 1]["id"]);
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            // 40 list items
                            childCount: controller.fav_part!.length - 1,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: GetBuilder<MyController>(
                                        builder: (_) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.indigo,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    "اسم الملف",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                  IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .addFav_part();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors.red,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.folder,
                                              color: Colors.brown,
                                              size: 80,
                                            ),
                                            Container(
                                              width: 200,
                                              child: CupertinoTextField(
                                                onChanged: (text) {
                                                  controller
                                                      .onchangeLengthFav(text);
                                                },
                                                autofocus: true,
                                                maxLength: 25,
                                              ),
                                            ),
                                            Text("${controller.length}/25"),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: Icon(Icons.cancel)),
                                                Expanded(child: Text(""))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ).whenComplete(() {
                                  controller.length = 0;
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.green,
                                size: 50,
                              ),
                            ),
                          ),
                        )
                        //SliverList
                      ], //<Widget>[]
                    ) //CustonScrollView
                    );
          }),
          SideBar(),
        ],
      ),
    );
  }
}
