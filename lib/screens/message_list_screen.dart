import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/message/message.dart';
import 'package:flutter_app103/screens/MessageConversation.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class MessagesPage extends StatefulWidget {
  MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black38,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Message",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
            .collection("messages")
            .where("users", arrayContains: context.read(authenticatedUserProvider).documentId)
            .snapshots(),
          builder: (context,snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) return Container(child: Center(child: CircularProgressIndicator(),), color: Colors.white,);
            if(snapshot.data!.size == 0) return Container(child: Center(child: Text("No Messages Yet."),), color: Colors.white,);
            return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  var message = snapshot.data!.docs[index];
                  var data = message.data() as Map<String, dynamic>;
                  var userIndex = data["users"].indexOf(context.read(authenticatedUserProvider).documentId!);
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => MessageConversationPage(
                          messageID: snapshot.data!.docs[index].id,
                          receiverName: data["user_${userIndex == 1 ? 0 : 1}"]["name"],
                          users: data["users"],
                        ))
                      );
                    },
                    title: Text(data["user_${userIndex == 1 ? 0 : 1}"]["name"]),
                    subtitle: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .55,
                          child: Text(
                            data["last_message"],
                            style: TextStyle(color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Spacer(),
                        if(data["last_message_at"] != null)
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * .30,
                          child: Text(
                            DateFormat.yMMMMEEEEd()
                                .format(data["last_message_at"].toDate())
                                .toString(),
                            style: TextStyle(fontSize: 8, color: Color(0x50000000)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    // isThreeLine: true,
                  );
                  
                });
          }
        ),
      ),
    );
  }
}
