import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/theme/inputDecoration.dart';
import 'package:chat_application/theme/theme.dart';
import 'package:chat_application/utils/bottomSheetProfileImagePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../utils/spinner.dart';

class UserProfile extends StatefulWidget {
  LoggedInUser loggedInUser;
  UserProfile({Key? key, required this.loggedInUser}) : super(key: key);
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isLoading = false;
  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    final handleDataUpdate = (value) async {
      setState(() {
        isLoading = true;
      });
      await value.updateUserData(value);
      setState(() {
        isLoading = false;
      });
    };
    void _showBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheetImagPicker(loggedInUser: widget.loggedInUser);
          });
    }

    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: widget.loggedInUser)],
      child: Consumer<LoggedInUser>(
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              appBar: AppBar(
                  title: Text('Welcome ${widget.loggedInUser.firstName}')),
              body: Container(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                  child: Form(
                      child: Column(
                    children: [
                      Stack(children: [
                        Center(
                          child: CircleAvatar(
                            foregroundImage: NetworkImage(value.avatarImage),
                            radius: 50,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: ((MediaQuery.of(context).size.width) / 2)
                              .toDouble(),
                          child: IconButton(
                            icon: Icon(
                              Icons.image,
                              color: MyThemeData().titlePurple,
                              size: 38,
                            ),
                            onPressed: () async {
                              _showBottomSheet();
                            },
                          ),
                        )
                      ]),
                      SizedBox(height: 45),
                      TextFormField(
                        initialValue: value.firstName,
                        decoration: getInputDecoration()
                            .copyWith(labelText: 'First Name'),
                        onChanged: (val) => setState(() {
                          value.firstName = val;
                        }),
                        validator: (val) =>
                            val == '' ? 'First Name cannot be empty' : null,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: value.lastName,
                        decoration: getInputDecoration()
                            .copyWith(labelText: 'Last Name'),
                        onChanged: (val) => setState(() {
                          value.lastName = val;
                        }),
                        validator: (val) =>
                            val == '' ? 'Last Name cannot be empty' : null,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                          style: getButtonStyle(),
                          onPressed: () async {
                            await handleDataUpdate(value);
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Center(
                              child: !isLoading
                                  ? Text('Update',
                                      style: MyThemeData()
                                          .getTheme()
                                          .textTheme
                                          .button)
                                  : LoadingSpinner(),
                            ),
                          )),
                    ],
                  ))),
            ),
          );
        },
      ),
    );
  }
}
