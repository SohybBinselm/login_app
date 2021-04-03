import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_task/src/mixins/alerts_mixin.dart';
import 'package:login_task/src/mixins/validation_mixin.dart';
import 'package:login_task/src/models/auth_exception.dart';
import 'package:login_task/src/providers/auth.dart';
import 'package:login_task/src/screens/home_screen.dart';
import 'package:login_task/src/widgets/custom_form_widgets.dart';
import 'package:login_task/src/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with ValidationMixin, AlertsMixin, TickerProviderStateMixin {
  Map<String, dynamic> _authData = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'password': '',
    'dateOfBirth': '',
    'gender': '',
    'phones': [],
    'addresses': [],
  };

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _obscure = true;
  bool _submitted = false;
  Gender _gender;
  Map<UniqueKey, Widget> _phoneInputWidgets = {};
  Map<UniqueKey, Widget> _addressInputWidgets = {};
  Map<UniqueKey, String> _phones = {};
  Map<UniqueKey, String> _addresses = {};
  String password = '';
  bool _isValidate = false;

  Future<void> _signUp() async {
    setState(() {
      _submitted = true;
      _isValidate = _signUpFormKey.currentState.validate() &&
          _gender != null &&
          _phoneInputWidgets.length != 0 &&
          _addressInputWidgets.length != 0;
    });
    if (_isValidate && _authData['photo'] != null) {
      _signUpFormKey.currentState.save();
      print('saved!');
      _authData['phones'] = _phones.values.toList();
      _authData['addresses'] = _addresses.values.toList();
      print(_authData);
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).signUp(_authData);
        print('signed up!');
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
      } on AuthException catch (error) {
        showErrorDialog(
            context, error.toString(), Duration(milliseconds: 1500));
      } catch (error) {
        throw error;
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      if (_isValidate && _authData['photo'] == null) {
        _scrollController.animateTo(_scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    }
  }

  final picker = ImagePicker();

  Future<File> _getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    return File(pickedFile.path);
  }

  Future<File> _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }

  _openPickingOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () async {
                Navigator.pop(context);
                File myFile = await _getImageFromCamera();
                _authData['photo'] = myFile.path;
                setState(() {});
              },
              icon: Icon(
                Icons.camera_alt,
                color: Theme.of(context).buttonColor,
              ),
              iconSize: 28.0,
              tooltip: 'Camera',
            ),
            IconButton(
              onPressed: () async {
                Navigator.pop(context);
                File myFile = await _getImageFromGallery();
                _authData['photo'] = myFile.path;
                setState(() {});
              },
              icon: Icon(
                Icons.photo_library,
                color: Theme.of(context).buttonColor,
              ),
              iconSize: 28.0,
              tooltip: 'Gallery',
            )
          ],
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(26.0), topLeft: Radius.circular(26.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              GestureDetector(
                onTap: _openPickingOptions,
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: _authData['photo'] == null
                                  ? AssetImage(
                                      'assets/images/profile_placeholder.jpg')
                                  : FileImage(
                                      File(_authData['photo']),
                                    ))),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Choose a profile picture',
                      style: TextStyle(
                          color: _authData['photo'] == null && _submitted
                              ? Colors.red[500]
                              : Color(0xFF393939),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          decoration: _authData['photo'] == null && _submitted
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          letterSpacing: 0.37),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              MyCustomInput(
                labelText: 'First Name',
                textInputAction: TextInputAction.next,
                validator: validateFirstName,
                onSaved: (val) {
                  _authData['firstName'] = val;
                },
              ),
              const SizedBox(height: 1),
              MyCustomInput(
                labelText: 'Last Name',
                textInputAction: TextInputAction.next,
                validator: validateLastName,
                onSaved: (val) {
                  _authData['lastName'] = val;
                },
              ),
              const SizedBox(height: 1),
              MyCustomInput(
                labelText: 'Email',
                textInputAction: TextInputAction.next,
                validator: validateEmail,
                onSaved: (val) {
                  _authData['email'] = val;
                },
              ),
              const SizedBox(height: 1),
              MyCustomInput(
                labelText: 'Password',
                obscureText: _obscure,
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    child: Icon(Icons.visibility)),
                textInputAction: TextInputAction.next,
                validator: validatePassword,
                onSaved: (val) {
                  _authData['password'] = val;
                },
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              const SizedBox(height: 1),
              MyCustomInput(
                labelText: 'Confirm Password',
                obscureText: _obscure,
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    child: Icon(Icons.visibility)),
                textInputAction: TextInputAction.next,
                validator: (val) {
                  return val != password && password.length > 5
                      ? val == ''
                          ? 'Please confirm your password'
                          : 'Those passwords didnt match, try again'
                      : null;
                },
              ),
              const SizedBox(height: 1),
              MyCustomInput(
                labelText: 'Date of birth',
                textInputAction: TextInputAction.done,
                validator: validateDateOfBirth,
                onSaved: (val) {
                  _authData['dateOfBirth'] = val;
                },
              ),
              const SizedBox(height: 1),
              AnimatedSize(
                duration: Duration(milliseconds: 500),
                vsync: this,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _phoneInputWidgets.length + 1,
                    itemBuilder: (_, i) {
                      return i == _phoneInputWidgets.length
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: InkWell(
                                onTap: () {
                                  final uniqueKey = UniqueKey();
                                  final textEditingController =
                                      TextEditingController();
                                  setState(() {
                                    _phoneInputWidgets[uniqueKey] = Row(
                                      key: uniqueKey,
                                      children: [
                                        const SizedBox(width: 16),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _phoneInputWidgets
                                                    .remove(uniqueKey);
                                                _phones.remove(uniqueKey);
                                              });
                                            },
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            )),
                                        Expanded(
                                          child: MyCustomInput(
                                            containerMargin:
                                                EdgeInsets.only(right: 16),
                                            textEditingController:
                                                textEditingController,
                                            hintText: 'Phone',
                                            inputType: TextInputType.phone,
                                            validator: validatePhone,
                                            onChanged: (val) {
                                              if (validatePhone(val) == null)
                                                _phones[uniqueKey] = val;
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.greenAccent,
                                        ),
                                        const SizedBox(width: 10),
                                        Text('Add phone'),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(
                                      indent: 23,
                                      height: 0,
                                      color: Colors.grey.withOpacity(0.6),
                                      thickness: 1.4,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : _phoneInputWidgets[
                              _phoneInputWidgets.keys.toList()[i]];
                    }),
              ),
              if (_phoneInputWidgets.length == 0 && _submitted)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28, top: 10),
                    child: Text(
                      'Enter 1 phone number at least',
                      style: TextStyle(color: Colors.red[500], fontSize: 12),
                    ),
                  ),
                ),
              const SizedBox(height: 1),
              AnimatedSize(
                duration: Duration(milliseconds: 500),
                vsync: this,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _addressInputWidgets.length + 1,
                    itemBuilder: (_, i) {
                      return i == _addressInputWidgets.length
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: InkWell(
                                onTap: () {
                                  final uniqueKey = UniqueKey();
                                  final textEditingController =
                                      TextEditingController();
                                  setState(() {
                                    _addressInputWidgets[uniqueKey] = Row(
                                      key: uniqueKey,
                                      children: [
                                        const SizedBox(width: 16),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _addressInputWidgets
                                                    .remove(uniqueKey);
                                                _addresses.remove(uniqueKey);
                                              });
                                            },
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            )),
                                        Expanded(
                                          child: MyCustomInput(
                                            containerMargin:
                                                EdgeInsets.only(right: 16),
                                            textEditingController:
                                                textEditingController,
                                            hintText: 'Address',
                                            inputType: TextInputType.phone,
                                            validator: validateAddress,
                                            onChanged: (val) {
                                              if (validateAddress(val) == null)
                                                _addresses[uniqueKey] = val;
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.greenAccent,
                                        ),
                                        const SizedBox(width: 10),
                                        Text('Add address'),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(
                                      indent: 23,
                                      height: 0,
                                      color: Colors.grey.withOpacity(0.6),
                                      thickness: 1.4,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : _addressInputWidgets[
                              _addressInputWidgets.keys.toList()[i]];
                    }),
              ),
              if (_addressInputWidgets.length == 0 && _submitted)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28, top: 10),
                    child: Text(
                      'Enter 1 address at least',
                      style: TextStyle(color: Colors.red[500], fontSize: 12),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Gender',
                  style: TextStyle(
                      color: Color(0xFF99000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 36,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 70),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                    )),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _gender = Gender.male;
                            _authData['gender'] = 'male';
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: _gender == Gender.male
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                topLeft: Radius.circular(50),
                              ),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1,
                              )),
                          child: Text(
                            'Male',
                            style: TextStyle(
                                color: Color(0xFFC2000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _gender = Gender.female;
                            _authData['gender'] = 'female';
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: _gender == Gender.female
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                                bottomLeft: Radius.circular(0),
                                topLeft: Radius.circular(0),
                              ),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1,
                              )),
                          child: Text(
                            'Female',
                            style: TextStyle(
                                color: Color(0xFFC2000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_gender == null && _submitted)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Please choose your gender',
                    style: TextStyle(color: Colors.red[500], fontSize: 12),
                  ),
                ),
              const SizedBox(height: 30),
              _isLoading
                  ? CustomLoading()
                  : MyCustomFormButton(
                      onPressedEvent: _signUp,
                      buttonText: 'Sign Up',
                    ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
