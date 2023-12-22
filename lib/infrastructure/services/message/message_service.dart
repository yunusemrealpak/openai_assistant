import 'package:assistant_beta_openai/common/utils/record_utils.dart';
import 'package:assistant_beta_openai/core/application/interfaces/i_openai_message_repository.dart';
import 'package:assistant_beta_openai/core/domain/entities/message/message.dart';

import '../../../core/domain/entities/message/thread_message.dart';
import '../../repositories/openai_message_repository.dart';

class OpenAIMessage {
  final IOpenAIMessageRepository _repository;

  OpenAIMessage() : _repository = OpenAIMessageRepository();

  Future<String?> createMessage(String threadId, Message message) async {
    final result = await _repository.createMessage(threadId, message);

    return result.fold(
      (l) => null,
      (r) => r.id,
    );
  }

  Future<ThreadMessage?> getThreadMessageDetails(
      String threadId, String messageId) async {
    final result =
        await _repository.getThreadMessageDetails(threadId, messageId);

    return result.fold(
      (l) => null,
      (r) => r,
    );
  }

  Future<List<ThreadMessage>?> getThreadMessages(String threadId) async {
    final result = await _repository.getThreadMessages(threadId);

    return result.fold(
      (l) => null,
      (r) => r,
    );
  }
}
