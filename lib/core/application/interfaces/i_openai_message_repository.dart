import 'package:openai_assistant/common/utils/typedef.dart';
import 'package:openai_assistant/core/domain/entities/message/thread_message.dart';

import '../../domain/entities/message/message.dart';

abstract interface class IOpenAIMessageRepository {
  EitherFuture<ThreadMessage> createMessage(String threadId, Message message);
  EitherFuture<List<ThreadMessage>> getThreadMessages(String threadId);
  EitherFuture<ThreadMessage> getThreadMessageDetails(
      String threadId, String messageId);
}
