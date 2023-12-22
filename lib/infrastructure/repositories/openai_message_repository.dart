import 'package:assistant_beta_openai/common/utils/typedef.dart';
import 'package:assistant_beta_openai/core/domain/entities/message/message.dart';
import 'package:assistant_beta_openai/core/domain/entities/message/thread_message.dart';
import 'package:busenet/busenet.dart';

import '../../common/utils/record_utils.dart';
import '../../core/application/interfaces/i_openai_message_repository.dart';
import '../network/app_network_manager.dart';
import '../network/i_app_network_manager.dart';

final class OpenAIMessageRepository implements IOpenAIMessageRepository {
  final IAppNetworkManager _manager;

  OpenAIMessageRepository() : _manager = AppNetworkManager.instance;

  @override
  EitherFuture<ThreadMessage> createMessage(
      String threadId, Message message) async {
    final response = await _manager.fetch<ThreadMessage, ThreadMessage>(
      "/threads/$threadId/messages",
      type: HttpTypes.post,
      parserModel: ThreadMessage(),
      ignoreEntityKey: true,
      data: message.toJson(),
    );

    if (response.errorType != null) {
      return left(response.errorType!);
    }

    return right(response.entity as ThreadMessage);
  }

  @override
  EitherFuture<ThreadMessage> getThreadMessageDetails(
      String threadId, String messageId) async {
    final response = await _manager.fetch<ThreadMessage, ThreadMessage>(
      "/threads/$threadId/messages/$messageId",
      type: HttpTypes.get,
      parserModel: ThreadMessage(),
      ignoreEntityKey: true,
    );

    if (response.errorType != null) {
      return left(response.errorType!);
    }

    return right(response.entity as ThreadMessage);
  }

  @override
  EitherFuture<List<ThreadMessage>> getThreadMessages(String threadId) async {
    final response = await _manager.fetch<ThreadMessage, List<ThreadMessage>>(
      "/threads/$threadId/messages",
      type: HttpTypes.get,
      parserModel: ThreadMessage(),
    );

    if (response.errorType != null) {
      return left(response.errorType!);
    }

    return right(response.entity as List<ThreadMessage>);
  }
}
