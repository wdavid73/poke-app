import 'package:dio/dio.dart';

abstract class ResponseState<T> {
  final T? data;
  final int? statusCode;
  final DioException? error;

  const ResponseState({this.data, this.statusCode, this.error});
}

class ResponseSuccess<T> extends ResponseState<T> {
  const ResponseSuccess(T data, int statusCode)
      : super(data: data, statusCode: statusCode);
}

class ResponseFailed<T> extends ResponseState<T> {
  const ResponseFailed(DioException error) : super(error: error);
}
