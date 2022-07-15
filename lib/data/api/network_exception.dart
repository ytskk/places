class NetworkException implements Exception {
  NetworkException({
    required this.name,
    this.code,
    required this.message,
  });

  final String name;
  final int? code;
  final String? message;

  @override
  String toString() {
    return 'В запросе $name возникла ошибка:${code != null ? ' $code' : ''} $message';
  }
}
