import 'package:flutter/material.dart';
import 'package:flutter_app103/models/message.dart';

class MessagesPage extends StatefulWidget {
  MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final List<Messages> messageList = [
    Messages(
        shopName: 'Arde paints',
        image:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d29tYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
        text: "Thank you for update"),
    Messages(
        shopName: 'cake story',
        image:
            'https://thumbs.dreamstime.com/z/gorgeous-female-baker-preparing-dessert-baking-confident-young-pastry-chef-decorating-cupcakes-pan-kitchen-counter-175623340.jpg',
        text: "writing on the cake?"),
    Messages(
        shopName: 'pottery barn',
        image:
            'https://www.aristadentalclinic.com/wp-content/uploads/woman-with-white-teeth-smiling.jpg',
        text: "Price list is given below."),
    Messages(
        shopName: 'Chef house',
        image: 'https://www.lifevinefamily.com/bin/uploads/2016/12/woman.jpg',
        text: "sending the delivery by 3 pm"),
    Messages(
        shopName: 'Bakers',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY1AatMcdJ0prDeQca7c_akVyezqfYtWtNVZzEeAuTwLIMY_9tnJ7SBcwp4RMLftRAdrI&usqp=CAU',
        text: "order placed"),
    Messages(
        shopName: 'closets',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR43gMoRxssaMcHBwrB3nhFWnrDQF_gikGoXZOl9JrWSinSrUl55M8OPrJYOXvn-5f9RmE&usqp=CAU',
        text: "size for alteration?"),
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
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(messageList[index].image!),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ), //column -> message text, shopname text
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          messageList[index].shopName!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(messageList[index].text!),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
