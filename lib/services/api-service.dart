import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tikweb_test_app/config/api-urls.dart';

class ApiService {
  static String bearerToken;
  static initClass({String token}) {
    bearerToken = token;
  }

  getRequest({String endPoint}) async {
    print(ApiUrl.baseUrl + endPoint);
    HttpClient client = HttpClient();
    try {
      return await http.get(Uri.parse(ApiUrl.baseUrl + endPoint), headers: getHttpHeaders());
    } catch (error) {
      print('GET::::::::::::::::ERROR');
      print(ApiUrl.baseUrl + endPoint);
      print(error);
      return null;
    } finally {
      client.close();
    }
  }

  getRequestWithAuth({String endPoint}) async {
    print(ApiUrl.baseUrl + endPoint);
    HttpClient client = HttpClient();
    try {
      return await http.get(Uri.parse(ApiUrl.baseUrl + endPoint), headers: getAuthHeaders());
    } catch (error) {
      print('GET AUTH::::::::::::::::ERROR');
      print(ApiUrl.baseUrl + endPoint);
      print(error);
      return null;
    } finally {
      client.close();
    }
  }

  simplePostRequest({String endPoint}) async {
    print(ApiUrl.baseUrl + endPoint);
    HttpClient client = HttpClient();
    try {
      return await http.post(Uri.parse(ApiUrl.baseUrl + endPoint), headers: getHttpHeaders());
    } catch (error) {
      print('POST::::::::::::::::ERROR');
      print(ApiUrl.baseUrl + endPoint);
      print(error);
      return null;
    } finally {
      client.close();
    }
  }

  simpleAuthPostRequest({String endPoint}) async {
    print(ApiUrl.baseUrl + endPoint);
    HttpClient client = HttpClient();
    try {
      return await http.post(Uri.parse(ApiUrl.baseUrl + endPoint), headers: getAuthHeaders());
    } catch (error) {
      print('POST::::::::::::::::ERROR');
      print(ApiUrl.baseUrl + endPoint);
      print(error);
      return null;
    } finally {
      client.close();
    }
  }

  postRequest({String endPoint, String body}) async {
    print(ApiUrl.baseUrl + endPoint);
    print(body);
    HttpClient client = HttpClient();
    try {
      return await http.post(Uri.parse(ApiUrl.baseUrl + endPoint), headers: getHttpHeaders(), body: body);
    } catch (error) {
      print('POST::::::::::::::::ERROR');
      print(ApiUrl.baseUrl + endPoint);
      print(error);
      return null;
    } finally {
      client.close();
    }
  }

  postRequestWithAuth({String endPoint, String body}) async {
    print(ApiUrl.baseUrl + endPoint);
    print(body);
    HttpClient client = HttpClient();
    try {
      return await http.post(Uri.parse(ApiUrl.baseUrl + endPoint), headers: getAuthHeaders(), body: body);
    } catch (error) {
      print('POST AUTH::::::::::::::::ERROR');
      print(ApiUrl.baseUrl + endPoint);
      print(error);
      return null;
    } finally {
      client.close();
    }
  }

  deleteRequest({String endPoint}) async {
    print(ApiUrl.baseUrl + endPoint);
    HttpClient client = HttpClient();
    try {
      return await http.delete(Uri.parse(ApiUrl.baseUrl + endPoint), headers: getAuthHeaders());
    } catch (error) {
      print('DELETE::::::::::::::::ERROR');
      print(ApiUrl.baseUrl + endPoint);
      print(error);
      return null;
    } finally {
      client.close();
    }
  }

  static Map<String, String> getHttpHeaders() {
    Map<String, String> headers = new Map();
    headers['Content-Type'] = 'application/json';
    return headers;
  }

  static Map<String, String> getAuthHeaders() {
    Map<String, String> headers = new Map<String, String>();
    headers['Authorization'] = bearerToken;
    headers['Content-Type'] = 'application/json';
    return headers;
  }
}
