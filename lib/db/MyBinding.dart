import 'package:get/get.dart';
import 'package:hakm/MyController/ControllerSecondPage.dart';
import 'package:hakm/MyController/MyController.dart';

class MyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyController>(() => MyController());
    Get.lazyPut<ControllerSecondPage>(() => ControllerSecondPage());
  }

}