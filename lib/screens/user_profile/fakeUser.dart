import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FakeProfile extends StatefulWidget {
  LoggedInUser loggedInUser;
  FakeProfile({Key? key, required this.loggedInUser}) : super(key: key);
  @override
  State<FakeProfile> createState() => _FakeProfileState();
}

class _FakeProfileState extends State<FakeProfile> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoggedInUser>.value(value: widget.loggedInUser)
      ],
      child: Consumer<LoggedInUser>(builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Text(value.firstName),
        );
      }),
    );
  }
}
