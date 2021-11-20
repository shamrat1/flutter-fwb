import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/common/demo_image_list.dart';
import 'package:flutter_app103/models/message/message.dart';
import 'package:flutter_app103/models/order/checkout_item_model.dart';
import 'package:flutter_app103/screens/OrdersPage.dart';
import 'package:flutter_app103/screens/Users_list_page.dart';
import 'package:flutter_app103/screens/Wishlist.dart';
import 'package:flutter_app103/screens/checkout_items.dart';
import 'package:flutter_app103/screens/message_list_screen.dart';
import 'package:flutter_app103/screens/profile_layout.dart';
import 'package:flutter_app103/screens/search_page.dart';
import 'package:flutter_app103/screens/track_delivery.dart';
import 'package:flutter_app103/screens/wishlist_screen.dart';
import 'package:flutter_app103/state/CartState.dart';
import 'package:flutter_app103/widgets/ProductTile.dart';
import 'package:flutter_app103/widgets/home_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.index = 0}) : super(key: key);
  final int index;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  var homeCategories;
  var products;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    homeCategories = FirebaseFirestore.instance
        .collection("categories")
        .where("show_in_home", isEqualTo: true)
        .get();
  }

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
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Wishlist())),
              leading: Icon(Icons.favorite, color: Colors.redAccent.shade200,),
              title: Text('Wishlist')),
          ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => UsersListPage())),
              leading: Icon(Icons.list_alt_sharp), title: Text('Users')),
          ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => UsersListPage(type: UsersListType.PERSONAL,))),
              leading: Icon(Icons.supervised_user_circle_sharp),
              title: Text('Following')),
          ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => TrackDelivery())),
              leading: Icon(Icons.track_changes),
              title: Text('TrackDelivery')),
          ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => MessagesPage())),
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
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => CheckoutItemsScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                // height: ,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Icon(
                      CupertinoIcons.cart,
                      color: Colors.black,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Consumer(
                        builder: (context, watch, child) {
                          var cartItems = watch(cartListPorvider);
                          return Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              cartItems.length.toString(),
                              style: TextStyle(fontSize: 11),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
          FloatingNavbarItem(icon: Icons.list, title: 'Orders'),
          FloatingNavbarItem(
              icon: Icons.verified_user_rounded, title: 'Profile'),
        ],
      ),
      body: _attachView(),
    );
  }

  Widget _attachView() {
    switch (currentIndex) {
      case 3:
        return ProfileLayout();
      case 1:
        return SearchPage();
      case 2:
        return OrdersPage();

      default:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: FutureBuilder<QuerySnapshot>(
            future: homeCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              var cats = snapshot.data!.docs;
              return ListView.builder(
                itemBuilder: (context, index) {
                  var item = cats[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item["name"] ?? "No Name Found"),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 180,
                          child: FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection("products")
                                  .where("category.id",
                                      isEqualTo: snapshot.data!.docs[index].id)
                                  .get(),
                              builder: (context, productSnapshot) {
                                if (productSnapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                var products = productSnapshot.data!.docs;

                                if (products.length == 0) return Container();

                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: products.length,
                                    itemBuilder: (context, productIndex) {
                                      var singleProduct = products[productIndex]
                                          .data() as Map<String, dynamic>;
                                      // return Container(
                                      //   width: 100,
                                      //   margin: EdgeInsets.all(5),
                                      //   decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(20),
                                      //       image: DecorationImage(
                                      //           image: NetworkImage(demoImages[index]),
                                      //           fit: BoxFit.cover)),
                                      // );
                                      return Container(
                                        width: 180,
                                        height: 180,
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: ProductTile(
                                          singleProduct: singleProduct,
                                          productID: products[productIndex].id,
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: cats.length,
              );
            },
          ),
        );
      // return ListView(
      //   children: [
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Text("Favourites"),
      //         SizedBox(
      //           height: 120,
      //           child: ListView.builder(
      //               scrollDirection: Axis.horizontal,
      //               itemCount: demoImages.length,
      //               itemBuilder: (context, index) {
      //                 return Container(
      //                   width: 100,
      //                   margin: EdgeInsets.all(5),
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(20),
      //                       image: DecorationImage(
      //                           image: NetworkImage(demoImages[index]),
      //                           fit: BoxFit.cover)),
      //                 );
      //               }),
      //         ),
      //       ],
      //     ),
      //     HomePageWidget('Clothing'),
      //     HomePageWidget('Bakery'),
      //     HomePageWidget('Skincare'),
      //   ],
      // );
    }
  }
}
