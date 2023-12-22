class OpenAIConfig {
  static final OpenAIConfig _instance = OpenAIConfig._();

  OpenAIConfig._();

  static OpenAIConfig get instance {
    return _instance;
  }

  String get apiBaseUrl => 'https://api.openai.com/';
  String get apiVersion => 'v1';

  String get apiBaseUrlWithVersion => '$apiBaseUrl/$apiVersion';

  set apiBaseUrl(String apiBaseUrl) {
    this.apiBaseUrl = apiBaseUrl;
  }

  set apiVersion(String apiVersion) {
    this.apiVersion = apiVersion;
  }
}
