import 'package:flutter/material.dart';
import 'package:flutter_app103/models/Seller_transactions.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;
  const TransactionWidget(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(transaction.image), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${transaction.name}"),
            Text("Code:${transaction.code}"),
            Text("${transaction.price} TK"),
            Text("QTY: ${transaction.quantity}"),
          ],
        )
      ]),
    );
  }
}
