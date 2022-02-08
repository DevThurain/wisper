import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:wisper/src/network/models/demo_user.dart';
import 'package:wisper/src/ui/channel/channel_screen.dart';

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
  bool _isLoading = false;

  /// Method to connect a user.
  Future<void> _connectUser(DemoUser demoUser) async {
    setState(() {
      _isLoading = true;
    });

    final client = StreamChat.of(context).client;
    try {
      await client.connectUser(
        User(
          id: demoUser.id,
          name: demoUser.name,
          image: demoUser.image,
        ),
        client.devToken(demoUser.id).rawValue,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ChannelScreen()),
      );
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Text(
                    'Select a User',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ...demoUserList.map((u) => UserTile(
                              user: u,
                              callback: _connectUser,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final Function callback;
  final DemoUser user;

  UserTile({required this.user, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage: Image.network(user.image).image,
      ),
      title: Text(user.name),
      onTap: () => callback(user),
    );
  }
}
