import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/screens/OrdersPage.dart';
import 'package:flutter_app103/screens/ProductPage.dart';
import 'package:flutter_app103/screens/ProfileEdit.dart';
import 'package:flutter_app103/screens/Users_list_page.dart';
import 'package:flutter_app103/screens/upload_content.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ProfileLayout extends StatefulWidget {
  ProfileLayout({Key? key}) : super(key: key);


  @override
  _ProfileLayoutState createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: Icon(
      //     CupertinoIcons.arrow_left,
      //     color: Colors.black,
      //   ),
      //   title: Text(
      //     "FEMALEPRENEURE BAZAAR",
      //     style: TextStyle(color: Colors.black38),
      //   ),
      //   actions: [
      //     Icon(
      //       CupertinoIcons.cart,
      //       color: Colors.black,
      //     ),
      //   ],
      // ),
      body: Consumer(

        builder: (context, watch, child) {
              var userProvider = watch(authenticatedUserProvider);
              var user = userProvider.user;

          return Padding(
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
                        Stack(
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
                                      image: user!.data()["image"] != null ?
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
                            Positioned(
                              top: 0,
                              right: -60,

                              child: Container(
                                width: 180,
                                // padding: EdgeInsets,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black38
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.all(3),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => ProfileEdit()));
                                  },
                                icon: Icon(Icons.edit, color: Colors.white,)),
                                    
                                
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(5),
                                    minimumSize: Size(5, 5)),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => UsersListPage(type : UsersListType.PERSONAL)));
                                },
                                child: Text(
                                  "Followers",
                                  style: TextStyle(),
                                )),
                            // SizedBox(width: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(5),
                                    minimumSize: Size(5, 5)),
                                onPressed: () {},
                                child: Text(
                                  "Message",
                                  style: TextStyle(),
                                )),
                            // SizedBox(width: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(5),
                                    minimumSize: Size(5, 5)),
                                onPressed: () {},
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
                            Text(user.data()["name"] ?? "No Name Found.",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                            Text(user.data()["category"] ?? "No Name Found.",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                            Text(user.data()["location"] ?? "No Name Found.",style: TextStyle( fontWeight: FontWeight.w300),),
                            SizedBox(height: 10),
                            Text(
                              user.data()["bio"] ?? "No Description Found. Try Adding one.",
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
                SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => UploadContent())
                      );
                    },
                    child: Text("Add New Product"),
                    ),
                    Spacer(),
                    TextButton(onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => OrdersPage(viewer: Viewer.SELLER,))
                      );
                    },
                    child: Text("Shop Orders"),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection("/products").where("owner",isEqualTo: user.id).get(),
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
          );
        }
      ),
    );
  }
}
