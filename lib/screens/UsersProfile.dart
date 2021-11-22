import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/screens/MapScreen.dart';
import 'package:flutter_app103/screens/MessageConversation.dart';
import 'package:flutter_app103/screens/OrdersPage.dart';
import 'package:flutter_app103/screens/ProductPage.dart';
import 'package:flutter_app103/screens/ProfileEdit.dart';
import 'package:flutter_app103/screens/Users_list_page.dart';
import 'package:flutter_app103/screens/upload_content.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key, required this.userid, this.type = UsersListType.GLOBAL, required this.data}) : super(key: key);
  final String userid;
  final UsersListType type;
  final Map<String, dynamic> data;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {


    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("users").doc(widget.userid).get(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if(snapshot.hasError) return Container(
            child: Center(
              child: Text("Something Went wrong"),
            ),
          );
          var user = snapshot.data!.data() as dynamic;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.black,
                ),
              ),
              title: Text(
                "Profile of ${user["name"]}",
                style: TextStyle(color: Colors.black38),
              ),
              actions: [
                Icon(
                  CupertinoIcons.cart,
                  color: Colors.black,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // height: MediaQuery.of(context).size.width * 0.50,
                            // width: MediaQuery.of(context).size.width * 0.50,
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    image: user["image"] != null ?
                                    NetworkImage(user.data()["image"]) 
                                    : NetworkImage(
                                      'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1562&q=80'
                                    ),
                                  ),
                                ),
                                // child: user!.data()["image"] != null ?
                                //     Image.network(user.data()["image"]) 
                                //     : Image.network(
                                //       'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1562&q=80',
                                //     ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          //     ElevatedButton(
                          //         style: ElevatedButton.styleFrom(
                          //             padding: EdgeInsets.all(5),
                          //             minimumSize: Size(5, 5)),
                          //         onPressed: () {
                          //           Navigator.push(context, MaterialPageRoute(builder: (ctx) => UsersListPage(type : UsersListType.PERSONAL)));
                          //         },
                          //         child: Text(
                          //           "Followers",
                          //           style: TextStyle(),
                          //         )),
                          //     // SizedBox(width: 10),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(5),
                                      minimumSize: Size(5, 5)),
                                  onPressed: () async {
                                    // if(widget.type == UsersListType.PERSONAL){
                      DocumentReference<Map<String, dynamic>>? messageObj;

                      var existingThread = await FirebaseFirestore.instance
                      .collection("messages")
                      .where("users", arrayContainsAny: [context.read(authenticatedUserProvider).documentId, widget.data["following_id"]]).get();
                      // .where("users",arrayContains: (snapshot.data!.docs[index].data() as dynamic)["following_id"])
                      // .get();
                      // Logger().wtf(existingThread.docs.first.data());
                      if(existingThread.size > 0){
                        var single = existingThread.docs.where((element){
                          var users = (element.data() as dynamic)["users"] as List<dynamic>;
                          return users.contains(context.read(authenticatedUserProvider).documentId) && users.contains(widget.data["following_id"]);
                        });
                        if(single.length > 0){
                          // Logger().wtf("${context.read(authenticatedUserProvider).documentId} | ${(snapshot.data!.docs[index].data() as dynamic)["following_id"]} | ${single.first.data()}");
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => MessageConversationPage(
                            receiverName: widget.data["following"]["name"],
                            messageID: single.first.id,
                            users: (single.first.data() as dynamic)["users"],
                          )));
                          return;
                        }else{
                          messageObj = await FirebaseFirestore.instance.collection("messages").add({
                            "users" : [context.read(authenticatedUserProvider).documentId,widget.data["following_id"]],
                            "user_0" : context.read(authenticatedUserProvider).user!.data(),
                            "user_1" : widget.data["following"],
                            "last_message" : "Start Messaging",
                            // "last_message_at" : 
                          });
                        }
                      }else{
                        messageObj = await FirebaseFirestore.instance.collection("messages").add({
                          "users" : [context.read(authenticatedUserProvider).documentId,widget.data["following_id"]],
                          "user_0" : context.read(authenticatedUserProvider).user!.data(),
                          "user_1" : widget.data["following"],
                          "last_message" : "Start Messaging",
                          // "last_message_at" :
                        });
                      }
                      var obj = await messageObj.get();
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => MessageConversationPage(
                        receiverName: widget.data["following"]["name"],
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
                    // }else{
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Follow ${widget.data["name"]} & go to followers list to start conversations")));
                    // }
                                  },
                                  child: Text(
                                    "Message",
                                    style: TextStyle(),
                                  )),
                          //     // SizedBox(width: 10),
                          if(user["latitude"] != null && user["longitude"] != null)
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(5),
                                      minimumSize: Size(5, 5)),
                                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => MapScreen(initalPosition: LatLng(user["latitude"] ,user["longitude"]),))),
                                  child: Text(
                                    "Location",
                                    style: TextStyle(),
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: 220,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.indigo[100],
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user["name"] ?? "No Name Found.",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text(user["category"] ?? "",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                              Text(user["location"] ?? "",style: TextStyle( fontWeight: FontWeight.w300),),
                              SizedBox(height: 10),
                              Text(
                                user["bio"] ?? "",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                              ),
                              // SizedBox(height: 10),
                              // Text(
                              //     "Welcome to the clothing shop,i started this venture 4 years ago. "),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text("${user["name"]}'s Products",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                  Divider(),
                  // Row(
                  //   children: [
                  //     TextButton(onPressed: (){
                  //       Navigator.of(context).push(
                  //         MaterialPageRoute(builder: (ctx) => UploadContent())
                  //       );
                  //     },
                  //     child: Text("Add New Product"),
                  //     ),
                  //     Spacer(),
                  //     TextButton(onPressed: (){
                  //       Navigator.of(context).push(
                  //         MaterialPageRoute(builder: (ctx) => OrdersPage(viewer: Viewer.SELLER,))
                  //       );
                  //     },
                  //     child: Text("Shop Orders"),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 10),
                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection("/products").where("owner",isEqualTo: widget.userid).get(),
                    builder: (context,snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) return Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: double.infinity,
                        child: Center(child: CircularProgressIndicator(),),
                      );
                      // Logger().w(snapshot.data?.docs.length);
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                              childAspectRatio: 5 / 6),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            var product = snapshot.data!.docs[index].data() as dynamic;
                            return InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => ProductPage(product: product,productID: snapshot.data!.docs[index].id,))),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(),
                                    image: DecorationImage(
                                      image: NetworkImage(product["image"] ?? "https://via.placeholder.com/150"),
                                      fit: BoxFit.fill
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                                      ),
                                      child: Column(
                                        
                                        children: [
                                          Text(product["name"] ?? "Product Name"),
                                          Text((product["price"] ?? "" )+ " TK"),
                                    
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
