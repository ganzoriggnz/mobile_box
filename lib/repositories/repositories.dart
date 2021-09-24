import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as dioReq;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobilbox/model/product_response.dart';

final String homeUrl = 'http://mobilebox.mn:8080/api/user/';

class UserRepository {
  final String loginUrl = homeUrl + 'login';
  final String registerPhoneApi = homeUrl + 'registration';
  final String resetPasswordAPI = '';
  final String getProductsGears = homeUrl + 'productListMini';
  final String getAllProducts = homeUrl + 'productList';
  final String getProductLeasing =
      'https://api.zochil.shop/v1/products/by-shop/81?category_id=1719';

  final dioReq.Dio _dio = dioReq.Dio();
  final storage = new FlutterSecureStorage();
  String value;

  Future<ProductResponse> getGearProducts() async {
    dioReq.Dio dio = dioReq.Dio();
    var token = await storage.read(key: 'token');
    try {
      dioReq.Response response = await dio.get(getProductsGears,
          options: dioReq.Options(headers: {
            "Authorization": "$token",
            "content-type": "application/json"
          }));
      if (response.data['success'] == true) {
        return ProductResponse.fromJson(response.data);
      } else {
        return ProductResponse.withError("Алдаа гарлаа.");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }

  Future<ProductResponse> getProducts() async {
    dioReq.Dio dio = dioReq.Dio();
    var token = await storage.read(key: 'token');
    try {
      dioReq.Response response = await dio.get(getAllProducts,
          options: dioReq.Options(headers: {
            "Authorization": "$token",
            "content-type": "application/json"
          }));
      print('All Products fetched ${response.data}');
      if (response.data['success'] == true) {
        return ProductResponse.fromJson(response.data);
      } else {
        return ProductResponse.withError("Алдаа гарлаа.");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }

  Future<ProductResponse> getLeasingProducts() async {
    try {
      dioReq.Response response = await _dio.get(getProductLeasing);
      print(response.data);
      var responseJson = jsonDecode(response.data);
      return ProductResponse.fromJson(responseJson['data']);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductResponse.withError("$error");
    }
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<void> setFirstHomeScreen() async {
    await storage.write(key: 'firstHomeScreen', value: "isLoaded");
  }

  Future<String> getFirstHomeScreen() async {
    var value = await storage.read(key: 'firstHomeScreen');
    return value;
  }

  Future<void> setFirstProductScreen() async {
    await storage.write(key: 'firstProductScreen', value: "isLoaded");
  }

  Future<String> getFirstProductScreen() async {
    var value = await storage.read(key: 'firstProductScreen');
    return value;
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> qpayToken(String token, String refresh) async {
    await storage.write(key: 'qtoken', value: token);
    await storage.write(key: 'qRefreshToken', value: refresh);
  }

  Future<String> getQpayToken() async {
    return await storage.read(key: 'qtoken');
  }

  Future<bool> hasToken() async {
    value = await storage.read(key: 'token');
    print(value);
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() async {
    var value = await storage.read(key: 'token');
    return value;
  }

  Future<String> login(String email, String password) async {
    dioReq.Response response = await _dio.post(loginUrl, data: {
      "email": email,
      "password": password,
    });
    print('login info ${response.data}');
    if (response.data['success'] == false) {
      return null;
    } else {
      return response.data['token'];
    }
  }

  Future<http.Response> resetPasswordPhone({
    String phone,
  }) async {
    Map data = {
      'phone': phone,
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse(resetPasswordAPI),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);
    print("${response.statusCode}");
    print("THIS IS BODY ${response.body}");
    return response;
  }

  Future<http.Response> registerPhone(
      {String firstName,
      String lastName,
      String phone,
      String email,
      String password}) async {
    Map data = {
      'firstname': firstName,
      'lastname': lastName,
      'telnumber': phone,
      'email': email,
      'password': password
    };
    print(data);
    var body = json.encode(data);
    var response = await http.post(Uri.parse(registerPhoneApi),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);
    print("${response.statusCode}");
    print("THIS IS BODY ${response.body}");
    return response;
  }
}
