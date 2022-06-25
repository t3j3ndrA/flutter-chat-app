import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/utils/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../../theme/inputDecoration.dart';
import '../../theme/theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final LoggedInUser loggedInUser = Provider.of<LoggedInUser>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Sign In')),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            child: Column(children: [
              TextFormField(
                  decoration:
                      getInputDecoration().copyWith(labelText: 'E-mail'),
                  onChanged: (val) => setState(() {
                        loggedInUser.eMail = val;
                      })),
              getTopPadding(),
              TextFormField(
                  obscureText: true,
                  decoration:
                      getInputDecoration().copyWith(labelText: 'Password'),
                  onChanged: (val) => setState(() {
                        loggedInUser.password = val;
                      })),
              getTopPadding(),
              ElevatedButton(
                  style: getButtonStyle(),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final isLoggedInSuccess = await loggedInUser
                        .signInWithEmailAndPassword(loggedInUser);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: 130,
                    child: Center(
                      child: !isLoading
                          ? Text('Sign In',
                              style: MyThemeData().getTheme().textTheme.button)
                          : LoadingSpinner(),
                    ),
                  )),
            ]),
          ),
        ));
  }
}
