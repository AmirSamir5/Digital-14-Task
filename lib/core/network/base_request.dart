import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digital_14_task/core/network/app_exceptions.dart';
import 'package:digital_14_task/core/network/base_error.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../helpers/constants.dart';

enum NETWORK_REQUEST_TYPE { GET, POST }
enum SERVER_SECURITY_TYPE { HTTP, HTTPS }

class BaseRequest {
  NETWORK_REQUEST_TYPE requestType;
  String url;
  Map<String, String>? headers;

  BaseRequest({
    required this.url,
    this.requestType = NETWORK_REQUEST_TYPE.GET,
    this.headers,
  });

  @override
  String toString() {
    return 'URL: $url\n'
        'Headers: $headers\n'
        'Request Type: ${requestType == NETWORK_REQUEST_TYPE.GET ? "GET" : "POST"}\n';
  }

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> sendRequest(Map<String, dynamic> reqBody,
      [String param = '']) async {
    var response;

    Uri uri = Uri.parse(url);

    var requestEncoded = json.encode(reqBody);

    try {
      if (requestType == NETWORK_REQUEST_TYPE.POST) {
        response = await http
            .post(uri, body: requestEncoded, headers: headers)
            .timeout(
              const Duration(seconds: ApiBaseUrl.appTimeOut),
            );
      } else {
        response = await http
            .get(uri, headers: headers)
            .timeout(const Duration(seconds: ApiBaseUrl.appTimeOut));
      }
      return _returnResponse(response);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw AppTimeOutException();
    } on FormatException catch (e) {
      throw InvalidInputException();
    } catch (e) {
      throw FetchDataException();
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return _decoder.convert(utf8.decode(response.bodyBytes));
      default:
        BaseError baseError = BaseError.fromJson(
            _decoder.convert(utf8.decode(response.bodyBytes)));
        throw PlatformException(
          message: baseError.errorMessage ?? '',
          code: baseError.status ?? '',
        );
    }
  }
}
