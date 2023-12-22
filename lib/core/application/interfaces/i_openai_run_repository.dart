import 'package:assistant_beta_openai/common/utils/typedef.dart';
import 'package:assistant_beta_openai/core/domain/entities/run/thread_run.dart';

import '../../domain/entities/message/message.dart';
import '../../domain/entities/run/run_step.dart';

abstract interface class IOpenAIRunRepository {
  EitherFuture<ThreadRun> createThreadAndRun(String assistantId,
      [List<Message>? messages]);
  EitherFuture<ThreadRun> createRun(String threadId, String assistantId);
  EitherFuture<List<RunStep>> getListRunSteps(String runId, String threadId);
}
