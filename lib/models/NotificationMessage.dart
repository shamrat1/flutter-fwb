import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final messageListProvider = StateNotifierProvider<MessageList,List<NotificationMessage>>((ref) => MessageList([]));


@immutable
class NotificationMessage {
  final String id;
  final String title;
  final String body;

  const NotificationMessage({
    required this.id,
    required this.title,
    required this.body,
  });

  factory NotificationMessage.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final title = json['title'];
    final body = json['body'];

    return NotificationMessage(
      id: id,
      title: title,
      body: body,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

class MessageList extends StateNotifier<List<NotificationMessage>> {
  MessageList(List<NotificationMessage> state) : super(state);

  void addAll(List<NotificationMessage> messages){
    state.addAll(messages);
  }

  void add(NotificationMessage message) {
    state = [...state, message];
  }

  void remove(NotificationMessage removeItem) {
    state = state.where((message) => message.id != removeItem.id).toList();
  }

  void removeAll() {
    state = [];
  }
}
