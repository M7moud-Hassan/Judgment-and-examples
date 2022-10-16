import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Data {
  var db;

  Future<void> inti() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'hakm.db');

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join("assets", "db/hakm.db"));

      List<int> bytes =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);

      await new File(path).writeAsBytes(bytes);
    }
    db = await openDatabase(path);
  }

  Future<List<Map>> getCatAuthor() async {
    return  await db.rawQuery('SELECT quote.category_name as name ,count(*) as count from quote GROUP by quote.category_name');
  }

  Future<List<Map<String,dynamic>>> getCatword(index) async{
    return await db.rawQuery("select count(*) as count from quote where quote.qte like '%$index%';");
  }

  Future<List<Map>> getAll() async{
    return await db.rawQuery("select _id,category_name,qte from quote ORDER by qte;");
  }

  Future<List<Map>> getAllK(query) async{
    return await db.rawQuery("select _id,category_name,qte from quote where category_name='$query';");
  }

  Future<List<Map>> getAllKK(query) async{
    return await db.rawQuery("select _id,category_name,qte from quote where qte like '%$query%';");
  }

  Future<List<Map>> getAllFav_ID(id_p) async{
    return await db.rawQuery("select quote._id,category_name,qte from quote,fav WHERE quote._id=fav._id and fav.id_part=$id_p;");
  }
  Future<bool> checkFavorite(id) async{
    List list= await db.rawQuery("select * from quote where _id=$id and fav=1");
    return list.isNotEmpty;
  }
  Future<void> add(id)async{
   await db.rawUpdate("update quote set fav=1 where _id=$id");
  }
  updateFav_part(name,id) async{
    await db.rawUpdate("update fav_part set name='$name' where id=$id");
  }
  Future<void> remove(id)async{
    await db.rawUpdate("update quote set fav=1 where _id=$id");
  }

  Future<void> update_fav_part(id_p,id,id_exit)async{
    await db.rawUpdate("UPDATE fav set id_part=$id_p where _id=$id and id_part=$id_exit");
  }


  Future<void> add_Part(name) async {
    await db.rawInsert("INSERT INTO fav_part('name') VALUES('$name')");
  }
  Future<List<Map>> getFav_Part() async{
    return await db.rawQuery("select * from fav_part");
  }
  deleteFav_part(id) async{
    await db.delete("fav_part",where:"id=$id");
  }

  add_to_fav(id_part,id) async{
    await db.rawInsert("INSERT INTO fav VALUES($id_part,$id)");
  }
  Future<List<Map>>getAllFav() async{
    return await db.rawQuery("select * from fav");
  }

  apdateResum(po) async{
    await db.rawUpdate("update resume set position=$po");
  }
  Future<List<Map>>getAllResume() async{
    return await db.rawQuery("select * from resume");
  }
  deleteAll_id(id) async{
    await db.delete("fav",where:"id_part=$id");
  }

  deleteFav(id_p,id) async{
    await db.delete("fav",where:"id_part=$id_p and _id=$id");
  }
}
