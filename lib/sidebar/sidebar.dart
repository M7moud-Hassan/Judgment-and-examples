import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakm/MyController/MyController.dart';
import '../MyController/ControllerSecondPage.dart';
import '../sidebar/menu_item.dart';

class SideBar extends GetView<MyController>{

  var con=Get.put(ControllerSecondPage());
  var rng = Random();

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    con.readList(-1, -1, "");

    return GetBuilder<MyController>(
        builder: (context)=>StreamBuilder<bool>(
      initialData: false,
      stream: controller.isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration:controller.animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data! ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:0),
                  color:controller.bg_t.value?Colors.white:Colors.grey[900],
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 183,
                        color: controller.bg_t.value?Colors.white:Colors.grey[900],
                        child:Stack(
                          children: [
                            Image.asset("assets/images/drawerimage.png"),
                            IconButton(onPressed: (){
                              controller.toogleDark();
                              controller.onIconPressed();
                            }, icon: Icon(Icons.dark_mode,color: controller.bg_t.value?Colors.grey[900]:Colors.white,),padding: EdgeInsets.all(30),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MyMenuItem(
                        icon: Icons.home,
                        title: "الصفحة الرئسية",
                        onTap: () {
                          controller.onIconPressed();
                          controller.onPress(1);
                        },
                      ),
                      MyMenuItem(
                        icon: Icons.star,
                        title: "المفصلة",
                        onTap: () {
                          controller.onIconPressed();
                          controller.onPress(2);
                        },
                      ),
                      MyMenuItem(
                        icon: Icons.note_alt_sharp,
                        title: "اقتباس اليوم",
                        onTap: () {
                          Items item=con.list[rng.nextInt(con.list.length)];
        Dialog errorDialog = Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)), //this right here
        child: Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: double.infinity,child: Text(item.text!,textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.white),)),
              Container(margin: EdgeInsets.only(left: 20),child: Text(item.author!,style: TextStyle(decoration: TextDecoration.underline,fontSize: 20,color: Colors.white),textAlign: TextAlign.left))
            ],
          ),
        ),
        );
        showDialog(context: context, builder: (BuildContext context) => errorDialog);}
                      ),
                      Divider(
                        height: 0,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      IconButton(onPressed: (){
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.INFO,
                          body: Center(child: Text(
                            "تطبيق احكام وامثال العلماء والفقهاء يضم اكثر من 3000 حكمه ومثل لاشهر العلماء والفقهاء",
                              style: TextStyle(fontStyle: FontStyle.italic),textAlign: TextAlign.center,
                          ),),
                          title: 'This is Ignored',
                          desc:   'This is also Ignored',
                          btnOkOnPress: () {},
                        )..show();
                      }, icon: Icon(Icons.question_mark_sharp,color: Colors.indigo,))
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    controller.onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color:controller.bg_t.value?Colors.white:Colors.grey[900],
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: controller.animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.indigo,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
