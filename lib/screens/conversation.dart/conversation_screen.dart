import 'package:chat_application/modelAndServices/conversations.dart';
import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/theme/inputDecoration.dart';
import 'package:chat_application/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../modelAndServices/messageModel.dart';

class ConversationScreen extends StatefulWidget {
  ConversationScreen({Key? key}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  String messageValue = '';
  final fieldText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final user = arguments['user'];
    final Conversations conversations = Provider.of<Conversations>(context);
    final messages =
        conversations.allConversations[user['uid']]!.reversed.toList();

    Message newMsg = Provider.of<Message>(context);
    newMsg.sendersUid = conversations.loggedInUserId;
    newMsg.reciversUid = user['uid'];

    print('Screen Built....');

    final ScrollController _controller = ScrollController();
    void _scrollDown() {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    }

    return Scaffold(
        body: Container(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Navigation Bar + User Profile
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 248, 248, 248),
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        iconSize: 30,
                        color: MyThemeData().titlePurple,
                        icon: Icon(
                          Icons.arrow_back,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                        radius: 14,
                        foregroundImage: NetworkImage(user['avatarImage'])),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${user['firstName'] + user['lastName']}',
                      style: TextStyle(
                          color: MyThemeData().titlePurple, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            //List of all Conversations...
            Expanded(
              child: ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messages!.length ?? 0,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: messages[index]['sendersUid'] == user['uid']
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                          decoration: BoxDecoration(
                            color: messages[index]['sendersUid'] == user['uid']
                                ? Colors.white
                                : Color.fromARGB(255, 241, 241, 241),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(60, 60)),
                          ),
                          child: Text(
                            messages[index]['message'],
                          )),
                    );
                  }),
            ),

            // Message Input and sender
            Container(
              margin: const EdgeInsets.fromLTRB(8, 10, 8, 5),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.all(Radius.elliptical(60, 60)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: fieldText,
                      // initialValue: newMsg.message,
                      onChanged: (val) {
                        newMsg.message = val;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.keyboard,
                            size: 30,
                          ),
                          hintText: 'Type here...'),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (newMsg.message != '') {
                          conversations.sendNewMessage(message: newMsg);
                          newMsg.message = '';
                          fieldText.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
