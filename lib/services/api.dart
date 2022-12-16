import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poke_app/services/response.dart';

class Api {
  final _headers = {'Content-Type': 'application/json'};

  String api = 'http://10.0.2.2:8000/poke_api/';
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

  Future<Response> post(
    String path,
    dynamic data, {
    bool withFile = false,
  }) async {
    try {
      dynamic response;
      dynamic responseData;
      if (!withFile) {
        response = await http
            .post(
              Uri.parse(api + path),
              headers: _headers,
              body: jsonEncode(data),
            )
            .timeout(
              Duration(seconds: durationTimeOut),
            );
      } else {
        var request = http.MultipartRequest(
          "POST",
          Uri.parse(api + path),
        );
        data.forEach((final String key, final value) async {
          if (key == "image") {
            var pic = await http.MultipartFile.fromPath("image", value.path);
            request.files.add(pic);
          } else {
            if (value.runtimeType != List<String>) {
              request.fields[key] = value;
            } else {
              for (String item in value) {
                request.files.add(
                  http.MultipartFile.fromString(key, item),
                );
              }
            }
          }
        });
        response = await request.send().timeout(
              Duration(seconds: durationTimeOut),
            );
        responseData = await response.stream.toBytes();
      }
      if (response.statusCode == 201 || response.statusCode == 200) {
        return _responseFromJson(
          true,
          "",
          response.statusCode,
          !withFile ? response.body : String.fromCharCodes(responseData),
        );
      } else {
        return _responseFromJson(
          false,
          !withFile ? response.body : String.fromCharCodes(responseData),
          response.statusCode,
          null,
        );
      }
    } on TimeoutException catch (_) {
      return _responseFromJson(
        false,
        'The connection has timed out, Please try again!',
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

  Future<Response> delete(String path) async {
    try {
      final response = await http
          .delete(
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
