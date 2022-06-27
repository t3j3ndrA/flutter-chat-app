import 'package:chat_application/modelAndServices/conversations.dart';
import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/screens/conversation.dart/conversation_screen.dart';
import 'package:chat_application/screens/home_screen/home_screen.dart';
import 'package:chat_application/screens/registration/ragistration_screen.dart';
import 'package:chat_application/screens/signIn/signIn.dart';
import 'package:chat_application/screens/user_profile/userProfile.dart';
import 'package:chat_application/theme/theme.dart';
import 'package:chat_application/wrapper.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  Widget build(BuildContext context) {
    final LoggedInUser loggedInUser = Provider.of<LoggedInUser>(context);
    final Conversations conversations = Provider.of<Conversations>(context);

    if (loggedInUser.uid != '' && conversations.loggedInUserId == '') {
      Provider.of<Conversations>(context)
          .updateLoggedInId(newId: loggedInUser.uid);
    }

    return MaterialApp(
      theme: MyThemeData().getTheme().copyWith(
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/wrapper': (context) => const Wrapper(),
        '/register': (context) => const RegistrationScreen(),
        '/signIn': (context) => const SignInScreen(),
        '/userProfile': (context) => UserProfile(
              loggedInUser: loggedInUser,
            ),
        '/userConversation': (context) => ConversationScreen(),
      },
      home: Wrapper(),
    );
  }
}
