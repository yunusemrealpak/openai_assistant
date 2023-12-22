import 'package:openai_assistant/core/application/interfaces/i_openai_asistant_repository.dart';

import '../../repositories/openai_assistant_repository.dart';

class OpenAIAssistant {
  final IOpenAIAssistantRepository _repository;

  OpenAIAssistant() : _repository = OpenAIAssistantRepository();
}
