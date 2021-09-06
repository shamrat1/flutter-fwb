import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPlaced extends StatefulWidget {
  OrderPlaced({Key? key}) : super(key: key);

  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  int currentIndex = 0;
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              CupertinoIcons.check_mark_circled,
              size: 100,
              color: Colors.black,
            ),
            Text(
              'Order Placed',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
            Text(
              'you order has been successfully placed!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30)),
                  primary: Colors.indigo[50],
                  padding: EdgeInsets.all(20),
                  minimumSize: Size(10, 10)),
              onPressed: () {},
              child: Text('Continue Shopping',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w300)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30)),
                  primary: Colors.indigo[50],
                  padding: EdgeInsets.all(20),
                  minimumSize: Size(10, 10)),
              onPressed: () {},
              child: Text(' View all orders',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w300)),
            ),
          ],
        ),
      ),
    );
  }
}
