import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

class MessageConversationPage extends StatefulWidget {
  const MessageConversationPage({Key? key}) : super(key: key);

  @override
  _MessageConversationState createState() => _MessageConversationState();
}

class _MessageConversationState extends State<MessageConversationPage> {

  TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black38,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Conversation",
          style: TextStyle(color: Colors.black38),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              Container(
                // child: ,
                height: MediaQuery.of(context).size.height * .80,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index){
                    if(index % 2 == 0){
                      return Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 8.0, right: MediaQuery.of(context).size.width * .20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0xffdbdbdb))
                        ),
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width * .40,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mr. X",
                              style: TextStyle(fontSize: 8, color: Color(0x70000000)),
                            ),
                            Text("somehting is wrong"),
                            SizedBox(height: 5,),
                            Text(DateFormat("hh:mm a dd-MM-yyyy")
                              .format(DateTime.now())
                              .toString(),
                              style: TextStyle(fontSize: 8, color: Color(0x50000000)),
                            )
                          ],
                        ),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.only(top: 8.0, bottom: 8.0, left: MediaQuery.of(context).size.width * .20),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width * .40,
                      child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Mr. Y",
                              style: TextStyle(fontSize: 8, color: Color(0x70000000)),
                            ),
                            Text("somehting is wrong on a very high level"),
                            SizedBox(height: 5,),
                            Text(DateFormat("hh:mm a dd-MM-yyyy")
                              .format(DateTime.now())
                              .toString(),
                              style: TextStyle(fontSize: 8, color: Color(0x50000000)),
                            )
                          ],
                        ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xffdbdbdb))
                      ),
                      // width: 100,

                    );
                  }
                ),
              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  label: Text("Message"),
                  hintText: "Type message here",
                  suffix: IconButton(icon: Icon(Icons.send),onPressed: () => print("send"),),
                ),
                onFieldSubmitted: (value){
                  Logger().v(value);
                },

                maxLines: 1
              ),
            ],
          ),
        ),
      ),
    );
  }
}
