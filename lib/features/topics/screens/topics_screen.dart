import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/core/widgets/avatar/avatar_widget.dart';
import 'package:surf_practice_chat_flutter/features/app_bar/widgets/chat_app_bar.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth_screen.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat_screen.dart';
import 'package:surf_practice_chat_flutter/features/topics/bloc/logout/bloc.dart';
import 'package:surf_practice_chat_flutter/features/topics/bloc/topics/bloc.dart';
import 'package:surf_practice_chat_flutter/features/topics/models/chat_topic_dto.dart';

/// Screen with different chat topics to go to.
class TopicsScreen extends StatefulWidget {
  static const route = '/topics';

  const TopicsScreen({Key? key}) : super(key: key);

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  @override
  void initState() {
    _update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        onUpdatePressed: _update,
        title: 'Чаты',
        leading: BlocListener<AppBarBloc, AppBarState>(
          listenWhen: (_, state) => state is LogoutState,
          listener: (context, _) {
            Navigator.pushReplacementNamed(context, AuthScreen.route);
          },
          child: IconButton(
            onPressed: () => _singOut(context),
            icon: const Icon(Icons.logout),
          ),
        ),
      ),
      body: BlocBuilder<TopicsBloc, TopicsState>(
        builder: (context, state) {
          return _TopicsBody(topics: state.topics);
        },
      ),
    );
  }

  void _update() {
    const event = GetMessagesEvent();
    context.read<TopicsBloc>().add(event);
  }

  void _singOut(BuildContext context) {
    const event = SingOutEvent();
    context.read<AppBarBloc>().add(event);
  }
}

class _TopicsBody extends StatelessWidget {
  final Iterable<ChatTopicDto> topics;

  const _TopicsBody({required this.topics});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: topics.length,
      itemBuilder: (_, index) => _TopicItem(
        topic: topics.elementAt(index),
      ),
    );
  }
}

class _TopicItem extends StatelessWidget {
  final ChatTopicDto topic;

  const _TopicItem({required this.topic});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AvatarWidget(model: topic, size: 40),
      title: Text(topic.name),
      subtitle: topic.description != null ? Text(topic.description!) : null,
      onTap: () => _openChat(context),
    );
  }

  void _openChat(BuildContext context) {
    Navigator.pushNamed(context, ChatScreen.route, arguments: topic);
  }
}
