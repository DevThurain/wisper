import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:wisper/src/ui/channel/channel_page.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({Key? key}) : super(key: key);

  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Channel"),
        actions: [TextButton(onPressed: () {}, child: Text('Disconnect',style: TextStyle(color: Colors.white),))],
      ),
       body: ChannelsBloc(
        child: ChannelListView(
          filter: Filter.in_(
            'members',
            [StreamChat.of(context).currentUser!.id],
          ),
          sort: const [SortOption('last_message_at')],
          limit: 20,
          channelWidget: const ChannelPage(),
          emptyBuilder: (context) => const CreateChannelFromUsers(), // Add this

        ),
      ),
    );
  }
}


class CreateChannelFromUsers extends StatelessWidget {
  const CreateChannelFromUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UsersBloc(
      child: UserListView(
        filter: Filter.notIn('id', [StreamChat.of(context).currentUser!.id]),
        limit: 20,
        onUserTap: (user, widget) {
          StreamChat.of(context)
              .client
              .createChannel('messaging', channelData: {
            'members': [user.id, StreamChat.of(context).currentUser!.id]
          });
        },
      ),
    );
  }
}