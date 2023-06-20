import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mvvm_api/utils/extensions/string.dart';
import 'error.dart';

const Map<String, String> defaultHeaders = {
  'Content-Type': 'application/json',
  'accept': 'application/json',
};

/// HTTP `GET` request that returns the decoded body of payload
/// Handles different error scenarios with appropriate exceptions
Future<dynamic> getJson(String url, BuildContext context , {Map<String, String>? headers}) {
  "--> requesting $url ${headers != null ? "with headers $headers" : ""}"
      .log(Reaction.info);
  return http
      .get(Uri.parse(url), headers: {...defaultHeaders, ...?headers})
      .timeout(const Duration(minutes: 2))
      .then((response) {
    "--> response ${response.statusCode} $url".log(Reaction.info);
    if (response.statusCode <= 230 && response.statusCode >= 200) {
      return jsonDecode(response.body);
    }
    Navigator.of(context).pop();
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw ServerException(response.body.toString());
      default:
        final error = ApiError(
            'Error occurred while communication with server with status_code: ${response.statusCode} and url $url');
        throw error;
    }
  }, onError: (error) {
    Navigator.of(context).pop();
    "--> API ERROR $url".log(Reaction.error);
    if (error is SocketException) {
      String errorMessage = "No internet or api offline";
      debugPrint("--> error: $errorMessage");
      throw RemoteSourceNotAvailable(errorMessage);
    }
    debugPrint(error.runtimeType.toString());
    throw ApiError("Unexpected error occurred");
  });
}

/// HTTP `POST` request that returns the decoded body of payload
/// Handles different error scenarios with appropriate exceptions
Future<dynamic> postJson(String url, Object body, BuildContext context,
    {Map<String, String>? headers,}) {
  "--> requesting $url with body ${jsonEncode(body)} ${headers != null ? "and with headers $headers" : ""}"
      .log(Reaction.info);
  return http
      .post(Uri.parse(url),
      body: jsonEncode(body), headers: {...defaultHeaders, ...?headers})
      .timeout(const Duration(minutes: 2))
      .then((response) {
    "--> response ${response.statusCode} $url".log(Reaction.info);
    if (response.statusCode <= 230 && response.statusCode >= 200) {
      return jsonDecode(response.body);
    }
    Navigator.of(context).pop();
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        final error = ApiError(
            'Error occurred while communication with server with status_code: ${response.statusCode} and url $url');
        throw error;
    }
  }, onError: (error) {
    Navigator.of(context).pop();
    "--> API ERROR $url".log(Reaction.error);
    if (error is SocketException) {
      String errorMessage = "No internet or api offline";
      debugPrint("--> error: $errorMessage");
      throw RemoteSourceNotAvailable(errorMessage);
    }
    error.runtimeType.toString().log(Reaction.warning);
    throw ApiError("Unexpected error occurred");
  });
}

/// HTTP PUT for updating the title and description
/// Handles different error scenarios with appropriate exceptions
Future<dynamic> putJson(String url, Object body, BuildContext context, {Map<String, String>? headers}) {
  "--> requesting $url with body ${jsonEncode(body)} ${headers != null
      ? "and with headers $headers"
      : ""}"
      .log(Reaction.info);
  return http
      .put(Uri.parse(url),
      body: jsonEncode(body), headers: {...defaultHeaders, ...?headers})
      .timeout(const Duration(minutes: 2))
      .then((response) {
    "--> response ${response.statusCode} $url".log(Reaction.info);
    if (response.statusCode <= 230 && response.statusCode >= 200) {
      return jsonDecode(response.body);
    }
    Navigator.of(context).pop();
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        final error = ApiError(
            'Error occurred while communication with server with status_code: ${response
                .statusCode} and url $url');
        throw error;
    }
  }, onError: (error) {
    Navigator.of(context).pop();
    "--> API ERROR $url".log(Reaction.error);
    if (error is SocketException) {
      String errorMessage = "No internet or api offline";
      debugPrint("--> error: $errorMessage");
      throw RemoteSourceNotAvailable(errorMessage);
    }
    error.runtimeType.toString().log(Reaction.warning);
    throw ApiError("Unexpected error occurred");
  });
}




