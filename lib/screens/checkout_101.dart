import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/order/checkout.dart';
import 'package:flutter_app103/widgets/checkout_widget.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentIndex = 0;
  List<CheckoutOne> checkoutOnelist = [
    CheckoutOne(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Unicorn cake",
        "Cake House",
        2600,
        0,
        1),
    CheckoutOne(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Unicorn cake",
        "Cake House",
        2600,
        0,
        2),
    CheckoutOne(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Unicorn cake",
        "Cake House",
        2600,
        0,
        3),
    CheckoutOne(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Unicorn cake",
        "Cake House",
        2600,
        0,
        4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.black,
                ),
              ),
        title: Text(
          "checkout",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black38,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.black,
            onPressed: () {
              setState(() {
                checkoutOnelist.removeWhere((element) => element.id == false);
              });
            },
          ),
          Icon(
            CupertinoIcons.cart,
            color: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: checkoutOnelist.length,
              itemBuilder: (context, index) {
                return CheckoutWidget(checkoutOnelist[index], () {
                  setState(() {
                    checkoutOnelist.removeWhere((element) {
                      print(
                          "matching ${element.id} with ${checkoutOnelist[index].id} matched: ${element.id == checkoutOnelist[index].id}");
                      return element.id == checkoutOnelist[index].id;
                    });
                  });
                });
              },
            )),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.indigo[100],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Text('Checkout: 5900 TK \n 3 items '),
                  SizedBox(width: 80),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30)),
                        primary: Colors.indigo[50],
                        padding: EdgeInsets.all(20),
                        minimumSize: Size(10, 10)),
                    onPressed: () {},
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
        ),
      ),
    );
  }
}
