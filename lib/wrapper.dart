import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/screens/home_screen/home_screen.dart';
import 'package:chat_application/screens/signIn/signIn.dart';
import 'package:chat_application/screens/user_profile/userProfile.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modelAndServices/loggedInUser.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LoggedInUser loggedInUser = Provider.of<LoggedInUser>(context);
    if (loggedInUser.uid == '') {
      return SignInScreen();
    } else
      return HomeScreen();
  }
}
