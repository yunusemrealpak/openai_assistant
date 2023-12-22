import 'package:assistant_beta_openai/common/utils/record_utils.dart';
import 'package:assistant_beta_openai/core/application/interfaces/i_openai_thread_repository.dart';

import '../../../core/domain/entities/message/message.dart';
import '../../repositories/openai_thread_repository.dart';

class OpenAIThread {
  final IOpenAIThreadRepository _repository;

  OpenAIThread() : _repository = OpenAIThreadRepository();

  Future<String?> createThread([List<Message>? messages]) async {
    final result = await _repository.createThread(messages);

    return result.fold(
      (l) => null,
      (r) => r.id,
    );
  }

  Future<bool> deleteThread(String threadId) async {
    final result = await _repository.deleteThread(threadId);

    return result.fold(
      (l) => false,
      (r) => true,
    );
  }
}
