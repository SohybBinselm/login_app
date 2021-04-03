import 'package:flutter/material.dart';
import 'package:login_task/src/mixins/alerts_mixin.dart';
import 'package:login_task/src/mixins/validation_mixin.dart';
import 'package:login_task/src/models/auth_exception.dart';
import 'package:login_task/src/providers/auth.dart';
import 'package:login_task/src/screens/home_screen.dart';
import 'package:login_task/src/screens/sign_up_screen.dart';
import 'package:login_task/src/widgets/custom_loading.dart';
import 'package:login_task/src/widgets/custom_form_widgets.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with AlertsMixin, ValidationMixin {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscure = true;

  Map<String, dynamic> _authData = {};

  Future<void> _signIn() async {
    if (_signInFormKey.currentState.validate()) {
      _signInFormKey.currentState.save();
      print('saved!');
      print(_authData);
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).signIn(_authData);
        print('signed in!');
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
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
    }
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('Sign In'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Form(
            key: _signInFormKey,
            child: Column(
              children: [
                MyCustomInput(
                  labelText: 'Email',
                  inputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: _focusNode1,
                  onSaved: (val) {
                    _authData['email'] = val;
                  },
                  validator: validateEmail,
                ),
                MyCustomInput(
                  labelText: 'Password',
                  textInputAction: TextInputAction.done,
                  focusNode: _focusNode2,
                  obscureText: _obscure,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      child: Icon(Icons.visibility)),
                  onSaved: (val) {
                    _authData['password'] = '$val';
                  },
                  onFieldSubmitted: (_) {
                    _signIn();
                  },
                  validator: validatePassword,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _isLoading
              ? CustomLoading()
              : MyCustomFormButton(
                  onPressedEvent: _signIn,
                  buttonText: 'Sign In',
                ),
          const SizedBox(height: 20),
          MyCustomFormButton(
            enableBorder: true,
            backgroundColor: Colors.white,
            onPressedEvent: () {
              Navigator.of(context).pushNamed(SignUpScreen.routeName);
            },
            buttonText: 'New User',
          ),
        ],
      ),
    );
  }
}
