import 'package:assistant_beta_openai/assistant_beta_openai.dart';
import 'package:example/common/env/env.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isLoading = false;

  String? threadId;

  final TextEditingController _controller = TextEditingController();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    OpenAI.apiKey = AppEnv.openAIToken;
  }

  void changeLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future sendMessage(Message message) async {
    setState(() {
      messages.add(message);
    });

    _controller.clear();

    changeLoading(true);
    final (exception, threadMessage) = await OpenAI.instance.beta.sendMessage(
        threadId: threadId,
        assistantId: '<your-assistant-id>',
        content: message.content ?? '');

    if (exception != null) {
      print('exception: $exception');
      changeLoading(false);
      return;
    }

    print(threadMessage?.threadId);

    setState(() {
      threadId = threadMessage?.threadId;
      messages.add(Message(
          role: 'assistant',
          content: threadMessage?.content?.first.text?.value ?? ''));
    });

    changeLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Assistant Beta OpenAI'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ListTile(
                    title: Text(message.content ?? ''),
                    subtitle: Text(message.role ?? ''),
                  );
                },
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message',
                suffixIcon: isLoading
                    ? const CircularProgressIndicator()
                    : InkWell(
                        onTap: () => sendMessage(Message(
                              content: _controller.text,
                              role: 'user',
                            )),
                        child: const Icon(Icons.send)),
              ),
              onSubmitted: (value) {
                sendMessage(Message(
                  content: value,
                  role: 'user',
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
