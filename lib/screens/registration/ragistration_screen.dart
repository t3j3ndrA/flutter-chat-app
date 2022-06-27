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

import '../../modelAndServices/conversations.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final LoggedInUser newUser = Provider.of<LoggedInUser>(context);
    bool isLoading = false;
    return Scaffold(
        appBar: AppBar(title: Text('Registration')),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  decoration:
                      getInputDecoration().copyWith(labelText: 'First Name'),
                  validator: (val) {
                    return val == '' ? 'First-name cannot be empty' : null;
                  },
                  onChanged: (val) => setState(() {
                    newUser.firstName = val;
                  }),
                ),
                getTopPadding(),
                TextFormField(
                    decoration:
                        getInputDecoration().copyWith(labelText: 'Last Name'),
                    validator: (val) {
                      return val == '' ? 'Last-name cannot be empty' : null;
                    },
                    onChanged: (val) => setState(() {
                          newUser.lastName = val;
                        })),
                getTopPadding(),
                TextFormField(
                    decoration:
                        getInputDecoration().copyWith(labelText: 'E-mail'),
                    validator: (val) {
                      return val == '' ? 'E-mail cannot be empty' : null;
                    },
                    onChanged: (val) => setState(() {
                          newUser.eMail = val;
                        })),
                getTopPadding(),
                TextFormField(
                    obscureText: true,
                    decoration:
                        getInputDecoration().copyWith(labelText: 'Password'),
                    validator: (val) {
                      return val == '' ? 'Password cannot be empty' : null;
                    },
                    onChanged: (val) => setState(() {
                          newUser.password = val;
                        })),
                getTopPadding(),
                ElevatedButton(
                    style: getButtonStyle(),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        final isRegistrationSuccesful = await newUser
                            .registerUserWithEmailAndPassword(newUser);
                        setState(() {
                          isLoading = false;
                        });
                        if (isRegistrationSuccesful) {
                          final conversations = Provider.of<Conversations>(
                              context,
                              listen: false);

                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false);
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Center(
                        child: !isLoading
                            ? Text('Register',
                                style:
                                    MyThemeData().getTheme().textTheme.button)
                            : LoadingSpinner(),
                      ),
                    )),
              ]),
            ),
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