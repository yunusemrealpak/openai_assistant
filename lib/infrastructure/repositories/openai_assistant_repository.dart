import '../../core/application/interfaces/i_openai_asistant_repository.dart';
import '../network/app_network_manager.dart';
import '../network/i_app_network_manager.dart';

class OpenAIAssistantRepository implements IOpenAIAssistantRepository {
  final IAppNetworkManager manager;
  OpenAIAssistantRepository() : manager = AppNetworkManager.instance;
}
