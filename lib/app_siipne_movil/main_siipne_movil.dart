import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/theme/app_theme.dart';
import 'dependency_injection.dart';
import 'presentation/routes/siipne_pages.dart';
import 'presentation/routes/siipne_routes.dart';

class MainSiipneMovil extends StatelessWidget {
  const MainSiipneMovil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: Locale('es'), // translations will be displayed in that locale
      fallbackLocale: Locale('es'),

      initialRoute:  SiipneRoutes.SPLASH,
     initialBinding: DependencyInjection(),
      getPages: SiipnePages.pages,

      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Hola'),
          ),
        ),
      ),
    );
  }
}
