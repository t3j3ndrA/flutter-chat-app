import 'package:chat_application/modelAndServices/conversations.dart';
import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/utils/spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/inputDecoration.dart';
import '../theme/theme.dart';

class NewConversationSheet extends StatefulWidget {
  const NewConversationSheet({Key? key}) : super(key: key);
  @override
  State<NewConversationSheet> createState() => _NewConversationSheetState();
}

class _NewConversationSheetState extends State<NewConversationSheet> {
  bool isLoading = false;
  bool isKeyBoardFocused = false;
  String email = '';
  @override
  Widget build(BuildContext context) {
    final LoggedInUser loggedInUser = Provider.of<LoggedInUser>(context);

    return Container(
      height: !isKeyBoardFocused ? 260 : 800,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(children: [
        Text('New Conversation',
            style: TextStyle(color: MyThemeData().titlePurple, fontSize: 28)),
        SizedBox(
          height: 40,
        ),
        TextFormField(
          decoration: getInputDecoration().copyWith(labelText: 'E-mail'),
          onEditingComplete: () {
            setState(() {
              isKeyBoardFocused = false;
              FocusScope.of(context).requestFocus(new FocusNode());
            });
          },
          onTap: () {
            setState(() {
              isKeyBoardFocused = true;
            });
          },
          onChanged: (val) {
            setState(() {
              email = val;
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
            style: getButtonStyle(),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await Conversations().startNewConversationByEmail(
                  loggedInUser: loggedInUser, recieversEmail: email);
              setState(() {
                isLoading = false;
              });
            },
            child: Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Center(
                child: !isLoading
                    ? Text('Start Conversation',
                        style: MyThemeData().getTheme().textTheme.button)
                    : LoadingSpinner(),
              ),
            )),
      ]),
    );
  }
}
