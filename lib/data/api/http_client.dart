import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HttpClientInterface {
  HttpClientInterface({
    required String baseURL,
  }) : client = Dio()
    ..options =
    BaseOptions(baseUrl: baseURL, validateStatus: (_) => true);

  @protected
  final Dio client;

  @protected
  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, Object>? headers,
        bool cacheResponse = false,
      }) async {
    try {
      final response = await client.get<T>(
        path,
        queryParameters: queryParameters,
        options:
        Options(headers: headers, extra: {'cache_response': cacheResponse}),
      );
      return Response(response.data as T, response.statusCode!);
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @protected
  Future<Response<T>> post<T>(
      String path, {
        required Map<String, dynamic> body,
        Map<String, dynamic>? queryParameters,
        String? contentType,
        Map<String, Object>? headers,
      }) async {
    try {
      final response = await client.post<T>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(contentType: contentType, headers: headers),
      );

      return Response(response.data as T, response.statusCode!);
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

class Response<T> extends Equatable {
  const Response(this.json, this.statusCode);

  final T json;
  final int statusCode;

  @override
  List<Object?> get props => [json, statusCode];

  @override
  String toString() => 'statusCode: $statusCode, json: ${jsonEncode(json)}';
}
