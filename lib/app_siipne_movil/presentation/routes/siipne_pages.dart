


import 'package:get/get.dart';

import '../modules/bindings.dart';
import '../modules/pages.dart';
import '../../presentation/gps/gps_impl_helper.dart';
import '../routes/siipne_routes.dart';

class SiipnePages {
  static final List<GetPage> pages = [
    GetPage(
        name: SiipneRoutes.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: SiipneRoutes.HOME,
        page: () => HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: SiipneRoutes.LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: SiipneRoutes.LOGIN_RAPIDO,
        page: () => InicioRapidoPage(),
        binding: IniciRapidoBinding()),
    GetPage(
        name: SiipneRoutes.ANT, page: () => AntPage(), binding: AntBinding()),

    GetPage(
        name: SiipneRoutes.GPS_VERIFICATE, page: () => GpsVerificatePage(), binding: GpsBinding()),
  ];
}
