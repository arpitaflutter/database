import 'dart:io';

import 'package:database/screens/database/controller/database_controller.dart';
import 'package:database/utils/Helper/database_Helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class databaseScreen extends StatefulWidget {
  const databaseScreen({Key? key}) : super(key: key);

  @override
  State<databaseScreen> createState() => _databaseScreenState();
}

class _databaseScreenState extends State<databaseScreen> {
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtPayTypes = TextEditingController();
  TextEditingController txtDate = TextEditingController(
      text:
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
  TextEditingController txtTime = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  TextEditingController txtStatus = TextEditingController();
  TextEditingController txtnotes = TextEditingController();

  DatabaseController controller = Get.put(DatabaseController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Database"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: MemoryImage(
                        FileImage(File("${controller.path.value}")) as Uint8List)
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      ImagePicker picker = ImagePicker();

                      XFile? xfile =
                      await picker.pickImage(source: ImageSource.gallery);
                      controller.path.value = xfile!.path;

                      controller.bytes = xfile.readAsBytes();
                    },
                    child: Text("Pick Image"),
                  ),
                  TextField(
                    controller: txtcate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Category"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: txtAmount,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Amount"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: txtnotes,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Notes"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: txtPayTypes,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("PayTypes"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: txtDate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Date"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: txtTime,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Time"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: txtStatus,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Status"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('transaction');
                    },
                    child: Text("Transaction"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Text(
                      "INSERT",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      DbHelper.dbHelper.insertDB(
                          category: txtcate.text,
                          notes: txtnotes.text,
                          amount: txtAmount.text,
                          date: txtDate.text,
                          time: txtTime.text,
                          paytypes: txtPayTypes.text,
                          status: txtStatus.text,
                          image: controller.path.value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
