import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_task/src/mixins/alerts_mixin.dart';
import 'package:login_task/src/providers/auth.dart';
import 'package:login_task/src/screens/sign_in_screen.dart';
import 'package:login_task/src/widgets/custom_form_widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AlertsMixin{
  Future<void> _signOut() async {
    await Provider.of<Auth>(context, listen: false).signOut();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Signed out successfully !'),
      duration: Duration(milliseconds: 1500),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<Auth>(
          builder: (_, auth, __) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: auth.user?.photo == null
                            ? AssetImage(
                                'assets/images/profile_placeholder.jpg')
                            : FileImage(
                                File(auth.user?.photo),
                              ))),
              ),
              const SizedBox(height: 20),
              Text(
                auth.isAuth
                    ? 'Welcome, ${auth.user?.firstName}'
                    : 'You are signed out !',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              MyCustomFormButton(
                width: 120,
                buttonText: auth.isAuth ? 'Sign out' : 'Sign in',
                onPressedEvent: auth.isAuth
                    ? () async{
                  final xx = (await showConfirmDialog(
                      context,
                      'Sign out',
                      'Do you want to sign out ?', [
                  'Cancel',
                  'Sign out'
                  ])) ??
                  false;
                  if (xx) _signOut();
                }
                    : () => Navigator.of(context)
                        .pushReplacementNamed(SignInScreen.routeName),
              )
            ],
          ),
        ),
      ),
    );
  }
}
