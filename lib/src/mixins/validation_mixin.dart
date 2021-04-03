import 'package:flutter/material.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  RegExp _email = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
  RegExp _numeric =  RegExp(r'^-?[0-9]+$');

  String validateFirstName(String username) {
    if (username.length == 0) {
      return 'Please enter your first name';
    } else {
      return null;
    }
  }

  String validateLastName(String username) {
    if (username.length == 0) {
      return 'Please enter your last name';
    } else {
      return null;
    }
  }

  String validateEmail(String email) {
    if(!_email.hasMatch(email)) {
      return 'Please enter a valid email, E.G: test@test.com';
    } else return null;
  }

  String validatePassword(String password) {
    return password.length > 5
        ? null
        : 'Password must contain 6 letters at least';
  }

  String validatePhone(String phone) {
    if(phone.length == 0) {
      return 'Please enter phone number';
    }
    else if(!_numeric.hasMatch(phone) || phone.length < 7) {
       return 'Please enter a valid phone number';
    }
     else {
      return null;
    }
  }

  String validateAddress(String address) {
    if (address.length == 0) {
      return 'Please enter address';
    } else {
      return null;
    }
  }
  String validateDateOfBirth(String date) {
    if (date.length == 0) {
      return 'Please enter your date of birth';
    } else {
      return null;
    }}

}
