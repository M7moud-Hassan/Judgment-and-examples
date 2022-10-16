import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:hakm/MyController/ControllerSecondPage.dart';
import 'package:hakm/MyController/MyController.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Favorite extends GetView<ControllerSecondPage> {
  final id, title;
  Favorite(this.id, this.title, {Key? key}) : super(key: key) {
    controller.readListFav(id);
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
                title: Text(title),
                actions: [
                  IconButton(
                      onPressed: () {
                        AwesomeDialog(
                          btnOkText: 'نعم',
                          btnCancelText: "لا",
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.QUESTION,
                          body: Center(
                            child: Text(
                              "هل تريد فعلا حذف محتوي المفضلة لهذا الجزء",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          title: 'حذف المحتوي',
                          desc: 'This is also Ignored',
                          btnOkOnPress: () {
                            controller.deleteAll(id);
                          },
                          btnCancelOnPress: () {},
                        )..show();
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      )),
                ],
              ),
              body: ListView.builder(
                  itemCount: controller.listFav.length,
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
                          Container(
                            width: double.infinity,
                            child: Text(
                              controller
                                  .listFav[(index - (index / 4).toInt())].text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: controller.value_Sli,
                                  fontFamily:
                                      controller.dropdownValue == "غير مزغرف"
                                          ? null
                                          : "format",
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                  controller
                                      .listFav[(index - (index / 4).toInt())]
                                      .author,
                                  style: TextStyle(
                                      color: Colors.amberAccent, fontSize: 20),
                                  textAlign: TextAlign.left)),
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
                                    share(
                                        controller
                                            .listFav[
                                                (index - (index / 4).toInt())]
                                            .author,
                                        controller
                                            .listFav[
                                                (index - (index / 4).toInt())]
                                            .text);
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.amberAccent,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      btnOkText: 'نعم',
                                      btnCancelText: "لا",
                                      context: context,
                                      animType: AnimType.SCALE,
                                      dialogType: DialogType.QUESTION,
                                      body: Center(
                                        child: Text(
                                          "هل تريد فعلا حذف هذه المفضلة لهذا الجزء",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      title: 'حذف المحتوي',
                                      desc: 'This is also Ignored',
                                      btnOkOnPress: () {
                                        controller.deleteFav(
                                            id,
                                            controller
                                                .listFav[(index -
                                                    (index / 4).toInt())]
                                                .id);
                                      },
                                      btnCancelOnPress: () {},
                                    )..show();
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    index_fav = (index - (index / 4).toInt());
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
                                                        return firstController
                                                                        .fav_part[
                                                                    index]["id"] ==
                                                                id
                                                            ? Container()
                                                            : Container(
                                                                width: double
                                                                    .infinity,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .arrow_back_rounded),
                                                                    Expanded(
                                                                        child: InkWell(
                                                                            onTap: () {
                                                                              controller.update_fav_part(firstController.fav_part[index]["id"], controller.listFav[index_fav].id, id);
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child: Text(
                                                                              firstController.fav_part[index]["name"],
                                                                              style: TextStyle(color: Colors.indigo),
                                                                              textAlign: TextAlign.right,
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
                                    Icons.double_arrow_outlined,
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
