import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:hakm/MyController/ControllerSecondPage.dart';
import 'package:hakm/MyController/MyController.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SecondPage extends GetView<ControllerSecondPage> {
  final id, p, title;
  SecondPage(this.id, this.p, this.title, {Key? key}) : super(key: key) {
    controller.readList(id, p, title);
  }
  final firstController = Get.put(MyController());
  int index_fav = -1;
  int index_resum = -1;
  Future<void> share(author, text) async {
    await FlutterShare.share(title: author, text: text);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerSecondPage>(
        builder: (_) => Scaffold(
              backgroundColor:
                  firstController.bg_t.value ? Colors.white : Colors.grey[900],
              appBar: AppBar(
                backgroundColor: Colors.indigo,
                centerTitle: true,
                title: controller.appBarTitle,
                actions: [
                  IconButton(
                    icon: controller.actionIcon,
                    onPressed: () {
                      if (controller.actionIcon.icon == Icons.search) {
                        controller.actionIcon = new Icon(
                          Icons.close,
                          color: Colors.white,
                        );
                        controller.appBarTitle = new TextField(
                          onChanged: (text) {
                            controller.query(text);
                          },
                          controller: controller.searchQuery,
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                          decoration: new InputDecoration(
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.white),
                            hintText: "بحث...",
                            hintStyle: new TextStyle(color: Colors.white),
                          ),
                        );
                        controller.handleSearchStart();
                      } else {
                        controller.handleSearchEnd();
                      }
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        controller.scrollTo();
                      },
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.white,
                      )),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.indigo,
                onPressed: () {
                  Get.defaultDialog(
                    title: "الخط",
                    titleStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    backgroundColor: Colors.indigo,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GetBuilder<ControllerSecondPage>(
                          builder: (_) => Row(
                            children: [
                              SizedBox(
                                width: 25,
                              ),
                              DropdownButton<String>(
                                value: controller.dropdownValue,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                                underline: Container(
                                  height: 2,
                                  color: Colors.white,
                                ),
                                onChanged: (data) {
                                  controller.spinnerChange(data);
                                },
                                items: controller.spinnerItems
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              Expanded(
                                  child: Text(
                                "شكل الخط",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: GetBuilder<ControllerSecondPage>(
                                  builder: (_) => Slider(
                                    thumbColor: Colors.white,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.grey,
                                    min: 10,
                                    max: 50,
                                    value: controller.value_Sli,
                                    onChanged: (value) {
                                      controller.changeSlider(value);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              "حجم الخط",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                          ],
                        )
                      ],
                    ),
                  );
                },
                child: Icon(Icons.format_size),
              ),
              body: ScrollablePositionedList.builder(
                  itemScrollController: controller.scrollController,
                  itemCount: controller.list.length +
                      (controller.list.length / 8).ceil(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.updateResume(controller
                                  .list[(index - (index / 8).toInt())].id);
                            },
                            icon: Icon(
                              Icons.bookmark,
                              size: 30,
                              color: controller.all ==
                                      controller
                                          .list[(index - (index / 8).toInt())]
                                          .id
                                  ? Colors.red
                                  : Colors.orange,
                            ),
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.zero,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                  controller
                                      .list[(index - (index / 8).toInt())].text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: controller.value_Sli,
                                      fontFamily: controller.dropdownValue ==
                                              "غير مزغرف"
                                          ? null
                                          : "format",
                                      color: Colors.white),
                                ),
                              ),
                              if (controller.favs_index ==
                                  (index - (index / 8).toInt()))
                                Container(
                                  child: Transform.scale(
                                    scale: controller.scale,
                                    child: Icon(Icons.favorite,
                                        size: 160.0, color: Colors.red),
                                  ),
                                  alignment: Alignment.center,
                                ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: p == 0
                                ? Text(
                                    controller
                                        .list[(index - (index / 8).toInt())]
                                        .author,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.left)
                                : InkWell(
                                    onTap: () {
                                      controller.readList(
                                          0,
                                          0,
                                          controller
                                              .list[
                                                  (index - (index / 8).toInt())]
                                              .author);
                                    },
                                    child: Text(
                                        controller
                                            .list[(index - (index / 8).toInt())]
                                            .author,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.amberAccent,
                                            fontSize: 20),
                                        textAlign: TextAlign.left),
                                  ),
                          ),
                          Divider(
                            thickness: 2,
                            indent: 30,
                            endIndent: 30,
                            height: 10,
                            color: Colors.amberAccent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    index_fav = (index - (index / 8).toInt());
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        context: context,
                                        useRootNavigator: true,
                                        isDismissible: true,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return FractionallySizedBox(
                                            heightFactor: 0.8,
                                            child: DraggableScrollableSheet(
                                              initialChildSize: 0.5,
                                              maxChildSize: 1,
                                              minChildSize: 0.25,
                                              builder: (BuildContext context,
                                                  ScrollController
                                                      scrollController) {
                                                return Scaffold(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  appBar: AppBar(
                                                    backgroundColor:
                                                        Colors.indigo,
                                                    title: Text("اختر المفضلة"),
                                                    centerTitle: true,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(30),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      30)),
                                                    ),
                                                  ),
                                                  floatingActionButton:
                                                      FloatingActionButton(
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
                                                                              firstController.addFav_part();
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
                                                                      onChanged:
                                                                          (text) {
                                                                        firstController
                                                                            .onchangeLengthFav(text);
                                                                      },
                                                                      autofocus:
                                                                          true,
                                                                      maxLength:
                                                                          25,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      "${firstController.length}/25"),
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
                                                        firstController.length =
                                                            0;
                                                      });
                                                    },
                                                    backgroundColor:
                                                        Colors.indigo,
                                                    child: Icon(Icons.add),
                                                  ),
                                                  body: Container(
                                                    color: Colors.white,
                                                    child: ListView.builder(
                                                      controller:
                                                          scrollController,
                                                      itemCount: firstController
                                                          .fav_part.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Container(
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            children: [
                                                              if (index != 0)
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        context:
                                                                            context,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(20),
                                                                              topRight: Radius.circular(20)),
                                                                        ),
                                                                        builder:
                                                                            (context) {
                                                                          TextEditingController
                                                                              myController =
                                                                              TextEditingController()..text = firstController.fav_part[index]["name"];
                                                                          return Padding(
                                                                            padding:
                                                                                MediaQuery.of(context).viewInsets,
                                                                            child:
                                                                                GetBuilder<MyController>(
                                                                              builder: (_) => Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Container(
                                                                                    width: double.infinity,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.indigo,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                                                    ),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                            child: Text(
                                                                                          "اسم الملف",
                                                                                          textAlign: TextAlign.center,
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        )),
                                                                                        IconButton(
                                                                                            onPressed: () {
                                                                                              firstController.updateFav_part(firstController.fav_part[index]["id"]);
                                                                                              Navigator.of(context).pop();
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
                                                                                      controller: myController,
                                                                                      onChanged: (text) {
                                                                                        firstController.onchangeLengthFav(text);
                                                                                      },
                                                                                      autofocus: true,
                                                                                      maxLength: 25,
                                                                                    ),
                                                                                  ),
                                                                                  Text("${firstController.length}/25"),
                                                                                  Row(
                                                                                    children: [
                                                                                      IconButton(
                                                                                          onPressed: () {
                                                                                            Navigator.of(context).pop();
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
                                                                      ).whenComplete(
                                                                          () {
                                                                        firstController
                                                                            .length = 0;
                                                                      });
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: Colors
                                                                          .green,
                                                                    )),
                                                              Expanded(
                                                                  child: InkWell(
                                                                      onTap: () {
                                                                        controller.add_fav(
                                                                            firstController.fav_part[index]["id"],
                                                                            controller.list[index_fav].id);
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        controller
                                                                            .animate(index_fav);
                                                                      },
                                                                      child: Text(
                                                                        firstController.fav_part[index]
                                                                            [
                                                                            "name"],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.indigo),
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                      ))),
                                                              Icon(
                                                                Icons
                                                                    .folder_open,
                                                                color: Colors
                                                                    .brown,
                                                                size: 50,
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: controller.fav_id.contains(controller
                                            .list[(index - (index / 8).toInt())]
                                            .id)
                                        ? Colors.red
                                        : Colors.amber,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    print("print");
                                    share(
                                        controller.list[index].author,
                                        controller
                                            .list[(index - (index / 8).toInt())]
                                            .text);
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.amberAccent,
                                  )),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ));
  }
}
