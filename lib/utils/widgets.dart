import 'package:flutter/material.dart';
import 'utils.dart';

Widget progressIndicator({required double height}) {
  return SizedBox(
    height: height,
    child: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(secondColor),
      ),
    ),
  );
}