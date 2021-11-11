import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/screens/order_placed.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_app103/state/CartState.dart';
import 'package:flutter_app103/state/SelectedAddressState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class CheckoutPayment extends StatefulWidget {
  CheckoutPayment({Key? key}) : super(key: key);

  @override
  _CheckoutPaymentState createState() => _CheckoutPaymentState();
}

class _CheckoutPaymentState extends State<CheckoutPayment> {

  bool _orderPlaced = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          CupertinoIcons.arrow_left,
          color: Colors.black,
        ),
        title: Text(
          "Femaleprenuere Bazar",
          style: TextStyle(color: Colors.black38),
        ),
      ),
      body: Stack(
        children: [
          Consumer(
            builder: (context, watch, child) {
              var items = watch(cartListPorvider);
              var selectedAddress = watch(selectedAddressProvider);

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.indigo[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Address',
                            style:
                                TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                        Icon(Icons.play_arrow),
                        Text('checkout',
                            style:
                                TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                        Icon(Icons.play_arrow),
                        Text('payment',
                            style:
                                TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment method",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.card_membership),
                            Text('Cash on delivery'),
                            Icon(Icons.circle),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 220),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      children: [
                        Text('Checkout: ${watch(cartListPorvider.notifier).getSubtotal()} TK \n ${items.length} items '),
                        // SizedBox(width: 80),
                        Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30)),
                              primary: Colors.indigo[50],
                              padding: EdgeInsets.all(20),
                              minimumSize: Size(10, 10)),
                          onPressed: () async {
                            try{
                              var order = FirebaseFirestore.instance.collection("orders");
                              var subtotal = context.read(cartListPorvider.notifier).getSubtotal();
                              var mapItems = [];
                              items.forEach((element) {
                                mapItems.add({
                                  "product_id" : element.id,
                                  "product" : element.product,
                                  "price" : element.price,
                                  "quantity" : element.quantity,
                                });
                              });
                              var data = {
                                "orderCode" : "FB"+ DateTime.now().millisecondsSinceEpoch.remainder(100000).toString(),
                                "total" : subtotal + 40,
                                "subtotal": subtotal,
                                "delivery_charge" : 40,
                                "items" : mapItems,
                                "delivery_address": {
                                  "address_id" : selectedAddress.documentId,
                                  "address" : selectedAddress.data
                                },
                                "status" : "Pending",
                                "user" : context.read(authenticatedUserProvider).documentId,
                                "seller" : items.first.product["owner"],

                              };
                              await order.add(data);
                              context.read(cartListPorvider.notifier).removeAll();
                              Navigator.push(context, MaterialPageRoute(builder: (ctx) => OrderPlaced()));
                            }catch(e){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Placing Order")));
                            }
                            
                          },
                          child: Text('Continue',
                              style: TextStyle(
                                  color: Colors.blueGrey[600],
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
          if(_orderPlaced)
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: [
                Text("Order Placed Successfully."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
