// ignore_for_file: non_constant_identifier_names

import 'package:envied/envied.dart';

import 'app_config.dart';

part 'env.g.dart';

class AppEnv {
  static String get apiUrl {
    if (AppConfig.isDebug) return _DevEnv.API_URL;

    return _ProdEnv.API_URL;
  }

  static String get openAIToken {
    if (AppConfig.isDebug) return _DevEnv.OPENAI_API_TOKEN;

    return _ProdEnv.OPENAI_API_TOKEN;
  }
}

@Envied(path: '.env.dev')
abstract class _DevEnv {
  @EnviedField(varName: 'API_URL', obfuscate: true)
  static String API_URL = __DevEnv.API_URL;
  @EnviedField(varName: 'OPENAI_API_TOKEN', obfuscate: true)
  static String OPENAI_API_TOKEN = __DevEnv.OPENAI_API_TOKEN;
}

@Envied(path: '.env')
abstract class _ProdEnv {
  @EnviedField(varName: 'API_URL', obfuscate: true)
  static String API_URL = __ProdEnv.API_URL;
  @EnviedField(varName: 'OPENAI_API_TOKEN', obfuscate: true)
  static String OPENAI_API_TOKEN = __ProdEnv.OPENAI_API_TOKEN;
}
