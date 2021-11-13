import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageConversationPage extends StatefulWidget {
  const MessageConversationPage({Key? key, required this.messageID,required this.users, required this.receiverName}) : super(key: key);
  final String messageID;
  final String receiverName;
  final List<dynamic> users;
  @override
  _MessageConversationState createState() => _MessageConversationState();
}

class _MessageConversationState extends State<MessageConversationPage> {

  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black38,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${widget.receiverName}'s Messages ",
          style: TextStyle(color: Colors.black38),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              Container(
                // child: ,
                height: MediaQuery.of(context).size.height * .75,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("conversations").where("message_id",isEqualTo: widget.messageID).orderBy("sent_at",descending: true).snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) return Container(child: Center(child: CircularProgressIndicator(),), color: Colors.white,);
                    if(snapshot.hasData){
                      if(snapshot.data!.size == 0) return Container(child: Center(child: Text("Start Messaging"),), color: Colors.white,);
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        reverse: true,
                        itemBuilder: (context, index){
                          var data = snapshot.data!.docs[index].data() as dynamic;
                          var userINdex = widget.users.indexOf(context.read(authenticatedUserProvider).documentId!);
                          // bool isCurrentUser = ;
                          // Logger().w("$userINdex | ${data["sent_by"]}");
                          return _getMessageView(data, userINdex == data["sent_by"]);
                        }
                      );
                    }
                    if(snapshot.hasError){
                      return Text(snapshot.error.toString());
                    }
                    return Container();
                  }
                ),
              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                    label: Text("Message"),
                    hintText: "Type message here",
                    suffix: IconButton(icon: Icon(Icons.send),onPressed: () => _sendMessage(),
                  ),
                ),
                onFieldSubmitted: (value) => _sendMessage(),
                maxLines: 1
              ),
            ],
          ),
        ),
      ),
    );

  }

  Widget _getMessageView(dynamic data,bool byCurrentUser){
    return Container(
      margin: byCurrentUser ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: MediaQuery.of(context).size.width * .20) : EdgeInsets.only(top: 8.0, bottom: 8.0, right: MediaQuery.of(context).size.width * .20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xffdbdbdb))
      ),
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * .40,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( byCurrentUser ? "Me" : widget.receiverName ,
            style: TextStyle(fontSize: 8, color: Color(0x70000000)),
          ),
          Text(data["message"]),
          SizedBox(height: 5,),
          Text(DateFormat("hh:mm a dd-MM-yyyy")
            .format(data["sent_at"].toDate())
            .toString(),
            style: TextStyle(fontSize: 8, color: Color(0x50000000)),
          )
        ],
      ),
    );
  }

  void _sendMessage(){

    var userINdex = widget.users.indexOf(context.read(authenticatedUserProvider).documentId!);

    FirebaseFirestore.instance.collection("conversations").add({
      "message" : _messageController.text,
      "message_id" : widget.messageID,
      "sent_at" : DateTime.now(),
      "sent_by" : userINdex
    });

    FirebaseFirestore.instance.collection("messages").doc(widget.messageID).update({
      "last_message" : _messageController.text,
      "last_message_at" : DateTime.now(),

    });

    setState(() {
      _messageController.text = "";
    });
  }
}
