import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/order/checkout_item_model.dart';
import 'package:flutter_app103/widgets/checkout_items_widget.dart';

class CheckoutItemsScreen extends StatefulWidget {
  CheckoutItemsScreen({Key? key}) : super(key: key);

  @override
  _CheckoutItemsScreenState createState() => _CheckoutItemsScreenState();
}

class _CheckoutItemsScreenState extends State<CheckoutItemsScreen> {
  final TextEditingController promoCodeController = TextEditingController();
  int currentIndex = 0;
  List<CheckoutItem> checkoutItemslist = [
    CheckoutItem(
      "Amira",
      "Black midi dress",
      2600,
      1,
    ),
    CheckoutItem(
      "Amira",
      "Black midi dress",
      2600,
      1,
    ),
    CheckoutItem(
      "Amira",
      "Black midi dress",
      2600,
      1,
    )
  ];

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
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Have a PromoCode?",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextField(
                          controller: promoCodeController,
                          obscureText: true,
                          decoration: InputDecoration(hintText: "Promo Code"),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30)),
                          primary: Colors.indigo[100],
                          padding: EdgeInsets.all(20),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Apply",
                          style: TextStyle(
                              color: Colors.blueGrey[600],
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: checkoutItemslist.length,
              itemBuilder: (context, index) {
                return CheckoutItemWidget(checkoutItemslist[index]);
              },
            ),
            SizedBox(height: 10),
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
                        padding: EdgeInsets.all(10),
                        minimumSize: Size(10, 10)),
                    onPressed: () {},
                    child: Text('Continue',
                        style: TextStyle(
                            color: Colors.blueGrey[600],
                            fontSize: 25,
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
