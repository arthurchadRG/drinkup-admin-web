import 'dart:convert';

import 'package:admin/models/login/login_model.dart';
import 'package:admin/models/signup/signup_model.dart';
import 'package:dio/dio.dart';

import '../constants.dart';

class HttpService {
  HttpService();

  final Dio _httpclient = Dio();

  Future<LoginModel> login(String identifer, String secret) async {
    try {
      final response = await _httpclient.post(
        '$baseUrl/retailer-sessions',
        data: jsonEncode(<String, String>{
          "identifier": identifer,
          "secret": secret,
        }),
      );

      print(response.data);

      if (response.statusCode == 201) {
        return LoginModel.fromJson(response.data);
      } else {
        print(response.data);
        throw Exception('Failed to grab categories');
      }
    } on Exception catch (e) {
      throw Exception('Failed to cats $e');
    }
  }

  Future<SignupModel> signup(
      String identifier, String secret, String business_name) async {
    try {
      final response = await _httpclient.post(
        '$baseUrl/retailers',
        data: jsonEncode(<String, String>{
          "identifier": identifier,
          "secret": secret,
          "business_name": business_name,
          "notes": "",
          "status": "active"
        }),
      );

      print(response.data);

      if (response.statusCode == 200) {
        return SignupModel.fromJson(response.data);
      } else {
        print(response.data);
        throw Exception('Failed to signup retailer');
      }
    } on Exception catch (e) {
      throw Exception('Failed to signup retailer with error $e');
    }
  }
}
