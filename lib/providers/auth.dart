import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sm_shop_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return _token != null;
  }

   String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> authenticate(
      String email, String password, String prefix) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$prefix?key=AIzaSyBwwOuH7Br0iee3lx68F5oJItNCsrGjufY");
    
      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureKey": true,
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate =responseData['expiresIn'];
      print(json.decode(response.body));
    
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    return authenticate(email, password, "signInWithPassword");
  }

  Future<void> signup(String email, String password) async {
    return authenticate(email, password, "signUp");
  }
}
