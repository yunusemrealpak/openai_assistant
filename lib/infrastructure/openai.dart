import 'package:assistant_beta_openai/infrastructure/network/app_network_manager.dart';
import 'package:assistant_beta_openai/infrastructure/services/beta.dart';

class OpenAI {
  static final OpenAI _instance = OpenAI._();

  OpenAI._();

  /// The API key used to authenticate the requests.
  static String? _internalApiKey;

  /// The singleton instance of [OpenAI], make sure to call the [OpenAI.initialize] method before accessing [instance], otherwise it will throw an [Exception].
  /// A [MissingApiKeyException] will be thrown, if the API key is not set.
  static OpenAI get instance {
    if (_internalApiKey == null) {
      throw Exception("""
      You must set the api key before accessing the instance of this class.
      Example:
      OpenAI.apiKey = "Your API Key";
      """);
    }

    return _instance;
  }

  static String? get apiKey => _internalApiKey;

  static set apiKey(String? apiKey) {
    _internalApiKey = apiKey;

    if (apiKey != null) {
      AppNetworkManager.instance.addAuthorizationHeader(apiKey);
    }
  }

  OpenAIBeta get beta => OpenAIBeta.instance;
}
