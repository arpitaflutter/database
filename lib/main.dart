import 'package:database/screens/Transaction/view/transaction_screen.dart';
import 'package:database/screens/database/view/databaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()
{
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => databaseScreen(),),
        GetPage(name: '/transaction', page: () => TransactionScreen(),),
      ],
    ),
  );
}