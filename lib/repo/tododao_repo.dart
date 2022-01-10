import 'package:to_do_app/entity/todos.dart';
import 'package:to_do_app/sqlite/db_helper.dart';

class ToDoDaoRepo {

  Future<void> addToDo(String yapilacak_is,String yapilacak_is_detay) async {
    var db = await DbHelper.reachDb();

    var info = Map<String,dynamic>();
    info["yapilacak_is"] = yapilacak_is;
    info["yapilacak_is_detay"] = yapilacak_is_detay;
    
    await db.insert("yapilacaklar", info);
  }

  Future<void> updateToDo(int yapilacak_id,String yapilacak_is,String yapilacak_is_detay) async {
    var db = await DbHelper.reachDb();

    var info = Map<String,dynamic>();
    info["yapilacak_is"] = yapilacak_is;
    info["yapilacak_is_detay"] = yapilacak_is_detay;

    await db.update("yapilacaklar", info,where: "yapilacak_id = ?",whereArgs: [yapilacak_id]);
  }

  Future<void> deleteToDo(int yapilacak_id) async {
    var db = await DbHelper.reachDb();
    await db.delete("yapilacaklar", where: "yapilacak_id = ?", whereArgs: [yapilacak_id]);
  }

  Future<List<ToDoS>> allToDoS() async {
    var db = await DbHelper.reachDb();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM yapilacaklar");

    return List.generate(maps.length, (index){
      var row = maps[index];
      return ToDoS(yapilacak_id: row["yapilacak_id"], yapilacak_is: row["yapilacak_is"],yapilacak_is_detay: row["yapilacak_is_detay"]);
    });
  }

  Future<List<ToDoS>> searchToDo(String searchWord) async {
    var db = await DbHelper.reachDb();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM yapilacaklar WHERE yapilacak_is like '%$searchWord%'");

    return List.generate(maps.length, (index){
      var row = maps[index];
      return ToDoS(yapilacak_is: row["yapilacak_is"], yapilacak_id: row["yapilacak_id"],yapilacak_is_detay: row["yapilacak_is_detay"]);
    });
  }
}