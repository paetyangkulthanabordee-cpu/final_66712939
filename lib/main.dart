import 'package:flutter/material.dart';
import 'package:flutter_booking/Home_page.dart';
import 'package:flutter_booking/Login.dart';
import 'login_admin.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equipment Rent',
      home: HomePage(),   // ✅ หน้าแรกแสดงรายการห้องประชุม
    );

  }

}