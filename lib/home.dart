import 'package:flutter/material.dart';
import 'package:flutter_booking/login_admin.dart';
import 'Login.dart';

class HomePage extends StatelessWidget {

  final String name;
  final String lname;

  const HomePage({super.key, required this.name, required this.lname});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Home Page"),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );

            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // เอาช่องว่างด้านบนออก
          children: [
            // 🔸 Header ของ Drawer (ส่วนหัว)
            const UserAccountsDrawerHeader(
              accountName: Text('ธนบดี แพทยังกุล'), // ชื่อผู้ใช้
              accountEmail: Text('66712939'), // อีเมล
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person), // ไอคอนโปรไฟล์
              ),
            ),

            // 🔸 เมนู: หน้าแรก
            ListTile(
              leading: const Icon(Icons.home), // ไอคอน
              title: const Text('หน้าแรก'), // ข้อความเมนู
              onTap: () {
                Navigator.pop(context); // ปิด Drawer
              },
            ),

            // 🔸 เมนู: ไปหน้า Page 1
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('เข้าสู่ระบบ'),
              onTap: () {
                Navigator.pop(context); // ปิด Drawer ก่อน

                // 🔹 เปิดหน้าใหม่ (Page1)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginAdmin()),
                );
              },
            ),

            // 🔸 เมนู: ไปหน้า Page 2
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('อุปกรณ์'),
              onTap: () {
                Navigator.pop(context); // ปิด Drawer ก่อน

                // 🔹 เปิดหน้าใหม่ (Page2)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginAdmin()),
                );
              },
            ),
          ],
        ),
      ),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.verified_user,
              size: 80,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            Text(
              "Welcome $name : $lname",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Login Success",
              style: TextStyle(fontSize: 18),
            ),

          ],
        ),

      ),

    );

  }

}