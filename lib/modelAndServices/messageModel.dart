import 'package:flutter/cupertino.dart';

class Message extends ChangeNotifier {
  String message = '';
  // To be implement
  // types can be TEXT, IMAGE, STICKER, VIDEO
  String type = 'text';
  String sendersUid = '';
  String reciversUid = '';
}
