import 'package:flutter/material.dart';
import 'package:flutter_app103/models/checkout.dart';

class CheckoutWidget extends StatefulWidget {
  final CheckoutOne checkoutOne;
  final Function onDelete;
  CheckoutWidget(
    this.checkoutOne,
    this.onDelete, {
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo[100],
      child: Row(
        children: [
          Container(
            child: Image.network(
              widget.checkoutOne.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Text(widget.checkoutOne.shopName),
              Text(widget.checkoutOne.name),
              Text(widget.checkoutOne.price.toString()),
              Row(
                children: [
                  Text('Qty:'),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline_outlined),
                    onPressed: () {
                      setState(
                        () {
                          widget.checkoutOne.quantity++;
                        },
                      );
                    },
                  ),
                  Text(widget.checkoutOne.quantity.toString()),
                  IconButton(
                      icon: Icon(Icons.remove_circle_outline_outlined),
                      onPressed: () {
                        if (widget.checkoutOne.quantity > 0) {
                          setState(() {
                            widget.checkoutOne.quantity--;
                          });
                        }
                      }),
                ],
              )
            ],
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              print("want to delte item of: ${widget.checkoutOne.id}");
              widget.onDelete();
            },
            icon: Icon(
              Icons.delete_forever_outlined,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
