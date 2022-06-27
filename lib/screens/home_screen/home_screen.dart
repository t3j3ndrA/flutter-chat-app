import 'package:chat_application/modelAndServices/conversations.dart';
import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/modelAndServices/messageService.dart';
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
    final Conversations conversations = Provider.of<Conversations>(context);
    final allUsersList = conversations.homeScreenAllMessagesList;
    final allConversations = conversations.allConversations;
    showNewChatModel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return const NewConversationSheet();
          });
    }

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
          itemCount: allUsersList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/userConversation',
                          arguments: {
                            'user': allUsersList[index],
                          });
                    },
                    leading: CircleAvatar(
                      foregroundImage:
                          NetworkImage(allUsersList[index]['avatarImage']),
                      radius: 30,
                    ),
                    minVerticalPadding: 4,
                    subtitle: allConversations[allUsersList[index]['uid']]
                                .length >
                            0
                        ? Text(
                            '${allConversations[allUsersList[index]['uid']][allConversations[allUsersList[index]['uid']].length - 1]['message']}')
                        : Text(''),
                    title: Text(
                        '${allUsersList[index]['firstName'] + " " + allUsersList[index]['lastName']}'),
                  ),
                  Divider(
                    color: MyThemeData().placeHolderColor,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
