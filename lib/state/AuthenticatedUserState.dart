

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticatedUserProvider = StateNotifierProvider<AuthenticatedUser, UserModel>((_ref) => AuthenticatedUser(UserModel()));

class AuthenticatedUser extends StateNotifier<UserModel>{
  AuthenticatedUser(UserModel state) : super(state);

  void change(UserModel user){
    state = user;
    // super(state);
  }
}


class UserModel{

  final String? documentId;
  final QueryDocumentSnapshot<Map<String, dynamic>>? user;

  UserModel({this.documentId, this.user});
}