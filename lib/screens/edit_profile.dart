import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/common/demo_image_list.dart';
import 'package:flutter_app103/screens/upload_content.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (int val) {
          setState(() {
            currentIndex = val;
          });
          //returns tab id which is user tapped
        },
        currentIndex: currentIndex,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
          FloatingNavbarItem(icon: Icons.favorite, title: 'Favourite'),
          FloatingNavbarItem(
              icon: Icons.verified_user_rounded, title: 'Profile'),
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
                                  'https://ak.picdn.net/shutterstock/videos/1018702984/thumb/10.jpg'))),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(5),
                                minimumSize: Size(5, 5)),
                            onPressed: () {},
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(),
                            )),
                        SizedBox(width: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(5),
                                minimumSize: Size(5, 5)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UploadContent()));
                            },
                            child: Text(
                              "Upload Product",
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
                itemCount: demoImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            image: NetworkImage(demoImages[index]),
                            fit: BoxFit.cover),
                        border: Border.all()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
