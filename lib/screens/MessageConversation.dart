import 'package:flutter/material.dart';

class MessageConversationPage extends StatefulWidget {
  const MessageConversationPage({Key? key}) : super(key: key);

  @override
  _MessageConversationState createState() => _MessageConversationState();
}

class _MessageConversationState extends State<MessageConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("COnversations"),
    );
  }
}
