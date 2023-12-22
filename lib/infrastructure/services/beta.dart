import 'package:assistant_beta_openai/common/utils/record_utils.dart';
import 'package:assistant_beta_openai/core/domain/entities/message/message.dart';
import 'package:assistant_beta_openai/core/domain/entities/message/thread_message.dart';
import 'package:assistant_beta_openai/infrastructure/services/message/message_service.dart';
import 'package:assistant_beta_openai/infrastructure/services/run/run_service.dart';
import 'package:assistant_beta_openai/infrastructure/services/thread/thread_service.dart';

import '../../core/application/exceptions/missing_arguments_exception.dart';

class OpenAIBeta {
  static OpenAIBeta get instance => OpenAIBeta._();
  OpenAIBeta._();

  OpenAIThread get thread => OpenAIThread();
  OpenAIMessage get message => OpenAIMessage();
  OpenAIRun get run => OpenAIRun();

  Future<(Exception?, List<ThreadMessage>?)> getThreadMessages(
      String threadId) async {
    final threadMessages = await message.getThreadMessages(threadId);

    if (threadMessages == null) {
      return left(MissingArgumentsException('Thread messages is null'));
    }

    return right(threadMessages);
  }

  Future<(Exception?, ThreadMessage?)> sendMessage({
    String? threadId,
    required String assistantId,
    required String content,
  }) async {
    final userMessage = Message(content: content, role: 'user');

    if (threadId != null) {
      return _sendMessageWithThread(
          threadId: threadId,
          userMessage: userMessage,
          assistantId: assistantId);
    } else {
      return _sendMessageWithoutThread(
          assistantId: assistantId, userMessage: userMessage);
    }
  }

  Future<(Exception?, ThreadMessage?)> _sendMessageWithoutThread(
      {required String assistantId, required Message userMessage}) async {
    final threadRun = await run.createThreadAndRun(assistantId, [userMessage]);
    if (threadRun == null ||
        threadRun.id == null ||
        threadRun.threadId == null) {
      return left(MissingArgumentsException('Thread or run id is null'));
    }

    final messageId = await run.getMessageIdFromLastStep(
        runId: threadRun.id!, threadId: threadRun.threadId!);

    if (messageId == null) {
      return left(MissingArgumentsException('Message id is null'));
    }

    final messageObject =
        await message.getThreadMessageDetails(threadRun.threadId!, messageId);

    if (messageObject == null) {
      return left(MissingArgumentsException('Message object is null'));
    }

    return right(messageObject);
  }

  Future<(Exception?, ThreadMessage?)> _sendMessageWithThread({
    required String threadId,
    required Message userMessage,
    required String assistantId,
  }) async {
    final userMessageId = await message.createMessage(threadId, userMessage);

    if (userMessageId == null) {
      return left(MissingArgumentsException('User Message id is null'));
    }

    final runId =
        await run.createRun(assistantId: assistantId, threadId: threadId);

    if (runId == null) {
      return left(MissingArgumentsException('Run id is null'));
    }

    final messageId =
        await run.getMessageIdFromLastStep(runId: runId, threadId: threadId);

    if (messageId == null) {
      return left(MissingArgumentsException('Assistant Message id is null'));
    }

    final messageObject =
        await message.getThreadMessageDetails(threadId, messageId);

    if (messageObject == null) {
      return left(MissingArgumentsException('Message object is null'));
    }

    return right(messageObject);
  }
}
