


import 'package:flutter_riverpod/flutter_riverpod.dart';
final FollowingUsersProvider = StateNotifierProvider<FollowingUsersState,List<String>>((ref)=> FollowingUsersState([]));

class FollowingUsersState extends StateNotifier<List<String>>{

  FollowingUsersState(List<String> state) : super(state);

  void change(List<String> users) => state = users;
}