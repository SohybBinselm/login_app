import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CustomLoading extends StatelessWidget {
  final Color color;
  CustomLoading([this.color]);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 50.0,
          child: Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(
                    backgroundColor: color ?? null,
                  ),
          )),
    );
  }
}
