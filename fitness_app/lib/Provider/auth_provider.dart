// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fitness_app/Provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_app/config.dart';

class AuthProvider extends ChangeNotifier {
  final UserProvider userProvider;
  AuthProvider(this.userProvider);

  static Future<String?> loginUser(String email, String password) async {
    try {
      var reqBody = {"email": email, "password": password};
      var response = await http.post(
        Uri.parse(login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['message'] == 'User logged in successfully') {
          print(jsonResponse['message']);
          return jsonResponse['token'];
        } else {
          print('Authentication failed: ${jsonResponse['message']}');
          return null;
        }
      } else {
        print('Server error: ${response.statusCode}');
        print('Server error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
