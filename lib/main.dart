import 'package:chat_application/modelAndServices/conversations.dart';
import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/screens/registration/ragistration_screen.dart';
import 'package:chat_application/screens/signIn/signIn.dart';
import 'package:chat_application/screens/user_profile/fakeUser.dart';
import 'package:chat_application/screens/user_profile/userProfile.dart';
import 'package:chat_application/theme/theme.dart';
import 'package:chat_application/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:chat_application/screens/home_screen/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'modelAndServices/loggedInUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainWidget());
}

class MainWidget extends StatelessWidget {
  MainWidget({Key? key}) : super(key: key);
  final LoggedInUser loggedInUser = LoggedInUser();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoggedInUser>.value(value: loggedInUser),
        ChangeNotifierProvider<Conversations>.value(value: Conversations()),
      ],
      child: MaterialApp(
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
          '/fakeProfile': (context) => FakeProfile(
                loggedInUser: loggedInUser,
              ),
        },
        home: Wrapper(),
      ),
    );
  }
}
