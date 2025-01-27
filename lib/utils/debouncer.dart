import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int miliseconds;
  Timer? timer;

  Debouncer({required this.miliseconds, this.timer});

  void run(VoidCallback action) {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(Duration(milliseconds: miliseconds), action);
  }

  void reset() {
    timer = null;
  }
}
