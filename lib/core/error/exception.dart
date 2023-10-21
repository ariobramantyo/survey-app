class ServerException implements Exception {
  String message;

  ServerException(this.message);
}

class LocalException implements Exception {
  String message;

  LocalException(this.message);
}
