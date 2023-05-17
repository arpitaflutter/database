import 'package:database/utils/Helper/database_Helper.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  RxList<Map> TransactionList = <Map>[].obs;
  RxInt filter = 1.obs;
  RxString path = "".obs;
  var bytes;

  Future<void> ReadData() async {
    TransactionList.value = await DbHelper.dbHelper.readDB();
  }

  Future<void> FilterReadDB(statusCode) async {
    TransactionList.value =
        await DbHelper.dbHelper.FilterReadDB(statusCode: statusCode);
  }

  void updateData(
      {required category,
      required id,
      required amount,
      required notes,
      required paytypes,
      required date,
      required time,
      required image,
      required status}) {
    DbHelper.dbHelper.updateDB(
        category: category,
        id: id,
        amount: amount,
        notes: notes,
        paytypes: paytypes,
        date: date,
        time: time,
        status: status,
        image: image);

    ReadData();
  }

  Future<void> deleteData(id) async {
    DbHelper.dbHelper.deleteDB(id: id);

    ReadData();
  }
}
