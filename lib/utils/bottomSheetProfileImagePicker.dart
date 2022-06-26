import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'imagePickerFunctions.dart';

class BottomSheetImagPicker extends StatelessWidget {
  final loggedInUser;
  const BottomSheetImagPicker({Key? key, required this.loggedInUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      child: Column(
        children: [
          Center(
              child: Text(
            'Profile Photo',
            style: TextStyle(fontSize: 24),
          )),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    galleryImagePickedAction(loggedInUser);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.browse_gallery_rounded),
                  iconSize: 40,
                ),
                Text('Gallery')
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    cameraImagePickedAction(loggedInUser);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.camera),
                  iconSize: 40,
                ),
                Text('Camera')
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
