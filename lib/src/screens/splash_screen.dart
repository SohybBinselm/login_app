//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:login_task/src/screens/sign_in_screen.dart';
//
//
//class SplashScreen extends StatefulWidget {
//  @override
//  _SplashScreenState createState() => _SplashScreenState();
//}
//
//class _SplashScreenState extends State<SplashScreen> {
//  double _opacityVal = 0.0;
//
//  Future<void> hideScreen() async {
////    bool landed = false;
////    String lang = 'ar';
////    final SharedPreferences prefs = await SharedPreferences.getInstance();
////    if (prefs.containsKey('landed')) {
////      landed = prefs.getBool('landed');
////    }
////    if (prefs.containsKey('lang')) {
////      lang = prefs.getString('lang');
////      await Provider.of<AppLanguage>(context, listen: false)
////          .changeLanguage(lang);
////    }
////    final xx = Provider.of<Auth>(context, listen: false);
////    bool _isLoggedIn = false;
////    if(!xx.isAuth) _isLoggedIn = await xx.tryAutoLogin();
//    Future.delayed(Duration(milliseconds: 4000), () {
//      if (this.mounted)
//        Navigator.pushReplacement(
//          context,
//          PageRouteBuilder(
//            opaque: true,
//            settings: RouteSettings(name: SignInScreen.routeName ),
//            transitionDuration: const Duration(milliseconds: 2000),
//            pageBuilder: (BuildContext context, _, __) =>  SignInScreen() ,
//            transitionsBuilder:
//                (_, Animation<double> animation, __, Widget child) =>
//                FadeTransition(
//                  opacity: animation,
//                  child: child,
//                ),
//          ),
//        );
//    });
//  }
//
//  @override
//  void didChangeDependencies() {
//    Future.delayed(Duration(milliseconds: 300), () {
//      if (this.mounted)
//        setState(() {
//          _opacityVal = 1.0;
//        });
//    });
//    hideScreen();
//    super.didChangeDependencies();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: AnimatedOpacity(
//        duration: Duration(milliseconds: 1000),
//        opacity: _opacityVal,
//        curve: Curves.easeInOut,
//        child: Container(
//          alignment: Alignment.center,
//          decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage('assets/images/splash.png'),
//                alignment: Alignment.center,
//                fit: BoxFit.cover,
//              )),
//        ),
//      ),
//    );
//  }
//}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_task/src/providers/auth.dart';
import 'package:login_task/src/screens/home_screen.dart';
import 'package:login_task/src/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  static const routeName = '/splashscreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Size deviceSize;

  double _opacityVal = 0.0;

  double _bottomVal = -50.0;

  double _bottomValWord = -50.0;

  Future<void> hideScreen() async {
    final authReference = Provider.of<Auth>(context, listen: false);
    bool isLoggedIn = false;
    isLoggedIn = await authReference.tryAutoLogin();
    Future.delayed(Duration(milliseconds: 3000), () {
      if (this.mounted)
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            opaque: true,
            settings: RouteSettings(
                name: isLoggedIn ? HomeScreen.routeName : SignInScreen.routeName),
            transitionDuration: const Duration(milliseconds: 1500),
            pageBuilder: (BuildContext context, _, __) =>
            isLoggedIn ? HomeScreen() : SignInScreen(),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ),
          ),
        );
      ;
    });
  }

  @override
  void dispose() {
//    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    deviceSize = MediaQuery.of(context).size;
    Future.delayed(Duration(milliseconds: 300), () {
      if (this.mounted)
        setState(() {
          _opacityVal = 1.0;
          _bottomVal = 0.0;
          _bottomValWord = 140.0;
        });
    });
//    _translateVal = deviceSize.width / 1.5;
//    Provider.of<GlobalData>(context, listen: false).getCountriesAndCategories();
//    Provider.of<GlobalData>(context, listen: false).getCountriesAndCategories();
    // TODO: implement didChangeDependencies

    hideScreen();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _animationController = AnimationController(
//      vsync: this,
//      duration: Duration(milliseconds: 1200),
//    );
//
//    _opacityAnimation = Tween(
//      begin: 0.2,
//      end: 1.0,
//    ).animate(
//        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
//    _opacityAnimation.addListener(() => setState(() {}));
//
//    Future.delayed(Duration(milliseconds: 20), () {
//      setState(() {
//        _translateVal = -20.0;
//      });
//      Future.delayed(Duration(milliseconds: 400), () {
//        setState(() {
//      _translateVal = 0.0;
//        });
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedOpacity(
            duration: Duration(milliseconds: 2000),
            opacity: _opacityVal,
            curve: Curves.easeInOut,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/images/splash.png'),
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            bottom: _bottomVal,
            child: Container(
              width: 61.0,
              height: 120,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Color(0xFFFFC25B).withOpacity(0.5),
                          width: 7.0),
                      left: BorderSide(
                          color: Color(0xFFFFC25B).withOpacity(0.5),
                          width: 7.0),
                      right: BorderSide(
                          color: Color(0xFFFFC25B).withOpacity(0.5),
                          width: 7.0))),
            ),
          ),
          Positioned(
            bottom: 50.0,
            child: CupertinoActivityIndicator(),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            bottom: _bottomValWord,
            child: Text(
              'WELCOME',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

