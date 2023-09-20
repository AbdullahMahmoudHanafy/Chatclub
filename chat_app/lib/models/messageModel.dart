import 'package:scholar_chat/constants.dart';

class messageModel {
  final String message;

  messageModel(this.message);

  factory messageModel.fromJson(Map<String, dynamic> jsonData) {
    return messageModel(jsonData[KMessage]);
  }
}
