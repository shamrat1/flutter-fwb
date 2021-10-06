import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message(
    this.senderId,
    this.message,
    this.timestamp,
  );

  String senderId;
  String message;
  String timestamp;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        json["sender_id"],
        json["message"],
        json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "sender_id": senderId,
        "message": message,
        "timestamp": timestamp,
      };
}
