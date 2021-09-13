part of '../bindings.dart';

class IniciRapidoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);

  }

}