part of '../controllers.dart';

class SplashController extends GetxController {
  final LocalStorageRepository _localStorageRepository =
      Get.find<LocalStorageRepository>();

  @override
  void onInit() {
    // TODO: el contolloler se ha creado pero la vista no se ha renderizado
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Donde la vista ya se presento
    _init();
  }

  _init() async {
    print(Get.deviceLocale.toString());
    _verifiToken();
  }

  _verifiToken() async {
    print("verificando token");
    Get.offAllNamed(SiipneRoutes.GPS_VERIFICATE);
    final token = await _localStorageRepository.getToken();
    Uint8List? foto = await _localStorageRepository.getFoto();

    if (foto != null && foto != '') {
      print('si hay foto');
      Get.offAllNamed(SiipneRoutes.LOGIN_RAPIDO);
    } else {
      print('no hay foto');
      if (token != null) {
        //Tenemos token aun valido que no expira
        Get.offAllNamed(SiipneRoutes.LOGIN);
      } else {
        Get.offAllNamed(SiipneRoutes.LOGIN);
      }
    }
  }

/* _verifiToken() async {

      final token = await _localStorageRepository.getToken();

      if (token != null) {
        final LoginController _loginController = Get.find<LoginController>();
        final userResponse = await _localStorageRepository.getUserResponse();
        if (userResponse != null) {
          _loginController.user.value = User(
              idGenUsuario: userResponse.idGenUsuario,
              idGenPersona: userResponse.idGenPersona,
              nombreUsuario: userResponse.nombreUsuario,
              apenom: userResponse.apenom,
              documento: userResponse.documento,
              sexoPerson: userResponse.sexoPerson,
              token: token,
              session: true,
              motivo: '',
              actualizarApp: false);

          Get.offAllNamed(SiipneRoutes.HOME);
        }
        else{
          Get.offAllNamed(SiipneRoutes.LOGIN);
        }


      } else {
        Get.offAllNamed(SiipneRoutes.LOGIN);
      }

  }*/
}
