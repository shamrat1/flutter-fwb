

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({ Key? key, required this.order}) : super(key: key);

  final QueryDocumentSnapshot<Object?> order;

  @override
  Widget build(BuildContext context) {
    var data = order.data() as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black38,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "FEMALEPRENEURE BAZAAR",
          style: TextStyle(color: Colors.black38),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(height: 20,),
            _getHeading("Order #"+data["orderCode"]),
            Container(
              // height: 250,
              // color: Colors.amber,
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _getSingleSummeryItem("Status", data["status"]),
                  Divider(),
                  _getSingleSummeryItem("Subtotal", data["subtotal"].toString()),
                  Divider(),
                  _getSingleSummeryItem("Delivery Charge", data["delivery_charge"].toString()),
                  Divider(),
                  _getSingleSummeryItem("Total", data["total"].toString()),
                  Divider(),
                ],
              ),
            ),

            // SizedBox(height: 20,),

            _getHeading("Items"),
            for(var item in data["items"])
            _getSingleItem(item["product"], item["quantity"])
          ],
        ),
      ),
    );
  }

  Widget _getSingleItem(Map<String, dynamic> data, int qty){
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
                child: Image.network(data["image"], height: 100, width: 100,fit: BoxFit.cover,),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data["name"] ?? "No Product Name Found."),
                        Text("Quantity: $qty"),
                        Text("${double.parse(data["price"]) * qty} Taka"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }

  Widget _getHeading(String title){
    return Container(
      height: 50,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

 Widget _getSingleSummeryItem(String first, String second){
   return Row(
    children: [
      Text(first,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      Spacer(),
      Text(second,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      
    ],
  );
 }
}