import '../../../common/utils/typedef.dart';
import '../../domain/entities/message/message.dart';
import '../../domain/entities/thread/thread.dart';

abstract interface class IOpenAIThreadRepository {
  EitherFuture<Thread> createThread([List<Message>? messages]);
  EitherFuture<Thread> getThreadDetails(String threadId);
  EitherFuture<void> deleteThread(String threadId);
}
