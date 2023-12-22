import 'package:busenet/busenet.dart';
import 'package:openai_assistant/common/utils/typedef.dart';
import 'package:openai_assistant/core/domain/entities/run/run_step.dart';
import 'package:openai_assistant/core/domain/entities/run/thread_run.dart';

import '../../common/utils/record_utils.dart';
import '../../core/application/interfaces/i_openai_run_repository.dart';
import '../../core/domain/entities/message/message.dart';
import '../network/app_network_manager.dart';
import '../network/i_app_network_manager.dart';

final class OpenAIRunRepository implements IOpenAIRunRepository {
  final IAppNetworkManager _manager;

  OpenAIRunRepository() : _manager = AppNetworkManager.instance;

  @override
  EitherFuture<ThreadRun> createRun(String threadId, String assistantId) async {
    final response = await _manager.fetch<ThreadRun, ThreadRun>(
      "/threads/$threadId/runs",
      type: HttpTypes.post,
      parserModel: ThreadRun(),
      ignoreEntityKey: true,
      data: {
        "assistant_id": assistantId,
      },
    );

    if (response.errorType != null) {
      return left(response.errorType!);
    }

    return right(response.entity as ThreadRun);
  }

  @override
  EitherFuture<ThreadRun> createThreadAndRun(String assistantId,
      [List<Message>? messages]) async {
    final response = await _manager.fetch<ThreadRun, ThreadRun>(
      "/threads/runs",
      type: HttpTypes.post,
      parserModel: ThreadRun(),
      ignoreEntityKey: true,
      data: {
        "assistant_id": assistantId,
        "thread": {
          "messages": messages?.map((e) => e.toJson()).toList(),
        }
      },
    );

    if (response.errorType != null) {
      return left(response.errorType!);
    }

    return right(response.entity as ThreadRun);
  }

  @override
  EitherFuture<List<RunStep>> getListRunSteps(
      String runId, String threadId) async {
    final response = await _manager.fetch<RunStep, List<RunStep>>(
      "/threads/$threadId/runs/$runId/steps",
      type: HttpTypes.get,
      parserModel: RunStep(),
    );

    if (response.errorType != null) {
      return left(response.errorType!);
    }

    return right(response.entity as List<RunStep>);
  }
}
