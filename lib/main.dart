import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app.dart';

void main() {
  // Без этого push не меняет адрес в браузере.
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const App());
}
