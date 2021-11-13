import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/product/product_search.dart';
import 'package:flutter_app103/widgets/ProductTile.dart';
import 'package:flutter_app103/widgets/product_search_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  String? query;

  // List<ProductSearch> searchResults = [
  //   ProductSearch("assets/cake1.jpeg", "Unicorn cake", "Cake House", 2600, 0),
  //   ProductSearch("assets/cake2.jpeg", "birthday cake", "Cake ", 2800, 0),
  //   ProductSearch("assets/cake3.jpeg", "sprinkle cake", "House", 2000, 0),
  //   ProductSearch("assets/cake4.jpeg", "sprinkle cake", "House", 2000, 0),
  //   ProductSearch("assets/cake5.jpeg", "sprinkle cake", "House", 2000, 0),
  //   ProductSearch("assets/cake1.jpeg", "sprinkle cake", "House", 2000, 0),
  //   ProductSearch("assets/cake2.jpeg", "sprinkle cake", "House", 2000, 0),
  // ];

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            children: [
              TextField(
                onChanged: (value){
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black38,
                  ),
                
                  hintText: "Search Products",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.70,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("products").where("name",isGreaterThanOrEqualTo: query).snapshots(),
                  builder: (context, snapshot){
      
                    if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
      
                    if(snapshot.data!.size == 0) return Center(child: Text("No Product Found"),);
      
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          childAspectRatio: 5 / 6),
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      
                      return ProductTile(singleProduct: snapshot.data!.docs[index].data() as Map<String, dynamic>, productID: snapshot.data!.docs[index].id);
                      // return SearchedItem(searchResults[index]);
                      // return Text(snapshot.data!.docs[index].data().toString());
                    },
                  );
      
                  },
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: searchResults.length,
              //     itemBuilder: (context, index) {
              //       return SearchedItem(searchResults[index]);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
