import 'package:chat_application/modelAndServices/conversations.dart';
import 'package:chat_application/theme/inputDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  ConversationScreen({Key? key}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final user = arguments['user'];
    final Conversations conversations = Provider.of<Conversations>(context);
    final messages = conversations.allConversations[user['uid']];
    print('from Messages : ');
    print(messages);

    return Scaffold(
        body: Container(
      child: Form(
        child: Column(
          children: [
            // Top Navigation Bar + User Profile
            SafeArea(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back)),
                ],
              ),
            ),

            //List of all Conversations...
            Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) => Text('${index}'))),

            // Message Input and sender
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        // enabledBorder: OutlineInputBorder(
                        enabledBorder: null,
                        // borderSide: BorderSide(width: 0)),
                        prefixIcon: Icon(
                          Icons.keyboard,
                          size: 30,
                        ),
                        hintText: 'Type here...'),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.send)),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
