

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/screens/OrdersPage.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({ Key? key, required this.order, this.viewer = Viewer.USER}) : super(key: key);

  final QueryDocumentSnapshot<Object?> order;
  final Viewer viewer;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String status = "";

  List<String> _statuses = [
    "Pending", "Accepted", "Processing", "Shipped", "Delivered"
  ];

  @override
  Widget build(BuildContext context) {
    print(widget.viewer);
    var data = widget.order.data() as Map<String, dynamic>;
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
            if(widget.viewer == Viewer.SELLER)
            Container(
              child: Row(
                children: [
                  Text("Update Status",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(
                            context: context,
                            builder: (context){
                              return Container(
                                height: MediaQuery.of(context).size.height * .50,
                                child: ListView.builder(
                                      itemBuilder: (context, index){
                                        return ListTile(
                                          title: Text(_statuses[index]),
                                          onTap: (){
                                            setState(() {
                                              status = _statuses[index];
                                            });
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      itemCount: _statuses.length,
                                    ),
                              );
                            }
                          );
                        },
                        child: Text(
                          status != "" ? status : "Select Status",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: () async {
                          // order.
                          await FirebaseFirestore.instance.collection("orders").doc(widget.order.id).update({
                            "status": status
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Order Status Updated.")));
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.save, color: Colors.white,size: 20,),
                        ),
                        
                      ),
                    ],
                  ),
                  
                ],
              ),
              padding: EdgeInsets.all(8),
            ),
            if(widget.viewer == Viewer.SELLER)
            SizedBox(height: 15,),
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
            for(var i = 0; i < data["items"].length; i++)
            _getSingleItem(data["items"][i], data["items"][i]["quantity"],i)
          ],
        ),
      ),
    );
  }

  Widget _getSingleItem(Map<String, dynamic> data, int qty, int index){
    var orderData = widget.order.data() as Map<String, dynamic>;

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
                child: Image.network(data["product"]["image"], height: 100, width: 100,fit: BoxFit.cover,),
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
                        Text(data["product"]["name"] ?? "No Product Name Found."),
                        Text("Quantity: $qty"),
                        Text("${data["price"] * qty} Taka"),
                      ],
                    ),
                  ],
                ),
              ),
              if(orderData["status"] == "Delivered")
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    child: Text("Rate"),
                    onTap: () async {
                     DocumentSnapshot<Map<String, dynamic>> product = await FirebaseFirestore.instance.collection("products").doc(data["product_id"]).get();
                      await FirebaseFirestore.instance.collection("orders").doc(widget.order.id).update({
                        "rating_" +data["product_id"] : 4,
                      });
                      await FirebaseFirestore.instance.collection("products").doc(data["product_id"]).update({
                        "rating" : product.data()!["rating"] + 4,
                        "ratingCount" : (product.data()!["ratingCount"] ?? 0) + 1
                      });
                    },  
                  ),
                ) 
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