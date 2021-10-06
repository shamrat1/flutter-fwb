// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_app103/models/message/chat.dart';

// class MessageService {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Future<List<ChatBlocks>> getChatList() async {
//     final User user = FirebaseAuth.instance.currentUser!;
//     final chats1 = await firestore
//         .collection("Chats")
//         .where("user_1", isEqualTo: user.uid);


//         final chats2 = await firestore
//         .collection("Chats")
//         .where("user_2", isEqualTo: user.uid);
//   }
// }
