import 'package:flutter/material.dart';
import 'package:flutter_app103/models/checkout_item_model.dart';
import 'package:flutter_app103/models/wishlist.dart';

class CheckoutItemWidget extends StatefulWidget {
  final CheckoutItem checkout;
  CheckoutItemWidget(
    this.checkout, {
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutItemWidgetState createState() => _CheckoutItemWidgetState();
}

class _CheckoutItemWidgetState extends State<CheckoutItemWidget> {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.checkout.name),
              Text(widget.checkout.shopName),
              Text(widget.checkout.price.toString()),
              Row(
                children: [
                  Text("QTY:"),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline_outlined),
                    onPressed: () {
                      setState(() {
                        widget.checkout.quantity++;
                      });
                    },
                  ),
                  Text(widget.checkout.quantity.toString()),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
