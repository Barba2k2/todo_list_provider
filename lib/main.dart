import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app_module.dart';

void main() {
  runApp(
    const AppModule(),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}
