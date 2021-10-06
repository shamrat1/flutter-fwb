import 'dart:convert';

import 'message.dart';

ChatBlocks chatFromJson(String str) => ChatBlocks.fromJson(json.decode(str));

String chatToJson(ChatBlocks data) => json.encode(data.toJson());

class ChatBlocks {
  ChatBlocks(
    this.chatBlockId,
    this.user1,
    this.user2,
    this.message,
  );

  String chatBlockId;
  String user1;
  String user2;
  List<Message> message;

  factory ChatBlocks.fromJson(Map<String, dynamic> json) => ChatBlocks(
        json["chat_id"],
        json["user_1"],
        json["user_2"],
        List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chat_id": chatBlockId,
        "user_1": user1,
        "user_2": user2,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}
