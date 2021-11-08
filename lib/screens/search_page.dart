import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/product/product_search.dart';
import 'package:flutter_app103/widgets/product_search_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  List<ProductSearch> searchResults = [
    ProductSearch("assets/cake1.jpeg", "Unicorn cake", "Cake House", 2600, 0),
    ProductSearch("assets/cake2.jpeg", "birthday cake", "Cake ", 2800, 0),
    ProductSearch("assets/cake3.jpeg", "sprinkle cake", "House", 2000, 0),
    ProductSearch("assets/cake4.jpeg", "sprinkle cake", "House", 2000, 0),
    ProductSearch("assets/cake5.jpeg", "sprinkle cake", "House", 2000, 0),
    ProductSearch("assets/cake1.jpeg", "sprinkle cake", "House", 2000, 0),
    ProductSearch("assets/cake2.jpeg", "sprinkle cake", "House", 2000, 0),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            TextField(
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
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return SearchedItem(searchResults[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
