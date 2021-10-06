// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'message_list_screen.dart';

// class Chat extends StatefulWidget {
//   Chat({Key? key}) : super(key: key);

//   @override
//   _ChatState createState() => _ChatState();
//   final senderId senderId;
// }

// class _ChatState extends State<Chat> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: Builder(builder: (context) {
//           return IconButton(
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//             icon: Icon(
//               Icons.menu,
//               color: Colors.black,
//             ),
//           );
//         },
  
//   ),
//         title: Row(
//           children:[ 
          
//           CircleAvatar(
//             radius: 30,
//             backgroundImage: AssetImage(assetName),

//           ),
//           Text(
//             widget.username,
//             style: TextStyle(color: Colors.black38),
//           ),
//           ],
          
        
          
//     ),
//     ),
//     body: Column(
//       children: [
//         Expanded(


//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 30),
            
//             color: Colors.white,
//             decoration: BoxDecoration(borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//             ),
//             child: ListView.builder(
//               reverse: true,
//               itemCount: messages.length, 
//               itemBuilder: (context,int index){
//              final message = messages[index];
//              bool isMe = message.sender.id == currentuser.id;
//              return Container(
//                margin: EdgeInsets.only(top: 10),
//                child: Column(
//                  children: [
//                    Row(
//                      mainAxisAlignment: isMe?MainAxisAlignment.end
//                      : MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                     
//                    children: [
//                      if(!isMe)
//                      CircleAvatar(
//                        radius: 15,
//                        backgroundImage: AssetImage(widget.user.avatar),
//                      ),
//                      SizedBox(width: 10,
//                      ),
//                      Container(
//                        padding: EdgeInsets.all(10),
//                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                      
//                        decoration BoxDecoration(
//                          color: isMe
//                        ? MyTheme.KAccentColor
//                        : Colors.grey[200],
//                        borderRadius: BorderRadius.only(
//                          topLeft: Radius.circular(16),
//                           topRight: Radius.circular(16),
//                           bottomLeft: Radius.circular(isMe ? 12 : 0),
//                           bottomRight: Radius.circular(isMe ? 0 : 12),
//                        )
//                        ),
//                        ),
//                        child: Text(
//                          messages[index].text,
//                          style: MyTheme.bodyTextMessage.copyWith(
//                            color: isMe?Colors.white : Colors.grey[800]),
//                          ),),
//                    ],
//              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Row(
//                  mainAxisAlignment: isMe
//                  ? MainAxisAlignment.end :
//                  : MainAxisAlignment.start,
//                  children: [
//                    if (!isMe)
//                    SizedBox(width: 40,
//                    ),
//                    Icon(Icons.done_all,
//                    size: 20,
//                    color: MyTheme.bodyTextTime.color,
//                    ),
//                    SizedBox(width: 8,),
//                    Text(message.time,
//                    style: MyTheme.bodyTxtTime,)

//                  ],
//                ),
//              )
//                  ],
//                ),
//              ); 
//             }) ,
//           ),
//         )
//         Container(
//           color: Colors.white,
//           height: 100,
//           child: Row(children: [
//             Expanded(
//               child: Container( 
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 height: 60,
//                 margin: EdgeInsets.all(20),
//             color: Colors.grey[200],
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.emoji_emotions_outlined,
//                   color: Colors.grey[500],
//                   ),
//                   SizedBox(width: 10,
//                   ),
//                   Expanded(
//                     child: TextField(decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Type your message ...',
//                     hintStyle: TextStyle(color: Colors.grey[500]),
//                   ),
//                   ),
//                   ),
//                   Icon(Icons.attach_file,
//                   color: Colors.grey[500],
//                   ),

//                 ],
//               ),
//               ),
//               ),
//               CircleAvatar(backgroundColor: Mytheme.kAccentColor,
//               child: Icon(Icons.mic, color: Colors.white,)),
//           ],),
//         )
//       ],

//     ),
//       );
//   }
// }
