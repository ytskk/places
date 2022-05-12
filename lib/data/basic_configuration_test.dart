import 'package:dio/dio.dart';

Dio dio = Dio(baseOptions);

BaseOptions baseOptions = new BaseOptions(
  baseUrl: 'https://jsonplaceholder.typicode.com',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  responseType: ResponseType.json,
);

Future<dynamic> getUsers() async {
  usersInterceptors();
  final Response response = await dio.get('/users');

  if (response.statusCode == 200) {
    return response.data;
  }

  throw Exception('Failed to load users');
}

void usersInterceptors() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) {
        print('onRequest: ${options.method} ${options.path}');

        return handler.next(options);
      },
      onResponse: (
        Response response,
        ResponseInterceptorHandler handler,
      ) {
        print('onResponse: ${response.statusCode} ${response.statusMessage}');

        return handler.next(response);
      },
      onError: (
        DioError error,
        ErrorInterceptorHandler handler,
      ) {
        print(
            'onError: ${error.response?.statusCode} ${error.response?.statusMessage}');

        return handler.next(error);
      },
    ),
  );
}
