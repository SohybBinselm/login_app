import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin AlertsMixin<T extends StatelessElement> {

  Future<void> showErrorDialog(BuildContext context, String errorMessage,
      [Duration duration = const Duration(milliseconds: 2000)]) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => Platform.isIOS
          ? CupertinoAlertDialog(
              content: Text(errorMessage),
              actions: <Widget>[
                CupertinoDialogAction(
                    child: Text('Ok'),
                    onPressed: () => Navigator.pop(context),
                    isDefaultAction: true)
              ],
            )
          : AlertDialog(
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Ok'),
                ),
              ],
            ),
    );
  }

  Future<dynamic> showConfirmDialog(BuildContext context, String title,
      String text, List<String> buttonLabels,
      ) async {
    final xx = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => Dialog(
              insetAnimationCurve: Curves.easeOut,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          text,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                buttonLabels[0],
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              width: 1.0,
                              color: Color(0x2625364F),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                buttonLabels[1],
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));

    return xx;
  }
}
