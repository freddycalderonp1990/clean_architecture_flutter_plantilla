import 'package:flutter/material.dart';

import 'app_siipne_movil/dependency_injection.dart';
import 'app_siipne_movil/main_siipne_movil.dart';

void main() {
  DependencyInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MainSiipneMovil();
  }
}

