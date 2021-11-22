import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatefulWidget {
  EmptyCart({Key? key}) : super(key: key);

  @override
  _EmptyCartState createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
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
          "Femaleprenuere Bazar",
          style: TextStyle(color: Colors.black38),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (int val) {
          setState(() {
            currentIndex = val;
          });
        },
        currentIndex: currentIndex,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
          FloatingNavbarItem(icon: Icons.favorite, title: 'Favourite'),
          FloatingNavbarItem(
              icon: Icons.verified_user_outlined, title: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              CupertinoIcons.cart,
              size: 100,
              color: Colors.black,
            ),
            Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            Text(
              'You have no items in your shopping cart! \n Lets go shopping',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30)),
                  primary: Colors.indigo[50],
                  padding: EdgeInsets.all(20),
                  minimumSize: Size(10, 10)),
              onPressed: () {},
              child: Text('Shop Now',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
