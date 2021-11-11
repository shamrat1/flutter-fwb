import 'package:flutter/material.dart';
import 'package:flutter_app103/models/Cart.dart';
import 'package:flutter_app103/models/order/checkout_item_model.dart';
import 'package:flutter_app103/models/product/wishlist.dart';
import 'package:flutter_app103/state/CartState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class CheckoutItemWidget extends StatefulWidget {
  final int index;
  CheckoutItemWidget(
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutItemWidgetState createState() => _CheckoutItemWidgetState();
}

class _CheckoutItemWidgetState extends State<CheckoutItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var items = watch(cartListPorvider);
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(items[widget.index].product["image"], height: 100, width: 100,fit: BoxFit.cover,),
              ),
              SizedBox(width: 10,),
              SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items[widget.index].product["name"] ?? "No Product Name Found."),
                        // Text(widget.checkout.shopName),
                        Text(items[widget.index].price.toString()),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Text("QTY:"),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline_outlined),
                          onPressed: () {
                            context.read(cartListPorvider.notifier).increment(items[widget.index]);
                          },
                        ),
                        Text(items[widget.index].quantity.toString()),
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            context.read(cartListPorvider.notifier).decrement(items[widget.index]);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
