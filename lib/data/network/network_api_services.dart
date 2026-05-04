import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ease_tube/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../exception/app_exceptions.dart';

/// Concrete implementation of network services for Ease'TUBE
class NetworkApiService implements BaseApiServices {
  /// Performs a GET request with a 20 seconds safety timeout
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      // Specifically handles connectivity issues on devices like your itel hardware
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    }

    return responseJson;
  }

  /// Performs a POST request, typically used for authentication or form submission
  @override
  Future<dynamic> postApi(String url, dynamic data) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final Response response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    }

    return responseJson;
  }

  /// Centralized logic to map HTTP status codes to application-specific exceptions
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        // Success: parse and return the dynamic JSON body
        return jsonDecode(response.body);
      case 400:
        // Bad Request: often contains field-specific error messages
        return jsonDecode(response.body);
      case 401:
        throw BadRequestException(response.body.toString());
      case 404:
      case 500:
        // Server or resource errors
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
          'Error occurred while communicating with server',
        );
    }
  }
}
