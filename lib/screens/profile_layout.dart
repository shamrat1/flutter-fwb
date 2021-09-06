import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileLayout extends StatefulWidget {
  ProfileLayout({Key? key}) : super(key: key);

  @override
  _ProfileLayoutState createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          CupertinoIcons.arrow_left,
          color: Colors.black,
        ),
        title: Text(
          "FEMALEPRENEURE BAZAAR",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1562&q=80'))),
                    ),
                    Row(
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
                        SizedBox(width: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(5),
                                minimumSize: Size(5, 5)),
                            onPressed: () {},
                            child: Text(
                              "Message",
                              style: TextStyle(),
                            )),
                        SizedBox(width: 10),
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
                    //   width: double.infinity,
                    height: 220,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.indigo[100],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Amirah"),
                        SizedBox(height: 10),
                        Text("Clothing Brand\n High quality fashion label"),
                        SizedBox(height: 10),
                        Text(
                            "Welcome to the clothing shop,i started this venture 4 years ago. "),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 5 / 6),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
