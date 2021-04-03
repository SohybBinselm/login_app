
import 'package:flutter/material.dart';
import 'package:login_task/src/providers/auth.dart';
import 'package:login_task/src/screens/home_screen.dart';
import 'package:login_task/src/screens/sign_in_screen.dart';
import 'package:login_task/src/screens/sign_up_screen.dart';
import 'package:login_task/src/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Task',
        color: Colors.white,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            buttonColor: Color(0xFFDFC828),
            accentColor: Color(0xFFDFC828),
            primaryColor: Color(0xFFDFC828),
            appBarTheme: AppBarTheme(
              color: Colors.white,
              textTheme: TextTheme(
                headline6: TextStyle(
                    fontSize: 18,
                    color: Color(0xDE000000),
                    fontWeight: FontWeight.w500),
              ),
            )),
        home: SplashScreen(),
        routes: {
          SignInScreen.routeName : (_)=> SignInScreen(),
          SignUpScreen.routeName : (_)=> SignUpScreen(),
          HomeScreen.routeName : (_)=> HomeScreen(),
        },
      ),
    );
  }
}