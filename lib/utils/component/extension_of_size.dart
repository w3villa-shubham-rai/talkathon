import 'package:flutter/material.dart';

extension Sized on int {
  SizedBox get bh => SizedBox(
    height: toDouble(),
  );
  SizedBox get bw => SizedBox(
    width: toDouble(),
  );
}
