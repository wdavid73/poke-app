import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:poke_app/services/response.dart';

class Api {
  final _headers = {'Content-Type': 'application/json'};

  String api = 'https://poke-api-django.herokuapp.com/poke_api/';
  int durationTimeOut = 60;

  Future<Response> get(String path) async {
    try {
      final response = await http
          .get(
            Uri.parse(api + path),
            headers: _headers,
          )
          .timeout(
            Duration(seconds: durationTimeOut),
          );
      if (response.statusCode == 200) {
        return _responseFromJson(
          true,
          "",
          response.statusCode,
          response.body,
        );
      }
      return _responseFromJson(
        false,
        response.body,
        response.statusCode,
        null,
      );
    } on TimeoutException catch (_) {
      return _responseFromJson(
        false,
        "The connection has timed out, Please try again!",
        500,
        null,
      );
    } catch (e) {
      Map<String, dynamic> error = errorResponse(e);
      return _responseFromJson(
        error['statusCode'],
        error['message'],
        500,
        error['data'],
      );
    }
  }

  Map<String, dynamic> errorResponse(Object e) {
    if (e.toString().contains("No route to host") ||
        e.toString().contains("No address associated with hostname") ||
        e.toString().contains("Connection refused") ||
        e.toString().contains("Network is unreachable")) {
      return {
        "statusCode": false,
        "message": "Check your device's data or Wi-Fi connection.",
        "data": null,
      };
    } else {
      return {
        "statusCode": false,
        "message": 'Internal error. Contact support.',
        "data": null,
      };
    }
  }

  Response _responseFromJson(
    bool status,
    String message,
    int httpCode,
    dynamic data,
  ) {
    return Response(
      status,
      message,
      httpCode,
      data,
    );
  }
}
