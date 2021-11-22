import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutAddress extends StatefulWidget {
  CheckoutAddress({Key? key}) : super(key: key);

  @override
  _CheckoutAddressState createState() => _CheckoutAddressState();
}

class _CheckoutAddressState extends State<CheckoutAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
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
          "Femaleprenuere Bazar",
          style: TextStyle(color: Colors.black38),
        ),
      ),
      body: Column(
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
            margin: EdgeInsets.all(40),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.indigo[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    'House no 21,road 72,\n DOHS, Baridhara,Dhaka,\n1212,Bangladesh'),
                Icon(Icons.circle),
              ],
            ),
          ),
          SizedBox(height: 100),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black)),
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
    );
  }
}
