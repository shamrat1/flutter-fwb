import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/demo_image_list.dart';
import 'package:flutter_app103/widgets/home_page_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Favourites"),
              SizedBox(
                height: 120,
                child: Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: demoImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(demoImages[index]),
                                  fit: BoxFit.cover)),
                        );
                      }),
                ),
              ),
            ],
          ),
          HomePageWidget('Clothing'),
          HomePageWidget('Bakery'),
          HomePageWidget('Skincare'),
        ],
      ),
    );
  }
}
