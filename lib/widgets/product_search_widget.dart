import 'package:flutter/material.dart';
import 'package:flutter_app103/models/product_search.dart';

class SearchedItem extends StatefulWidget {
  final ProductSearch productSearch;
  SearchedItem(
    this.productSearch, {
    Key? key,
  }) : super(key: key);

  @override
  _SearchedItemState createState() => _SearchedItemState();
}

class _SearchedItemState extends State<SearchedItem> {
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
        children: [
          Container(
            child: Image.asset(
              widget.productSearch.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            clipBehavior: Clip.hardEdge,
          ),
          SizedBox(width: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.productSearch.name),
              Text(widget.productSearch.shopName),
              Text(widget.productSearch.price.toString()),
              Row(
                children: [
                  Text("QTY:"),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline_outlined),
                    onPressed: () {
                      setState(() {
                        widget.productSearch.quantity++;
                      });
                    },
                  ),
                  Text(widget.productSearch.quantity.toString()),
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline_outlined),
                    onPressed: () {
                      if (widget.productSearch.quantity > 0) {
                        setState(() {
                          widget.productSearch.quantity--;
                        });
                      }
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
