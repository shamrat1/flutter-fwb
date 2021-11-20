

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/Cart.dart';
import 'package:flutter_app103/screens/checkout_items.dart';
import 'package:flutter_app103/state/CartState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({ Key? key, required this.product, required this.productID }) : super(key: key);
  final Map<String, dynamic> product;
  final String productID;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          CupertinoIcons.arrow_left,
          color: Colors.black,
        ),
        title: Text(
          "Profile of ${widget.product["name"]}",
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
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Container(
              height: size.height * .40,
              width: double.infinity,
              child: Image.network(
                widget.product["image"] ?? "https://via.placeholder.com/150",
                fit: BoxFit.contain,
                // loadingBuilder: (context, child, chunkEvent){
                //   Logger().i("${chunkEvent?.cumulativeBytesLoaded} | ${chunkEvent?.expectedTotalBytes}");
                //   return Center(child: CircularProgressIndicator(),);
                // },
                // errorBuilder: (context, obj, trace) {
                //   Logger().w(obj);
                //   Logger().e(trace);
                //   return Container();
                // },
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.product["name"],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                widget.product["price"] + " Tk",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,),
              child: Text(
                widget.product["category"]["name"],
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff7e7e7e)
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextButton(
                child: Text("Add To Cart"),
                onPressed: (){
                  if (context.read(cartListPorvider).length > 0) {
                    if (widget.product["owner"] !=
                        context.read(cartListPorvider).first.product["owner"]) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Products from different store already exists. Delete them first than try adding")));
                      return;
                    }
                  }
                  var item = context
                      .read(cartListPorvider)
                      .where((element) => element.id == widget.productID);
                  if (item.length > 0) {
                    context.read(cartListPorvider.notifier).increment(item.first);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Success.")));
                  } else {
                    var cart = Cart(widget.productID, widget.product,
                        double.parse(widget.product["price"] ?? 0), 1);
                    context.read(cartListPorvider.notifier).add(cart);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "${widget.product["name"]} added in the cart.")));
                  }
                },
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  // color: Color(0xff7e7e7e),
                  fontWeight: FontWeight.bold
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,),
              child: Text(
                widget.product["description"],
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff7e7e7e)
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}