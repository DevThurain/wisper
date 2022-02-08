import 'package:flutter/material.dart';
import 'package:wisper/src/network/models/demo_user.dart';

var demoUserList = [
  DemoUser(
    id: 'testing_1',
    name: 'test 1',
    image: 'https://avatars.githubusercontent.com/u/13705472?v=4',
  ),
  DemoUser(
    id: 'testing_2',
    name: 'test 2',
    image: 'https://avatars.githubusercontent.com/u/25674767?v=4',
  )
];

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
    );
  }
}
