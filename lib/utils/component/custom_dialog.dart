import 'dart:ui';

import 'package:flutter/material.dart';
Future<void> showCustomDialog(BuildContext context, Widget content,
    {ShapeBorder? shape,
    EdgeInsets? padding,
    Color? backgroundColorOfPopUp}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Dialog(
         shape: shape ?? RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10.0),
         ),
         child: content,
         insetPadding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
         backgroundColor: backgroundColorOfPopUp,
                ),
      );
    },
  );
}
