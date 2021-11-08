import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/product/wishlist.dart';

import 'package:flutter_app103/widgets/wishlist_widget.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WishlistScreenState();
  }
}

class _WishlistScreenState extends State<WishlistScreen> {
  int currentIndex = 0;

  List<Wishlist> wishlistlist = [
    Wishlist(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Unicorn cake",
        "Cake House",
        2600,
        0,
        true),
    Wishlist(
        "https://images.unsplash.com/photo-1579965342575-16428a7c8881?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFpbnRpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
        "birthday cake",
        "Cake ",
        2800,
        0,
        true),
    Wishlist(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "sprinkle cake",
        "House",
        2000,
        0,
        true),
    Wishlist(
        "https://www.mybakingaddiction.com/wp-content/uploads/2010/09/Beer-Bread-3_resized.jpg.webp",
        "sprinkle cake",
        "House",
        2000,
        0,
        true),
    Wishlist(
        "https://www.mybakingaddiction.com/wp-content/uploads/2010/09/Beer-Bread-3_resized.jpg.webp",
        "sprinkle cake",
        "House",
        2000,
        0,
        true),
    Wishlist(
        "https://www.mybakingaddiction.com/wp-content/uploads/2010/09/Beer-Bread-3_resized.jpg.webp",
        "sprinkle cake",
        "House",
        2000,
        0,
        true),
    Wishlist(
        "https://www.mybakingaddiction.com/wp-content/uploads/2010/09/Beer-Bread-3_resized.jpg.webp",
        "sprinkle cake",
        "House",
        2000,
        0,
        true),
  ];

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
      //     "Wishlist",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //       color: Colors.black38,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.refresh),
      //       color: Colors.black,
      //       onPressed: () {
      //         setState(() {
      //           wishlistlist
      //               .removeWhere((element) => element.isFavourite == false);
      //         });
      //       },
      //     ),
      //     Icon(
      //       CupertinoIcons.cart,
      //       color: Colors.black,
      //     ),
      //   ],
      // ),
      extendBody: true,
      // bottomNavigationBar: FloatingNavbar(
      //   backgroundColor: Colors.white,
      //   unselectedItemColor: Colors.grey,
      //   onTap: (int val) {
      //     setState(() {
      //       currentIndex = val;
      //     });
      //     //returns tab id which is user tapped
      //   },
      //   currentIndex: currentIndex,
      //   items: [
      //     FloatingNavbarItem(icon: Icons.home, title: 'Home'),
      //     FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
      //     FloatingNavbarItem(icon: Icons.favorite, title: 'Favourite'),
      //     FloatingNavbarItem(
      //         icon: Icons.verified_user_rounded, title: 'Profile'),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: wishlistlist.length,
                itemBuilder: (context, index) {
                  return WishlistWidget(wishlistlist[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
