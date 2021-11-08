import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    var user = context.read(authenticatedUserProvider).user;

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
                      height: MediaQuery.of(context).size.width * 0.50,
                      width: MediaQuery.of(context).size.width * 0.50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1562&q=80'))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(5),
                                minimumSize: Size(5, 5)),
                            onPressed: () {},
                            child: Text(
                              "Follow",
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
                        Text(user!.data()["name"] ?? "No Name Found."),
                        SizedBox(height: 10),
                        Text(user.data()["description"] ?? "No Description Found. Try Adding one.",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
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
            TextButton(onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => UploadContent())
              );
            }, child: Text("Add New Product")),
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
                      var product = snapshot.data!.docs[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(),
                                
                        ),
                        child: Center(child: Text(product["name"] ?? "Product Name"),),
                      );
                    });
              }
            ),
          ],
        ),
      ),
    );
  }
}
