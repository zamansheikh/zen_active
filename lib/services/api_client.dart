// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:zen_active/utils/prefs_helper.dart';
import 'package:http_parser/http_parser.dart';
import 'package:zen_active/utils/uitls.dart';
import '../Utils/app_constants.dart';
import 'api_constant.dart';

class ApiClient extends GetxService {
  static var client = http.Client();

  static const String noInternetMessage =
      "Sorry! Something went wrong please try again";
  static const int timeoutInSeconds = 30;
  static String bearerToken = "";

  static Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken'
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');

      http.Response response = await client
          .get(
            Uri.parse(ApiConstant.baseUrl + uri),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      // 'Content-Type': 'application/x-www-form-urlencoded',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await client
          .post(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: body,
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      debugPrint(
          "==========> Response Post Method :------ : ${response.statusCode}");
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> postMultipartData(
      String uri, Map<String, String> body,
      {required List<MultipartBody> multipartBody,
      Map<String, String>? headers}) async {
    try {
      bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Authorization': 'Bearer $bearerToken',
      };

      if (headers != null) {
        mainHeaders.addAll(headers);
      }

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} files');

      var request =
          http.MultipartRequest('POST', Uri.parse(ApiConstant.baseUrl + uri));
      request.headers.addAll(mainHeaders);
      request.fields.addAll(body);

      for (MultipartBody element in multipartBody) {
        String mimeType = _getMimeType(element.file.path);

        request.files.add(await http.MultipartFile.fromPath(
          element.key,
          element.file.path,
          contentType:
              MediaType.parse(mimeType), // Set content type dynamically
        ));
      }

      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> patchData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      try {
        http.Response response = await client.patch(
          Uri.parse(ApiConstant.baseUrl + uri),
          body: jsonEncode(body), // Ensure JSON encoding
          headers: headers ?? mainHeaders,
        );
      } catch (e) {
        llg(e.toString());
      }

      http.Response response = await client
          .patch(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: body, // Ensure JSON encoding
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));

      debugPrint("==========> Response Patch Method : ${response.statusCode}");
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> patchMultipartData(
      String uri, Map<String, String> body,
      {required List<MultipartBody> multipartBody,
      Map<String, String>? headers}) async {
    try {
      bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Authorization': 'Bearer $bearerToken',
      };

      if (headers != null) {
        mainHeaders.addAll(headers);
      }

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} files');

      var request =
          http.MultipartRequest('PATCH', Uri.parse(ApiConstant.baseUrl + uri));
      request.headers.addAll(mainHeaders);
      request.fields.addAll(body);

      for (MultipartBody element in multipartBody) {
        String mimeType = _getMimeType(element.file.path);

        request.files.add(await http.MultipartFile.fromPath(
          element.key,
          element.file.path,
          contentType: MediaType.parse(mimeType), // Set content type
        ));
      }

      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  /// Helper function to determine MIME type based on file extension
  static String _getMimeType(String filePath) {
    String extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'application/octet-stream'; // Default if unknown
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken'
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await http
          .put(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> putMultipartData(String uri, Map<String, String> body,
      {required List<MultipartBody> multipartBody,
      Map<String, String>? headers}) async {
    try {
      bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Authorization': 'Bearer $bearerToken',
      };

      if (headers != null) {
        mainHeaders.addAll(headers);
      }

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} files');

      var request =
          http.MultipartRequest('PUT', Uri.parse(ApiConstant.baseUrl + uri));
      request.headers.addAll(mainHeaders);
      request.fields.addAll(body);

      for (MultipartBody element in multipartBody) {
        String mimeType = _getMimeType(element.file.path);

        request.files.add(await http.MultipartFile.fromPath(
          element.key,
          element.file.path,
          contentType:
              MediaType.parse(mimeType), // Set content type dynamically
        ));
      }

      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> deleteData(String uri,
      {Map<String, String>? headers, dynamic body}) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken'
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Call: $uri\n Body: $body');

      http.Response response = await http
          .delete(Uri.parse(ApiConstant.baseUrl + uri),
              headers: headers ?? mainHeaders, body: body)
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Response handleResponse(http.Response response, String uri) {
    dynamic body;

    try {
      body = jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      debugPrint("response ${response0.body.runtimeType}");
      ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);

      debugPrint("${errorResponse.statusCode}");
      response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: errorResponse.message);
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: noInternetMessage);
    }

    debugPrint(
        '====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    // log.e("Handle Response error} ");
    return response0;
  }
}

class MultipartBody {
  String key;
  File file;

  MultipartBody(this.key, this.file);
}

class ErrorResponse {
  final int statusCode;
  final String message;

  ErrorResponse({required this.statusCode, required this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? 'Unknown error',
    );
  }
}
