import 'package:openai_assistant/common/utils/record_utils.dart';
import 'package:openai_assistant/core/application/interfaces/i_openai_run_repository.dart';
import 'package:openai_assistant/core/domain/entities/run/thread_run.dart';

import '../../../core/domain/entities/message/message.dart';
import '../../repositories/openai_run_repository.dart';

class OpenAIRun {
  final IOpenAIRunRepository _repository;

  OpenAIRun() : _repository = OpenAIRunRepository();

  Future<String?> createRun(
      {required String threadId, required String assistantId}) async {
    final result = await _repository.createRun(threadId, assistantId);

    return result.fold(
      (l) => null,
      (r) => r.id,
    );
  }

  Future<ThreadRun?> createThreadAndRun(String assistantId,
      [List<Message>? messages]) async {
    final result = await _repository.createThreadAndRun(assistantId, messages);

    return result.fold(
      (l) => null,
      (r) => r,
    );
  }

  Future<String?> getMessageIdFromLastStep({
    required String runId,
    required String threadId,
  }) async {
    final result = await _repository.getListRunSteps(runId, threadId);

    return await result.fold(
      (l) => null,
      (r) async {
        if (r.isEmpty) {
          await Future.delayed(const Duration(seconds: 1));
          return getMessageIdFromLastStep(runId: runId, threadId: threadId);
        }

        final lastStep = r.first;

        if (lastStep.status != 'completed') {
          await Future.delayed(const Duration(seconds: 1));
          return getMessageIdFromLastStep(runId: runId, threadId: threadId);
        }

        return lastStep.stepDetails?.messageCreation?.messageId == null
            ? null
            : lastStep.stepDetails!.messageCreation!.messageId!;
      },
    );
  }
}
