import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_task/src/models/auth_exception.dart';
import 'package:login_task/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  User _user;

  User get user => _user;
  bool get isAuth => (_user != null);

  Future<void> setLoggedUser(Map<String, dynamic> userData, [bool store = false]) async {
    print(userData.toString());
    _user = User.fromJsonMap(userData);
    notifyListeners();
    if(store) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('loggedUser', json.encode(userData));
    }

  }

  Future<void> signUp(Map<String, dynamic> userData) async {
    print(userData.toString());
    try {
      await checkUserSignUpEmail(userData);
      setLoggedUser(userData, true);
    } on AuthException catch (error) {
      throw error;
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(Map<String, dynamic> inputData) async {
    print(inputData.toString());
    try {
      final userData = await checkUserLoginCredentials(inputData);
      setLoggedUser(userData, true);
    } on AuthException catch (error) {
      throw error;
    } catch (error) {
      throw error;
    }
  }

  Future<void> checkUserSignUpEmail(Map<String, dynamic> inputData) async {
    final email = inputData['email'];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(email)) {
      throw AuthException('Email already exists !');
    } else {
      prefs.setString(email, json.encode(inputData));
    }
    //No exception thrown mean it's ok !
  }

  Future<Map<String, dynamic>> checkUserLoginCredentials(Map<String, dynamic> inputData) async {
    final email = inputData['email'];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> decodedUserData = {};

    if (!prefs.containsKey(email)) {
      throw AuthException('Email doesn\'t exist !');
    } else {
      final userData = prefs.getString(email);
      decodedUserData = json.decode(userData);
      final password = decodedUserData['password'];
      if (password != inputData['password']) {
        throw AuthException('Incorrect password !');
      }
    }
    return decodedUserData;
    //No exception thrown mean it's ok !
  }
  Future<bool> tryAutoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('loggedUser')) {
      return false;
    }
      final String storedUserData = prefs.getString('loggedUser');
      Map<String, dynamic> userData = json.decode(storedUserData);
      setLoggedUser(userData);
      return true;
    }
    Future<void> signOut() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('loggedUser');
      _user = null;
      notifyListeners();
    }

}
