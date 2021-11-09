import 'package:cloud_firestore/cloud_firestore.dart';
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
  var homeCategories;
  var products;

  _loadData() async {
    homeCategories = FirebaseFirestore.instance.collection("categories").where("show_in_home",isEqualTo: true).get();
    var catIds = <String>[];
    homeCategories.docs.forEach((element) {
      catIds.add(element.id);
    });
    // // products = FirebaseFirestore.instance.collection("products").where("category.id",whereIn: catIds).get();
    // Logger().e(products.size);
    // Logger().w(catIds);
  }

  @override
  Widget build(BuildContext context) {
    _loadData();
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

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: FutureBuilder<QuerySnapshot>(
          future: homeCategories,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
            var cats = snapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (context, index){
                var item = cats[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item["name"] ?? "No Name Found"),
                        SizedBox(height: 10,),
                        SizedBox(
                          height: 120,
                          child: FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance.collection("products").where("category.id",isEqualTo: snapshot.data!.docs[index].id).get(),
                            builder: (context, productSnapshot) {

                              if(productSnapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
                              var products = productSnapshot.data!.docs;

                              if(products.length == 0) return Container();

                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: products.length,
                                  itemBuilder: (context, productIndex) {
                                    var singleProduct = products[productIndex].data() as Map<String, dynamic>;
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
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all(),
                                          image: DecorationImage(
                                            image: NetworkImage(singleProduct["image"] ?? "https://via.placeholder.com/150"),
                                            fit: BoxFit.fill
                                          )
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                                            ),
                                            child: Column(
                                              
                                              children: [
                                                Text(singleProduct["name"] ?? "Product Name"),
                                                Text((singleProduct["price"] ?? "" )+ " TK"),
                                          
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }
                          ),
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
