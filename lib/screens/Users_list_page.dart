import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/screens/MessageConversation.dart';
import 'package:flutter_app103/screens/UsersProfile.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_app103/state/FollowingUsersState.dart';
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
    var following = context.read(FollowingUsersProvider).contains(snapshot.data!.docs[index].id);

    return snapshot.data!.docs[index].id != context.read(authenticatedUserProvider).documentId ? IconButton(
        onPressed: () {
          if(!following){
            FirebaseFirestore.instance.collection("follows").add({
              "users" : [context.read(authenticatedUserProvider).documentId,snapshot.data!.docs[index].id],
              "user_id" : context.read(authenticatedUserProvider).documentId,
              "following_id" : snapshot.data!.docs[index].id,
              "user" : context.read(authenticatedUserProvider).user!.data(),
              "following" : snapshot.data!.docs[index].data(),
              "created_at" : DateTime.now(),
            });
            var following = context.read(FollowingUsersProvider);
            following.add(snapshot.data!.docs[index].id);
            context.read(FollowingUsersProvider.notifier).change(following);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Following ${(snapshot.data!.docs[index].data() as dynamic)["name"]}")));
            setState(() {
              print("reloading");
            });
          }
         
        },
        icon: following ? Icon(Icons.check) : Icon(Icons.person_add_alt),

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
                    // Logger().d(data);
                    // Logger().d(snapshot.data!.docs[index].id);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (ctx) => UserProfile(
                      userid: widget.type == UsersListType.GLOBAL ? snapshot.data!.docs[index].id : data["following_id"],
                       data: data,
                      )));
                    
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