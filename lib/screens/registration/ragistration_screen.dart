import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/theme/inputDecoration.dart';
import 'package:chat_application/theme/theme.dart';
import 'package:chat_application/utils/spinner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final LoggedInUser newUser = Provider.of<LoggedInUser>(context);
    bool isLoading = false;
    return Scaffold(
        appBar: AppBar(title: Text('Registration')),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            child: Column(children: [
              TextFormField(
                decoration:
                    getInputDecoration().copyWith(labelText: 'First Name'),
                onChanged: (val) => setState(() {
                  newUser.firstName = val;
                }),
              ),
              getTopPadding(),
              TextFormField(
                  decoration:
                      getInputDecoration().copyWith(labelText: 'Last Name'),
                  onChanged: (val) => setState(() {
                        newUser.lastName = val;
                      })),
              getTopPadding(),
              TextFormField(
                  decoration:
                      getInputDecoration().copyWith(labelText: 'E-mail'),
                  onChanged: (val) => setState(() {
                        newUser.eMail = val;
                      })),
              getTopPadding(),
              TextFormField(
                  obscureText: true,
                  decoration:
                      getInputDecoration().copyWith(labelText: 'Password'),
                  onChanged: (val) => setState(() {
                        newUser.password = val;
                      })),
              getTopPadding(),
              ElevatedButton(
                  style: getButtonStyle(),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final isRegistrationSuccesful =
                        await newUser.registerUserWithEmailAndPassword(newUser);
                    setState(() {
                      isLoading = false;
                    });
                    if (isRegistrationSuccesful) {
                      Navigator.pushNamed(context, '/signIn');
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: 130,
                    child: Center(
                      child: isLoading
                          ? Text('Register',
                              style: MyThemeData().getTheme().textTheme.button)
                          : LoadingSpinner(),
                    ),
                  )),
            ]),
          ),
        ));
  }
}

              // ElevatedButton(
              //     style: getButtonStyle(),
              //     onPressed: () {},
              //     child: Container(
              //       padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              //       width: 130,
              //       child: Center(
              //         child: Text('Pick Image',
              //             style: MyThemeData().getTheme().textTheme.button),
              //       ),
              //     )),