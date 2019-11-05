import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_gankio/app.dart';

class HttpUtils {
  Dio _dio;

  static HttpUtils _instance;

  static HttpUtils getInstance() {
    if (_instance == null) {
      _instance = HttpUtils();
    }
    return _instance;
  }

  HttpUtils() {
    _dio = new Dio();
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
    _dio.options.sendTimeout = 3000;
    _dio.interceptors
        .add(LogInterceptor(requestBody: Application.inProduction));
  }

  //get请求
  get(
      String url,
      Map<String, dynamic> params,
      Function(Map<String, dynamic>) successCallBack,
      Function(String) errorCallBack) async {
    _request(url, successCallBack, 'get', params, null, errorCallBack);
  }

  //get请求
  getSync(
      String url,
      Map<String, dynamic> params,) async {
    await _requestSync(url, 'get', params, null);
  }

  //post请求
  post(
      String url,
      FormData data,
      Function(Map<String, dynamic>) successCallBack,
      Function(String) errorCallBack) async {
    _request(url, successCallBack, "post", null, data, errorCallBack);
  }

  _request(String url, Function successCallBack,
      [String method,
        Map<String, dynamic> params,
        FormData data,
        Function errorCallBack]) async {
    Response response;
    try {
      if ("get" == method) {
        if (null != params && params.isNotEmpty) {
          response = await _dio.get(url, queryParameters: params);
        } else {
          response = await _dio.get(url);
        }
      } else if ("post" == method) {
        if (null != data && data.toString().isNotEmpty) {
          response = await _dio.post(url, data: data);
        } else {
          response = await _dio.post(url);
        }
      }
    } on DioError catch (error) {
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      // 请求超时
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = 1;
      }
      // 一般服务器错误
      else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = 2;
      }

      // debug模式才打印
      if (Application.inProduction) {
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + url);
        print('请求头: ' + _dio.options.headers.toString());
        print('method: ' + _dio.options.method);
      }
      _error(errorCallBack, error.message);
      return '';
    }

    // debug模式打印相关数据
    if (Application.inProduction) {
      print('请求url: ' + url);
      print('请求头: ' + _dio.options.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
    }
    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap == null || dataMap['state'] == 0) {
      _error(
          errorCallBack,
          '错误码：' +
              dataMap['errorCode'].toString() +
              '，' +
              response.data.toString());
    } else if (successCallBack != null) {
      successCallBack(dataMap);
    }
  }

  _error(Function errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }

  _requestSync(
      String url, [
        String method,
        Map<String, dynamic> params,
        FormData data,
      ]) async {
    Response response;
    try {
      if ("get" == method) {
        if (null != params && params.isNotEmpty) {
          response = await _dio.get(url, queryParameters: params);
        } else {
          response = await _dio.get(url);
        }
      } else if ("post" == method) {
        if (null != data && data.toString().isNotEmpty) {
          response = await _dio.post(url, data: data);
        } else {
          response = await _dio.post(url);
        }
      }
    } on DioError catch (error) {
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      // 请求超时
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = 1;
      }
      // 一般服务器错误
      else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = 2;
      }

      // debug模式才打印
      if (!Application.inProduction) {
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + url);
        print('请求头: ' + _dio.options.headers.toString());
        print('method: ' + _dio.options.method);
      }
      return error.message;
    }

    // debug模式打印相关数据
    if (!Application.inProduction) {
      print('请求url: ' + url);
      print('请求头: ' + _dio.options.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
    }
    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap == null || dataMap.isEmpty) {
      return response.data.toString();
    } else {
      return dataMap;
    }
  }
}
