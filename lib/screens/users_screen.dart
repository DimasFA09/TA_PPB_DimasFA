import 'package:flutter/material.dart';
import 'package:store_api_flutter_course/widget/users_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return UsersWidget();
            }));
  }
}
