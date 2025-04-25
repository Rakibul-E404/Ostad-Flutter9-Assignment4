import 'package:flutter/material.dart';
import 'package:ostad_flutter9_assignment4/models/user_model.dart';
import 'package:ostad_flutter9_assignment4/services/api_service.dart';

class AuthService with ChangeNotifier {

  final ApiService _apiService = ApiService();
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;
  bool get isAuthenticated => _token != null;



  // final ApiService _apiService = ApiService();
  // User? _user;
  // String? _token;
  //
  // User? get user => _user;
  // String? get token => _token;
  // bool get isAuthenticated => _token != null;

  Future<void> register(String email, String password, String firstName, String lastName) async {
    final response = await _apiService.post('Registration', {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    });

    _token = response['token'];
    _user = User.fromJson(response['data']);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final response = await _apiService.post('Login', {
      'email': email,
      'password': password,
    });

    _token = response['token'];
    _user = User.fromJson(response['data']);
    notifyListeners();
  }

  Future<void> updateProfile(String firstName, String lastName) async {
    final response = await _apiService.post('ProfileUpdate', {
      'firstName': firstName,
      'lastName': lastName,
    }, token: _token);

    _user = User.fromJson(response['data']);
    notifyListeners();
  }

  Future<void> verifyEmail(String email) async {
    await _apiService.get('RecoverVerifyEmail/$email');
  }

  Future<bool> verifyOtp(String email, String otp) async {
    final response = await _apiService.get('RecoverVerifyOtp/$email/$otp');
    return response['status'] == 'success';
  }

  Future<void> resetPassword(String email, String password) async {
    await _apiService.post('RecoverResetPassword', {
      'email': email,
      'password': password,
    });
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    notifyListeners();
  }
}