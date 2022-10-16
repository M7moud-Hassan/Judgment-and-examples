import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakm/db/Data.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ControllerSecondPage extends GetxController with SingleGetTickerProviderMixin{
  String dropdownValue = 'غير مزغرف';
  List<Map> favs=[];
  List<int>fav_id=[];
  List <String> spinnerItems = [
    'غير مزغرف'
    ,'مزغرف'
  ] ;
  ItemScrollController scrollController = ItemScrollController();
  void scrollTo(){
    int m=0;
    for(Items items in  list){
      if(items.id==all)
        break;
      else m++;
    }
    m=(m+m/8).toInt();
    scrollController.scrollTo(index: m, duration: Duration(seconds: 1));
  }
  double value_Sli=25;
  changeSlider(value){
    value_Sli=value;
    update();
  }
  spinnerChange(data){
    dropdownValue = data;
    update();
  }
  List list=[];
  List queres=[];
  var db=Data();
  Widget? appBarTitle ;
  var title="";
  Icon actionIcon =  Icon(Icons.search, color: Colors.white,);
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController searchQuery = new TextEditingController();
  bool IsSearching=false;
  String searchText = "";
  SearchListState() {
    searchQuery.addListener(() {
      if (searchQuery.text.isEmpty) {

          IsSearching = false;
          searchText = "";

      }
      else {

          IsSearching = true;
          searchText = searchQuery.text;
      }
    });
    update();
  }

  void handleSearchStart() {
    IsSearching = true;
    update();
  }

  void handleSearchEnd() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text(title, style: new TextStyle(color: Colors.white),);
      IsSearching = false;
      searchQuery.clear();
      list=queres;
      update();
  }
  List listFav=[];
  Future<void> readListFav(id_p) async {
    listFav=[];
    await db.inti();
      List<Map> listItem = await db.getAllFav_ID(id_p);
      listItem.forEach((element) {
        Items items = Items();
        items.id = element["_id"];
        items.author = element["category_name"];
        items.text = element["qte"];
        listFav.add(items);
      });
      //print(listFav.length);
      update();
  }
  update_fav_part(id_part,id,id_exit) async{
   await db.update_fav_part(id_part,id,id_exit);
   readListFav(id_exit);
  }

  deleteFav(id_p,id)async{
    await db.deleteFav(id_p,id);
    await readFav();
    await readListFav(id_p);

  }
  deleteAll(id_p)async{
   await db.deleteAll_id(id_p);
  await readFav();
  await readListFav(id_p);

  }
  Future<void> readList(id,p,title) async{
    appBarTitle=  Text(title, style: new TextStyle(color: Colors.white),);
    this.title=title;
    await db.inti();
    list=[];
    if(id==-1 && p==-1){
      List<Map> listItem= await db.getAll();
      listItem.forEach((element) {
        Items items=Items();
        items.id=element["_id"];
        items.author=element["category_name"];
        items.text=element["qte"];
        list.add(items);
      });
    }else if(id==0 && p==0){
      List<Map> listItem= await db.getAllK(title);
      listItem.forEach((element) {
        Items items=Items();
        items.id=element["_id"];
        items.author=element["category_name"];
        items.text=element["qte"];
        list.add(items);
      });
    }else {
      List<Map> listItem= await db.getAllKK(title);
      listItem.forEach((element) {
        Items items=Items();
        items.id=element["_id"];
        items.author=element["category_name"];
        items.text=element["qte"];
        list.add(items);
      });
    }

      update();
    await readFav();
    await readResume();
    queres=list;
    update();
  }

  Future<void> readFav() async{
    fav_id=[];
    favs=await db.getAllFav();
    favs.forEach((element) {
      fav_id.add(element["_id"]);
    });
  }
  query(text){
    List searches=[];
    queres.forEach((element) {
      if(element.text.contains(text)){
        searches.add(element);
      }
    });
    list=searches;
    update();
  }
  Animation<double>? manimation;
  AnimationController? mcontroller;
  double scale = 0.0;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final quick = const Duration(milliseconds: 500);
    final scaleTween = Tween(begin: 0.0, end: 1.0);
    mcontroller = AnimationController(duration: quick, vsync: this);
    manimation = scaleTween.animate(
      CurvedAnimation(
        parent: mcontroller!,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
     scale = manimation!.value;
     update();
    });

  }
  int favs_index=-1;
  @override
  void dispose() {
    mcontroller!.dispose();
    super.dispose();
  }
  void animate(f) async{
    favs_index=f;
    manimation
      !..addStatusListener((AnimationStatus status) {
        if (scale == 1.0) {
          mcontroller!.reverse();
        }
      });
    mcontroller!.forward();
  }
  add_fav(id_part,id) async{
    try {
      await db.add_to_fav(id_part, id);
    }catch(e){}
   fav_id=[];
   await readFav();
    update();
  }
  int all=-1;
  readResume() async{
    var list=await db.getAllResume();
    list.forEach((element) {
     all= element["position"];
    });
    update();
  }
  updateResume(po) async{
    await db.apdateResum(po);
    readResume();
  }
}
class Items{
  int? id;String? author;String? text;
}