import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zen_active/utils/prefs_helper.dart';
import '../Utils/app_constants.dart';
import 'api_constant.dart';

class DioApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static const String noInternetMessage =
      "Sorry! Something went wrong, please try again";

  static Future<void> _setAuthHeader() async {
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    _dio.options.headers['Authorization'] = 'Bearer $bearerToken';
  }

  static Future<Response> getData(String uri,
      {Map<String, dynamic>? query}) async {
    await _setAuthHeader();
    try {
      debugPrint('====> API Call: GET $uri');
      return await _dio.get(uri, queryParameters: query);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> postData(String uri, dynamic body) async {
    await _setAuthHeader();
    try {
      debugPrint('====> API Call: POST $uri\nBody: $body');
      return await _dio.post(uri, data: body);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> patchData(String uri, dynamic body) async {
    await _setAuthHeader();
    try {
      debugPrint('====> API Call: PATCH $uri\nBody: $body');
      return await _dio.patch(uri, data: body);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> putData(String uri, dynamic body) async {
    await _setAuthHeader();
    try {
      debugPrint('====> API Call: PUT $uri\nBody: $body');
      return await _dio.put(uri, data: body);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> deleteData(String uri, {dynamic body}) async {
    await _setAuthHeader();
    try {
      debugPrint('====> API Call: DELETE $uri\nBody: $body');
      return await _dio.delete(uri, data: body);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> postMultipartData(
      String uri, Map<String, String> body,
      {required List<MultipartBody> multipartBody}) async {
    await _setAuthHeader();
    try {
      FormData formData = FormData.fromMap(body);
      for (MultipartBody element in multipartBody) {
        formData.files.add(MapEntry(
          element.key,
          await MultipartFile.fromFile(element.file.path),
        ));
      }
      debugPrint('====> API Call: POST Multipart $uri');
      return await _dio.post(uri, data: formData);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> patchMultipartData(
      String uri, Map<String, String> body,
      {required List<MultipartBody> multipartBody}) async {
    await _setAuthHeader();
    try {
      FormData formData = FormData.fromMap(body);
      for (MultipartBody element in multipartBody) {
        formData.files.add(MapEntry(
          element.key,
          await MultipartFile.fromFile(element.file.path),
        ));
      }
      debugPrint('====> API Call: PATCH Multipart $uri');
      return await _dio.patch(uri, data: formData);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Response _handleError(dynamic error) {
    if (error is DioException) {
      debugPrint('Dio Error: ${error.message}');
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: error.response?.statusCode ?? 1,
        statusMessage: error.message ?? noInternetMessage,
        data: error.response?.data ?? {},
      );
    }
    return Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 1,
      statusMessage: noInternetMessage,
    );
  }
}

class MultipartBody {
  String key;
  File file;
  MultipartBody(this.key, this.file);
}
