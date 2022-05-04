import 'package:dio/dio.dart';
import 'package:places/data/api/api_constants.dart';

BaseOptions _baseOptions = BaseOptions(
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  responseType: ResponseType.json,
);

InterceptorsWrapper _interceptorsWrapper = InterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    print('onRequest: ${options.method} ${options.path}, ${options.data}');

    return handler.next(options);
  },
  onResponse: (Response response, ResponseInterceptorHandler handler) {
    print('onResponse: ${response.statusCode} ${response.statusMessage}');

    return handler.next(response);
  },
  onError: (DioError error, ErrorInterceptorHandler handler) {
    print(
        'onError: ${error.response?.statusCode} ${error.response?.statusMessage}');

    return handler.next(error);
  },
);

/// Provides client for API, based on dio.
///
/// It uses [_baseOptions] and [_interceptorsWrapper] as base options.
class ClientApi {
  static Dio createDio({String baseUrl = ApiConstants.basePlacesUrl}) {
    BaseOptions options = _baseOptions.copyWith(baseUrl: baseUrl);

    final Dio dio = Dio(options);

    return dio;
  }

  static Dio createDioWithInterceptors({
    String baseUrl = ApiConstants.basePlacesUrl,
    InterceptorsWrapper? interceptorsWrapper,
  }) {
    InterceptorsWrapper interceptors =
        interceptorsWrapper ?? _interceptorsWrapper;

    final Dio dio = ClientApi.createDio(baseUrl: baseUrl);

    return dio..interceptors.add(interceptors);
  }

  /// Simple getters for dio with manual configuration. For simple usage.
  static Dio get dio => createDio();

  static Dio get dioWithInterceptors => createDioWithInterceptors();

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async =>
      dioWithInterceptors.get(
        path,
        queryParameters: queryParameters,
      );

  Future<Response> post(
    String path, {
    required dynamic data,
  }) async =>
      dioWithInterceptors.post(path, data: data);
}
