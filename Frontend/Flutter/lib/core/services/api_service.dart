import 'dart:convert' show jsonEncode;

import 'package:flutter/rendering.dart' show debugPrint;
import 'package:http/http.dart' as http;

import '../models/api_models/response_model.dart';

class ApiService {
  const ApiService._();

  static const ApiService instance = ApiService._();

  //Write "ipconfig" in comandLine to get ip addess.
  //To worek with any route write: php artisan serve --host=0.0.0.0 --port=8000
  //in backend folder.
  static const String _baseUrl = 'http://192.168.43.156:8000/api';
  static const _timeout = Duration(seconds: 20);

  //http://192.168.8.178:8000/api/orders/index
  Future<ResponseModel> get(String endPoint) async {
    debugPrint('HTTPS GET');

    final response = await http.get(_getUri(endPoint));
    return ResponseModel.fomMap(response);
  }

  Future<ResponseModel> post(
    String endPoint, {
    Map<String, String>? parameters,
    Map<String, dynamic>? body,
  }) async {
    debugPrint('HTTPS POST');
    debugPrint('body => $body');

    final response = await http
        .post(
          _getUri(endPoint),
          headers: _requestHeaders(),
          body: jsonEncode(body),
        )
        .timeout(_timeout);

    return _response(response);
  }

  Future<ResponseModel> put(
    String endPoint, {
    Map<String, String>? parameters,
    Map<String, dynamic>? body,
  }) async {
    debugPrint('HTTPS PUT');
    debugPrint('body => $body');

    final response = await http
        .put(
          _getUri(endPoint),
          headers: _requestHeaders(),
          body: jsonEncode(body),
        )
        .timeout(_timeout);

    return _response(response);
  }

  Future<ResponseModel> patch(
    String endPoint, {
    Map<String, String>? parameters,
    Map<String, dynamic>? body,
  }) async {
    debugPrint('HTTPS PATCH');
    debugPrint('body => $body');

    final response = await http
        .patch(
          _getUri(endPoint),
          headers: _requestHeaders(),
          body: jsonEncode(body),
        )
        .timeout(_timeout);

    return _response(response);
  }

  Future<ResponseModel> delete(
    String endPoint, {
    Map<String, String>? parameters,
    Map<String, dynamic>? body,
  }) async {
    debugPrint('HTTPS DELETE');
    debugPrint('body => $body');

    final response = await http
        .delete(
          _getUri(endPoint),
          headers: _requestHeaders(),
          body: jsonEncode(body),
        )
        .timeout(_timeout);

    return _response(response);
  }

  static Uri _getUri(String endPoint) {
    final String url = '$_baseUrl/$endPoint';
    debugPrint('url => $url');
    return Uri.parse(url);
  }

  static Map<String, String> _requestHeaders() {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }

  ResponseModel _response(http.Response response) {
    //Why do we use this method _response?
    //we can jest call ResponseModel.fomMap(response) method
    //without change the response to http.Respons?Is this right?
    return ResponseModel.fomMap(response);
  }
}
