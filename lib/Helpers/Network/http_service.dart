import 'dart:convert';

import 'package:admin/models/dashboard/locations_model.dart';
import 'package:admin/models/dashboard/orders_model.dart';
import 'package:admin/models/dashboard/retailer_model.dart';
import 'package:admin/models/login/login_model.dart';
import 'package:admin/models/order_details_model.dart';
import 'package:admin/models/show_order/redeem_model.dart';
import 'package:admin/models/show_order/sku_order.dart';
import 'package:admin/models/signup/signup_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<LocationsModel> getLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? barback = prefs.getString('barback');
      _httpclient.options.headers["x-barback-token"] = barback;
      final response = await _httpclient.get(
        '$baseUrl/locations',
      );

      print(response.data);

      if (response.statusCode == 200) {
        return LocationsModel.fromJson(response.data);
      } else {
        print(response.data);
        throw Exception('Failed to create location');
      }
    } on Exception catch (e) {
      throw Exception('Failed to add location $e');
    }
  }

  Future<RetailerModel> createLocation(
      String name,
      String street,
      String city,
      String region,
      String postal,
      String country,
      String lat,
      String long) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? barback = prefs.getString('barback');
      _httpclient.options.headers["x-barback-token"] = barback;
      final response = await _httpclient.post(
        '$baseUrl/locations',
        data: jsonEncode(<String, String>{
          "name": name,
          "street": street,
          "city": city,
          "region": region,
          "postal_code": postal,
          "country_code": country,
          "latitude": lat,
          "longitude": long,
        }),
      );

      print(response.data);

      if (response.statusCode == 200) {
        return RetailerModel.fromJson(response.data);
      } else {
        print(response.data);
        throw Exception('Failed to create location');
      }
    } on Exception catch (e) {
      throw Exception('Failed to add location $e');
    }
  }

  Future<RedeemModel> redeemItem(
      List<SkuOrder> orders, String order_id, String location_id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? barback = prefs.getString('barback');
      _httpclient.options.headers["x-barback-token"] = barback;
      final response = await _httpclient.post(
        '$baseUrl/redemptions',
        data: jsonEncode({
          "order_id": order_id,
          "location_id": location_id,
          "skus": orders,
        }),
      );

      print(response.data);

      if (response.statusCode == 200) {
        return RedeemModel.fromJson(response.data);
      } else {
        print(response.data);
        throw Exception('Failed to create location');
      }
    } on Exception catch (e) {
      throw Exception('Failed to add location $e');
    }
  }

  Future<OrderDetailsModel> getOrder(String id) async {
    final response = await _httpclient.get(
      '$baseUrl/orders/$id',
    );

    if (response.statusCode == 200) {
      print(response.data);
      return OrderDetailsModel.fromJson(response.data);
    } else {
      print(response.data);
      throw Exception('Failed to grab drink categories');
    }
  }

  Future<OrdersModel> grabOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? barback = prefs.getString('barback');
      _httpclient.options.headers["x-barback-token"] = barback;
      final response = await _httpclient.get(
        '$baseUrl/orders',
      );

      print(response.data);

      if (response.statusCode == 200) {
        return OrdersModel.fromJson(response.data);
      } else {
        print(response.data);
        throw Exception('Failed to grab orders');
      }
    } on Exception catch (e) {
      throw Exception('Failed to get orders $e');
    }
  }

  Future<SignupModel> signup(
      String identifier, String secret, String business_name) async {
    try {
      print('$baseUrl/retailers');
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
