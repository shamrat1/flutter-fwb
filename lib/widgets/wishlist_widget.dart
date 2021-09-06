import 'package:flutter/material.dart';
import 'package:flutter_app103/models/wishlist.dart';

class WishlistWidget extends StatefulWidget {
  final Wishlist wishlist;
  WishlistWidget(
    this.wishlist, {
    Key? key,
  }) : super(key: key);

  @override
  _WishlistWidgetState createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Image.network(
              widget.wishlist.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            clipBehavior: Clip.hardEdge,
          ),
          //SizedBox(width: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.wishlist.name),
              Text(widget.wishlist.shopName),
              Text(widget.wishlist.price.toString()),
              Row(
                children: [
                  Text("QTY:"),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline_outlined),
                    onPressed: () {
                      setState(() {
                        widget.wishlist.quantity++;
                      });
                    },
                  ),
                  Text(widget.wishlist.quantity.toString()),
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline_outlined),
                    onPressed: () {
                      if (widget.wishlist.quantity > 0) {
                        setState(() {
                          widget.wishlist.quantity--;
                        });
                      }
                    },
                  ),
                ],
              )
            ],
          ),
          IconButton(
            padding: EdgeInsets.zero,
            //iconSize: 5,
            onPressed: () {
              setState(() {
                widget.wishlist.isFavourite = !widget.wishlist.isFavourite;
              });
            },
            icon: Icon(
              Icons.favorite,
              color: widget.wishlist.isFavourite ? Colors.red : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
