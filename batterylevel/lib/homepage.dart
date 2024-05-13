// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var channel = const MethodChannel("ganesh/testapp");
//     List<dynamic>? myInfo;

//   Future<void> getMyInfo() async {
//   try {
//     final List<dynamic> info = await channel.invokeMethod('getMyInfo') as List<dynamic>;
//     print('Received data type: ${info.runtimeType}');
//     print('Received data: $info');
//     setState(() {
//       myInfo = info.cast<String>();
//       print(myInfo);
//     });
//   } on PlatformException catch (e) {
//     print("Error occurred while fetching data: $e");
//   } catch (error) {
//     print("Unknown error occurred: $error");
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.teal.shade900,
//         title: Text(
//           "BodyFatDemo",
//           style: GoogleFonts.poppins(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 70,
//           ),
//           GestureDetector(
//             onTap: () {
//               getMyInfo();
//             },
//             child: Center(
//               child: Container(
//                 height: 50,
//                 width: 150,
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 212, 211, 211),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "START SCAN",
//                     style: GoogleFonts.poppins(
//                       color: Colors.black,
//                       fontSize: 17,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // if (myInfo != null &&
//           //     myInfo!.isNotEmpty)
//           //   ...[
//           //   const SizedBox(height: 16),
//           //   Text(
//           //     'Name: ${myInfo?[0]}',
//           //     style: TextStyle(fontSize: 20),
//           //   ),
//           //   // Text(
//           //   //   'Middle Name: ${myInfo?[1]}',
//           //   //   style: TextStyle(fontSize: 20),
//           //   // ),
//           //   // Text(
//           //   //   'Surname: ${myInfo?[2]}',
//           //   //   style: TextStyle(fontSize: 20),
//           //   // ),
//           // ],
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var channel = const MethodChannel("ganesh/testapp");
  List<Map<String, dynamic>>? myInfo;

  Future<void> getMyInfo() async {
    try {
      final List<dynamic> info = await channel.invokeMethod('getMyInfo') as List<dynamic>;
      print('Received data type: ${info.runtimeType}');
      print('Received data: $info');
      setState(() {
        myInfo = parseData(info);
      });
    } on PlatformException catch (e) {
      print("Error occurred while fetching data: $e");
    } catch (error) {
      print("Unknown error occurred: $error");
    }
  }

  List<Map<String, dynamic>>? parseData(List<dynamic> data) {
    try {
      return data.map((item) {
        final Map<String, dynamic> parsedItem = {};
        final List<String> keyValuePairs = item.toString().split(" > ");
        for (String pair in keyValuePairs) {
          final List<String> keyValue = pair.split(":");
          if (keyValue.length == 2) {
            parsedItem[keyValue[0].trim()] = keyValue[1].trim();
          }
        }
        return parsedItem;
      }).toList();
    } catch (e) {
      print("Error parsing data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
        title: Text(
          "BodyFatDemo",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          GestureDetector(
            onTap: () {
              getMyInfo();
            },
            child: Center(
              child: Container(
                height: 50,
                width: 150,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 212, 211, 211),
                ),
                child: Center(
                  child: Text(
                    "START SCAN",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (myInfo != null && myInfo!.isNotEmpty)
            ...myInfo!.map((item) => Column(
                  children: item.entries.map((entry) {
                    final String key = entry.key;
                    final dynamic value = entry.value;
                    return Text(
                      '$key: $value',
                      style: TextStyle(fontSize: 20),
                    );
                  }).toList(),
                )),
        ],
      ),
    );
  }
}

