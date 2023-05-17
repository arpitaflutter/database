import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? database;
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Future<Database?> checkDB() async {
    if (database != null) {
      return database;
    } else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Arpita.db");

    return openDatabase(path, onCreate: (db, version) {
      String query =
          "CREATE TABLE incomeexpense(id INTEGER PRIMARY KEY AUTOINCREMENT,amount TEXT ,category TEXT, notes TEXT,date TEXT,time TEXT, paytypes TEXT, status TEXT,image BLOB)";
      db.execute(query);
    }, version: 1);
  }

  insertDB({required category,
    required notes,
    required amount,
    required date,
    required time,
    required paytypes,
    required status,
    required image
  }) async {
    database = await checkDB();

    database!.insert("incomeexpense", {
      "category": category,
      "notes": notes,
      "date": date,
      "time": time,
      "paytypes": paytypes,
      "amount": amount,
      "status": status,
      "image" : image
    });
  }

  Future<List<Map>> readDB() async {
    database = await checkDB();
    String query = "SELECT * FROM incomeexpense";

    List<Map> DataList = await database!.rawQuery(query);
    return DataList;
  }

  Future<List<Map>> FilterReadDB({required statusCode}) async
  {
    database = await checkDB();
    String query = "SELECT * FROM incomeexpense WHERE status = $statusCode";

    List<Map> l1 = await database!.rawQuery(query);
    return l1;
  }

  Future<void> updateDB(
      {required category,required id, required amount, required notes, required paytypes, required date, required time, required status,required image}) async {
    database = await checkDB();

    database!.update("incomeexpense", {
      "category": category,
      "amount": amount,
      "notes": notes,
      "date": date,
      "time": time,
      "paytypes": paytypes,
      "status": status,
      "image" : image
    },where: "id = ?",whereArgs: [id]);
  }

  Future<void> deleteDB({required id}) async {
    database = await checkDB();
    database!.delete('incomeexpense', where: "id = ?", whereArgs: [id]);
  }


}

// import 'dart:io';
// import 'dart:typed_data';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBHelper {
//   static DBHelper dbHelper = DBHelper._();
//
//   DBHelper._();
//
//   Database? database;
//
//   Future<Database?> checkDB() async {
//     if (database != null) {
//       return database;
//     } else {
//       return await createDB();
//     }
//   }
//
//   Future<Database> createDB() async {
//     Directory directorye = await getApplicationDocumentsDirectory();
//     String path = join(directorye.path, 'bookData.db');
//     return openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         String query =
//             "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT, category TEXT, quote TEXT, color TEXT)";
//         db.execute(query);
//       },
//     );
//   }
//
//   Future<void> insertData({required String category, required String quote,required String color}) async {
//     database = await checkDB();
//     database!.insert("category", {"category": category, "quote": quote, "color" : color}).then((value) {}).catchError((error){
//       print("=========== $error");
//     }
//     );
//   }
//
//   Future<List<Map>> readData() async {
//     database = await checkDB();
//     String query = "SELECT * FROM category";
//
//     List<Map> dataList = await database!.rawQuery(query);
//     return dataList;
//   }
//
//   Future<void> Deletdata(id)
//   async {
//     database = await checkDB();
//     database!.delete("category",whereArgs: [id],where: "id = ?");
//   }
// }
