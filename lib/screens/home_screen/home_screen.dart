import 'package:chat_application/modelAndServices/conversations.dart';
import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/theme/theme.dart';
import 'package:chat_application/utils/bottomSheetNewConversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final LoggedInUser loggedInUser = Provider.of<LoggedInUser>(context);
    final Conversations conversations = Provider.of<Conversations>(context);
    final homeList =
        Provider.of<Conversations>(context).homeScreenAllMessagesList;
    print('from home : ');
    print(homeList);
    // conversations.listenForAllConversations(
    //     loggedInUser: loggedInUser, conversations: conversations);

    final showNewChatModel = () {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return NewConversationSheet();
          });
    };
    return Scaffold(
        floatingActionButton: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: MyThemeData().titlePurple),
          child: IconButton(
              onPressed: () {
                showNewChatModel();
              },
              iconSize: 30,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              )),
        ),
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
        body: ListView.builder(
          itemCount: conversations.homeScreenAllMessagesList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  '${conversations.homeScreenAllMessagesList[index]['firstName']}'),
            );
          },
        ));
  }
}
