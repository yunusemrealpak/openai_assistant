import 'package:busenet/busenet.dart';
import 'package:openai_assistant/common/utils/typedef.dart';
import 'package:openai_assistant/core/domain/entities/message/message.dart';
import 'package:openai_assistant/core/domain/entities/thread/thread.dart';
import 'package:openai_assistant/infrastructure/network/i_app_network_manager.dart';

import '../../common/utils/record_utils.dart';
import '../../core/application/interfaces/i_openai_thread_repository.dart';
import '../network/app_network_manager.dart';

final class OpenAIThreadRepository implements IOpenAIThreadRepository {
  final IAppNetworkManager _manager;

  OpenAIThreadRepository() : _manager = AppNetworkManager.instance;

  @override
  EitherFuture<Thread> createThread([List<Message>? messages]) async {
    Map<String, dynamic>? data;

    if (messages != null) {
      data = {
        "messages": messages.map((e) => e.toJson()).toList(),
      };
    }

    final response = await _manager.fetch<Thread, Thread>(
      "/threads",
      type: HttpTypes.post,
      parserModel: Thread(),
      ignoreEntityKey: true,
      data: data,
    );

    if (response.errorType != null) {
      return left(response.errorType!);
    }

    return right(response.entity as Thread);
  }

  @override
  EitherFuture<void> deleteThread(String threadId) async {
    final response = await _manager.fetch<NoResultResponse, NoResultResponse>(
      "/threads/$threadId",
      type: HttpTypes.delete,
      parserModel: NoResultResponse(),
      ignoreEntityKey: true,
    );

    if (response.errorType != null) {
      return left(response.errorType!);
    }

    return right(null);
  }

  @override
  EitherFuture<Thread> getThreadDetails(String threadId) async {
    final response = await _manager.fetch<Thread, Thread>(
      "/threads/$threadId",
      type: HttpTypes.get,
      parserModel: Thread(),
      ignoreEntityKey: true,
    );

    if (response.errorType != null) {
      return left(response.errorType!);
    }

    return right(response.entity as Thread);
  }
}
