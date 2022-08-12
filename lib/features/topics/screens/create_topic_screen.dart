import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/core/widgets/buttons/simple_button.dart';
import 'package:surf_practice_chat_flutter/features/app_bar/widgets/chat_app_bar.dart';
import 'package:surf_practice_chat_flutter/features/topics/bloc/create_topic/bloc.dart';

/// Screen, that is used for creating new chat topics.
class CreateTopicScreen extends StatelessWidget {
  static const route = '/create_topic';

  const CreateTopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatAppBar(
        title: 'Создание чата',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: _CreateTopicBody(),
        ),
      ),
    );
  }
}

class _CreateTopicBody extends StatefulWidget {
  const _CreateTopicBody();

  @override
  State<_CreateTopicBody> createState() => _CreateTopicBodyState();
}

class _CreateTopicBodyState extends State<_CreateTopicBody> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();

    _nameController.addListener(onDataEnter);
    _descriptionController.addListener(onDataEnter);

    super.initState();
  }

  void onDataEnter() {
    final event = EnterDataEvent(
      name: _nameController.text,
      description: _descriptionController.text,
    );

    context.read<CreateTopicBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTopicBloc, CreateTopicState>(
      listenWhen: (_, state) => state is TopicSavedState,
      listener: (context, _) => Navigator.pop(context),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Название:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextField(
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            Text(
              'Описание:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextField(
              controller: _descriptionController,
            ),
            const Spacer(),
            SimpleButton(
              isLoading: false,
              isActive: state.isReady,
              onPressed: () {
                const event = SaveEventEvent();
                context.read<CreateTopicBloc>().add(event);
              },
              title: 'Cохранить',
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
