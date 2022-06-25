import 'package:chat_application/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/userProfile');
              },
              icon: Icon(
                Icons.person,
              ))
        ],
      ),
      body: Container(
        child: Text('hii'),
      ),
    );
  }
}

// Container(
//         child: Stack(children: [
//           Column(
//             children: [
//               TopNavigationBar(),
//               UsersList(),
//               BottomNavigationBar(),
//             ],
//           ),
//           Positioned(
//             bottom: 60,
//             right: 20,
//             child: Container(
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.red),
//                   borderRadius: BorderRadius.circular(1000)),
//               child: Icon(
//                 Icons.abc,
//                 size: 40,
//               ),
//             ),
//           ),
//         ]),
//       ),
class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: MediaQuery.of(context).size.width,
        child: Expanded(
      child: ListView.builder(
          itemCount: 80,
          itemBuilder: (context, index) {
            return Text('${index} Index.');
          }),
    ));
  }
}

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        child: Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Messanzer',
            style: TextStyle(fontSize: 24),
          ),
          Icon(Icons.portable_wifi_off_outlined),
          Icon(Icons.wifi),
        ],
      ),
    ));
  }
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        width: MediaQuery.of(context).size.width,
        child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.yellow)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.home,
                  size: 36,
                ),
                Icon(
                  Icons.search,
                  size: 36,
                ),
                Icon(
                  Icons.save,
                  size: 36,
                ),
                Icon(
                  Icons.person,
                  size: 36,
                ),
              ],
            )));
  }
}
