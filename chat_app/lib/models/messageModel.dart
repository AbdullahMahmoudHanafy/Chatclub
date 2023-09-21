import 'package:scholar_chat/constants.dart';

class messageModel {
  final String message;
  final String id;

  messageModel(this.message, this.id);

  factory messageModel.fromJson(jsonData) {
    return messageModel(jsonData[KMessage], jsonData[kId]);
  }
}
