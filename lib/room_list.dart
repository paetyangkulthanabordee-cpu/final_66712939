import 'package:flutter/material.dart';
import 'package:flutter_booking/home_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'booking_page.dart';
import 'booking_list.dart';
import 'Home_page.dart' hide HomePage;

//////////////////////////////////////////////////////////////
// API URL
//////////////////////////////////////////////////////////////

const String baseUrl = "http://localhost/final_66712939/php_api/";

//////////////////////////////////////////////////////////////
// ROOM LIST PAGE
//////////////////////////////////////////////////////////////

class RoomList extends StatefulWidget {

  final String name; //เพิ่ม
  
const RoomList({super.key, required this.name}); //เพิ่ม

@override
State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {

List rooms = [];
List filteredRooms = [];

TextEditingController searchController = TextEditingController();

////////////////////////////////////////////////////////////
// INIT
////////////////////////////////////////////////////////////

@override
void initState() {
super.initState();
fetchRooms();
}

////////////////////////////////////////////////////////////
// FETCH ROOMS
////////////////////////////////////////////////////////////

Future<void> fetchRooms() async {


final response =
    await http.get(Uri.parse("${baseUrl}get_rooms.php"));

if (response.statusCode == 200) {

  setState(() {

    rooms = json.decode(response.body);
    filteredRooms = rooms;

  });

}


}

////////////////////////////////////////////////////////////
// SEARCH ROOM
////////////////////////////////////////////////////////////

void searchRoom(String keyword) {


final results = rooms.where((room) {

  final name =
      room['eq_name'].toString().toLowerCase();

  return name.contains(keyword.toLowerCase());

}).toList();

setState(() {
  filteredRooms = results;
});

}

////////////////////////////////////////////////////////////
// UI
////////////////////////////////////////////////////////////

@override
Widget build(BuildContext context) {

return Scaffold(

  ////////////////////////////////////////////////////////
  // APPBAR
  ////////////////////////////////////////////////////////

  appBar: AppBar(
    title: const Text("อุปกรณ์"),
    actions: [
      Text("Welcome . ${widget.name}"),
          const SizedBox(width: 28 ,),
      IconButton(
        icon: const Icon(Icons.list_alt),
        tooltip: "ดูอุปกรณ์ทั้งหมด",
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BookingList(),
            ),
          );

        },
      ),
      IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false,
              );

            },
          ),

            const SizedBox(height: 10),

    ],
  ),

  ////////////////////////////////////////////////////////
  // BODY
  ////////////////////////////////////////////////////////

  body: Column(

    children: [

      //////////////////////////////////////////////////////
      // SEARCH BOX
      //////////////////////////////////////////////////////

      Padding(

        padding: const EdgeInsets.all(10),

        child: TextField(

          controller: searchController,

          decoration: const InputDecoration(
            hintText: "ค้นหาอุปกรณ์...",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),

          onChanged: searchRoom,

        ),

      ),
      

      //////////////////////////////////////////////////////
      // ROOM LIST
      //////////////////////////////////////////////////////

      Expanded(

        child: filteredRooms.isEmpty

            ? const Center(child: Text("ไม่พบข้อมูลอุปกรณ์"))

            : ListView.builder(

                itemCount: filteredRooms.length,

                itemBuilder: (context, index) {

                  final room = filteredRooms[index];

                  String imageUrl =
                      "${baseUrl}images/${room['image'] ?? ''}";

                  return Card(

                    margin: const EdgeInsets.all(10),
                    elevation: 3,

                    child: ListTile(

                      isThreeLine: true,

                      leading: ClipRRect(

                        borderRadius:
                            BorderRadius.circular(8),

                        child: Image.network(

                          imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,

                          errorBuilder: (_, __, ___) =>
                              const Icon(
                                  Icons.meeting_room),

                        ),

                      ),

                      title: Text(

                        room['eq_name'] ?? "",

                        style: const TextStyle(
                            fontWeight: FontWeight.bold),

                      ),

                      subtitle: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                              "Detail: ${room['detail']} คน"),

                          Text(
                              "Num: ${room['num']}"),

                          Text(
                              "Created: ${room['created_at']}"),

                        ],

                      ),
trailing: Wrap(
  direction: Axis.vertical,
  spacing: 2,
  children: [



    

  ],
),

   
   
   
   
   
                    ),

                  );

                },

              ),

      ),

    ],

  ),

);


}

}
