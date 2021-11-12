import 'package:flutter/material.dart';
import 'package:flutter_app103/models/message/message.dart';
import 'package:flutter_app103/screens/MessageConversation.dart';
import 'package:intl/intl.dart';

class MessagesPage extends StatefulWidget {
  MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  var titles = ["BrAve", "GOOD Buys", "Meal Treats", "GOOD Fruits"];
  var subtitle = [
    "Somethings not right.",
    "if Possible send it today.",
    "Highly satisfied",
    "How much ?"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Message",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => MessageConversationPage())
                  );
                },
                title: Text(titles[index]),
                subtitle: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .55,
                      child: Text(
                        subtitle[index],
                        style: TextStyle(color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width * .30,
                      child: Text(
                        DateFormat.yMMMMEEEEd()
                            .format(DateTime.now())
                            .toString(),
                        style: TextStyle(fontSize: 8, color: Color(0x50000000)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                // isThreeLine: true,
              );
              // return Container(
              //   padding: EdgeInsets.all(5),
              //   margin: EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //       color: Colors.white24,
              //       borderRadius: BorderRadius.circular(20)),
              //   child: Row(
              //     children: [
              //       Container(
              //         width: 100,
              //         height: 100,
              //         // decoration: BoxDecoration(
              //         //   shape: BoxShape.circle,
              //         //   image: DecorationImage(
              //         //       image: NetworkImage(messageList[index].image!),
              //         //       fit: BoxFit.fill),
              //         // ),
              //       ),
              //       SizedBox(
              //         width: 50,
              //       ), //column -> message text, shopname text
              //       Container(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               "Shop Name",
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //             SizedBox(
              //               height: 20,
              //             ),
              //             Text("text"),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // );
            }),
      ),
    );
  }
}
