import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/order/Seller_transactions.dart';
import 'package:flutter_app103/models/order/transaction_details.dart';
import 'package:flutter_app103/widgets/transaction_widget.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int currentIndex = 0;

  final TransactionDetails transactionDetails =
      TransactionDetails('3728', 12, 1, 3000);

  List<Transaction> transactionlist = [
    Transaction(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Paining 3",
        "House of paint",
        1600,
        0),
    Transaction(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Paining 3",
        "House of paint",
        1600,
        0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
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
          "Seller Transaction",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black38,
          ),
        ),
        actions: [
          Icon(
            CupertinoIcons.cart,
            color: Colors.black,
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (int val) {
          setState(() {
            currentIndex = val;
          });
          //returns tab id which is user tapped
        },
        currentIndex: currentIndex,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
          FloatingNavbarItem(icon: Icons.favorite, title: 'Favourite'),
          FloatingNavbarItem(
              icon: Icons.verified_user_rounded, title: 'Profile'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.purple, width: 5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seller transaction",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Seller Id: ${transactionDetails.sellerId}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Product sold: ${transactionDetails.productSold}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Product in transation: ${transactionDetails.productTransaction}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Amount due: ${transactionDetails.amountdue}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactionlist.length,
                itemBuilder: (context, index) {
                  return TransactionWidget(transactionlist[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
