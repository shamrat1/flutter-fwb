import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/common/demo_image_list.dart';
import 'package:flutter_app103/screens/profile_layout.dart';
import 'package:flutter_app103/screens/search_page.dart';
import 'package:flutter_app103/screens/wishlist_screen.dart';
import 'package:flutter_app103/widgets/home_page_widget.dart';
import 'package:logger/logger.dart';

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
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            child: Text('sidebar'),
          ),
          ListTile(
              onTap: () {}, leading: Icon(Icons.home), title: Text('Home')),
          ListTile(
              onTap: () {},
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart')),
          ListTile(
              onTap: () {},
              leading: Icon(Icons.contact_page),
              title: Text('Contact Us')),
          ListTile(
              onTap: () {},
              leading: Icon(Icons.person),
              title: Text('About Us')),
          ListTile(
              onTap: () {}, leading: Icon(Icons.star), title: Text('Rate Us')),
          ListTile(
              onTap: () {},
              leading: Icon(Icons.reviews),
              title: Text('Review')),
          ListTile(
              onTap: () {},
              leading: Icon(Icons.track_changes),
              title: Text('TrackDelivery')),
          ListTile(
              onTap: () {},
              leading: Icon(Icons.message),
              title: Text('Messages')),
          ListTile(
              onTap: () {},
              leading: Icon(Icons.notification_important),
              title: Text('Notifications')),
          ListTile(
              onTap: () {},
              leading: Icon(Icons.chat_bubble_outline),
              title: Text('Privacy Policy')),
        ],
      )),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          );
        }),
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
      body:_attachView(),
    );
  }
  Widget _attachView(){
    switch (currentIndex){
      case 3:
        return ProfileLayout();
      case 1:
        return SearchPage();
      case 2:
        return WishlistScreen();

      default:
      return ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Favourites"),
              SizedBox(
                height: 120,
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
            ],
          ),
          HomePageWidget('Clothing'),
          HomePageWidget('Bakery'),
          HomePageWidget('Skincare'),
        ],
      );
    }
  }
}
