import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/screens/OrdersPage.dart';
import 'package:flutter_app103/screens/home_page.dart';

class OrderPlaced extends StatefulWidget {
  OrderPlaced({Key? key}) : super(key: key);

  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Femaleprenuere Bazar",
          style: TextStyle(color: Colors.black38),
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height *.60,
          alignment: Alignment.center,
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
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => HomePage()), (route) => false),
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
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => HomePage(index: 2,)), (route) => false),
                child: Text(' View all orders',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w300)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
