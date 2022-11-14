
// ignore_for_file: prefer_const_constructors


import 'dart:io';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {


  String text;
  VoidCallback handler;

  AdaptiveFlatButton(this.text,this.handler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS? CupertinoButton(
                            // ignore: sort_child_properties_last
                            child: Text(
                                text,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ), 
                           onPressed: handler
                           ):
                           TextButton(
                              style: TextButton.styleFrom(
                                primary: Theme.of(context).primaryColor
                              ),
                              // ignore: sort_child_properties_last
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed:handler,
                            );
  }
}