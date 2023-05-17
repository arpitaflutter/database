import 'dart:io';
import 'dart:typed_data';

import 'package:database/screens/database/controller/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  DatabaseController controller = Get.put(DatabaseController());
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtpaytypes = TextEditingController();
  TextEditingController txtdate = TextEditingController();
  TextEditingController txttime = TextEditingController();
  TextEditingController txtstatus = TextEditingController();
  TextEditingController txtnotes = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    controller.ReadData();
                  },
                  child: Text(
                    "All",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.FilterReadDB(0);
                  },
                  child: Text(
                    "Income",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.FilterReadDB(1);
                  },
                  child: Text(
                    "Expense",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    print(controller.TransactionList[index]['status']);
                    return Container(
                      height: 80,
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:
                            controller.TransactionList[index]['status'] == "0"
                                ? Colors.green.shade200
                                : Colors.red.shade200,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${controller.TransactionList[index]['category']}",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "${controller.TransactionList[index]['amount']}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${controller.TransactionList[index]['date']}",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "${controller.TransactionList[index]['time']}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              txtcate = TextEditingController(
                                  text: controller.TransactionList[index]
                                      ['category']);
                              txtamount = TextEditingController(
                                  text: controller.TransactionList[index]
                                      ['amount']);
                              txtnotes = TextEditingController(
                                  text: controller.TransactionList[index]
                                      ['notes']);
                              txtpaytypes = TextEditingController(
                                  text: controller.TransactionList[index]
                                      ['paytypes']);
                              txtdate = TextEditingController(
                                  text: controller.TransactionList[index]
                                      ['date']);
                              txttime = TextEditingController(
                                  text: controller.TransactionList[index]
                                      ['time']);
                              txtstatus = TextEditingController(
                                  text: controller.TransactionList[index]
                                      ['status']);

                              var id = controller.TransactionList[index]['id'];
                              updateDialog(id);
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              var id = controller.TransactionList[index]['id'];
                              controller.deleteData(id);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: controller.TransactionList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateDialog(id) {
    Get.defaultDialog(
      content: Column(
        children: [
          TextField(
            controller: txtcate,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: txtamount,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: txtnotes,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: txtpaytypes,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: txtdate,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: txttime,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: txtstatus,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.updateData(
                      category: txtcate.text,
                      id: id,
                      amount: txtamount.text,
                      notes: txtnotes.text,
                      paytypes: txtpaytypes.text,
                      date: txtdate.text,
                      time: txttime.text,
                      status: txtstatus.text,
                      image: controller.path.value);

                  Get.back();
                },
                child: Text("Update"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Cancel"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              )
            ],
          ),
        ],
      ),
    );
  }
}
