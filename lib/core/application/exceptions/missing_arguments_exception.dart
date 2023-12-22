class MissingArgumentsException implements Exception {
  final String message;

  MissingArgumentsException(this.message);

  @override
  String toString() => message;
}
