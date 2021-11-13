import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/screens/MessageConversation.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';


enum UsersListType {
  GLOBAL, PERSONAL
}

class UsersListPage extends StatefulWidget {
  const UsersListPage({ Key? key, this.type = UsersListType.GLOBAL }) : super(key: key);
  final UsersListType type;
  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {

  dynamic _getFollowButton(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index){
    return snapshot.data!.docs[index].id != context.read(authenticatedUserProvider).documentId ? IconButton(
        onPressed: () {
          FirebaseFirestore.instance.collection("follows").add({
            "users" : [context.read(authenticatedUserProvider).documentId,snapshot.data!.docs[index].id],
            "user_id" : context.read(authenticatedUserProvider).documentId,
            "following_id" : snapshot.data!.docs[index].id,
            "user" : context.read(authenticatedUserProvider).user!.data(),
            "following" : snapshot.data!.docs[index].data(),
            "created_at" : DateTime.now(),
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Following ${(snapshot.data!.docs[index].data() as dynamic)["name"]}")));
        },
        icon: Icon(Icons.person_add_alt),

      ) : null ;
  }
  Widget _getUnfollowButton(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index, BuildContext context){
    return IconButton(
        onPressed: () {
          FirebaseFirestore.instance.collection("follows").doc(snapshot.data!.docs[index].id).delete();
          setState(() {
            print("reloading");
          });
        },
        icon: Icon(Icons.person_remove_alt_1),

      );
  }

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
          widget.type == UsersListType.GLOBAL ? "Users" : "Followers",
          style: TextStyle(color: Colors.black38),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<QuerySnapshot>(
          future:  widget.type == UsersListType.GLOBAL ?
           FirebaseFirestore.instance.collection("users").get()
           : FirebaseFirestore.instance.collection("follows").where("user_id",isEqualTo: context.read(authenticatedUserProvider).documentId).get(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) return Container(child: Center(child: CircularProgressIndicator(),), color: Colors.white,);
            if(snapshot.data!.size == 0) return Container(child: Center(child: Text("No Users Found."),), color: Colors.white,);
            
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index){
                var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                
                return ListTile(
                  enabled: snapshot.data!.docs[index].id != context.read(authenticatedUserProvider).documentId,
                  trailing:  widget.type == UsersListType.GLOBAL ? _getFollowButton(snapshot, index) : _getUnfollowButton(snapshot, index, context),
                  title: Text( widget.type == UsersListType.GLOBAL ? data["name"] : data["following"]["name"]),
                  subtitle: Text(data["created_at"] != null ? "Joined ${DateFormat("dd-MM-y").format(data["created_at"] is String ? DateTime.parse(data["created_at"]) : data["created_at"].toDate())}" : "" ),
                  onTap: () async {
                    if(widget.type == UsersListType.PERSONAL){
                      DocumentReference<Map<String, dynamic>>? messageObj;

                      var existingThread = await FirebaseFirestore.instance
                      .collection("messages")
                      .where("users", arrayContainsAny: [context.read(authenticatedUserProvider).documentId, (snapshot.data!.docs[index].data() as dynamic)["following_id"]]).get();
                      // .where("users",arrayContains: (snapshot.data!.docs[index].data() as dynamic)["following_id"])
                      // .get();
                      // Logger().wtf(existingThread.docs.first.data());
                      if(existingThread.size > 0){
                        var single = existingThread.docs.where((element){
                          var users = (element.data() as dynamic)["users"] as List<dynamic>;
                          return users.contains(context.read(authenticatedUserProvider).documentId) && users.contains((snapshot.data!.docs[index].data() as dynamic)["following_id"]);
                        });
                        if(single.length > 0){
                          // Logger().wtf("${context.read(authenticatedUserProvider).documentId} | ${(snapshot.data!.docs[index].data() as dynamic)["following_id"]} | ${single.first.data()}");
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => MessageConversationPage(
                            receiverName: data["following"]["name"],
                            messageID: single.first.id,
                            users: (single.first.data() as dynamic)["users"],
                          )));
                          return;
                        }else{
                          messageObj = await FirebaseFirestore.instance.collection("messages").add({
                            "users" : [context.read(authenticatedUserProvider).documentId,(snapshot.data!.docs[index].data() as dynamic)["following_id"]],
                            "user_0" : context.read(authenticatedUserProvider).user!.data(),
                            "user_1" : (snapshot.data!.docs[index].data() as dynamic)["following"],
                            "last_message" : "Start Messaging",
                            // "last_message_at" : 
                          });
                        }
                      }else{
                        messageObj = await FirebaseFirestore.instance.collection("messages").add({
                          "users" : [context.read(authenticatedUserProvider).documentId,(snapshot.data!.docs[index].data() as dynamic)["following_id"]],
                          "user_0" : context.read(authenticatedUserProvider).user!.data(),
                          "user_1" : (snapshot.data!.docs[index].data() as dynamic)["following"],
                          "last_message" : "Start Messaging",
                          // "last_message_at" :
                        });
                      }
                      var obj = await messageObj.get();
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => MessageConversationPage(
                        receiverName: data["following"]["name"],
                        messageID: obj.id,
                        users: (obj.data() as dynamic)["users"],
                      )));
                      // FirebaseFirestore.instance.collection("messages").add({
                      //   "users" : [context.read(authenticatedUserProvider).documentId,(snapshot.data!.docs[index].data() as dynamic)["following_id"]],
                      //   "user_0" : context.read(authenticatedUserProvider).user!.data(),
                      //   "user_1" : (snapshot.data!.docs[index].data() as dynamic)["following"],
                      //   "last_message" : "Start Messaging",
                      //   // "last_message_at" : 
                      // });
                      // Logger().d({
                      //   "users" : [context.read(authenticatedUserProvider).documentId,(snapshot.data!.docs[index].data() as dynamic)["following_id"]],
                      //   "user_0" : context.read(authenticatedUserProvider).user!.data(),
                      //   "user_1" : (snapshot.data!.docs[index].data() as dynamic)["following"],
                      //   "last_message" : "Start Messaging",
                      //   // "last_message_at" : 
                      // });
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Follow ${(snapshot.data!.docs[index].data() as dynamic)["name"]} & go to followers list to start conversations")));
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}