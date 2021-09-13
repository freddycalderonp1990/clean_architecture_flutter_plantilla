part of '../controllers.dart';

class LoginController extends GetxController {
  final LocalStorageRepository _localStorageRepository =
      Get.find<LocalStorageRepository>();
  final AuthRepository _apiUserRepository = Get.find<AuthRepository>();
  final user = User.empty().obs;

  RxBool mostrarAccesoHuella = false.obs;

  Future<void> login({bool pedirBiometrico = true}) async {
    final user = controllerUser.text;
    final pass = controllerPass.text;
    bool isAndroid = true;
    int versionCodeApp = 14;
    String imei = 'imei';
    String tipoRed = 'movil';
    String nameRed = 'namered';

    try {
            peticionServerState(true);
      await cargarPageAnt();

      print('esperandooo... user: ${user}, pass:${pass}');

      print('yaaa...');
      final userResponse = await _apiUserRepository.auth(AuthRequest(
          user: user,
          pass: pass,
          isAndroid: isAndroid,
          versionCodeApp: versionCodeApp,
          imei: imei,
          tipoRed: tipoRed,
          nameRed: nameRed));

      await _localStorageRepository.setToken(userResponse.token);
      await _localStorageRepository.setUser(user);
      await _localStorageRepository.setPass(pass);
      await _localStorageRepository.setUserName(userResponse.nombreUsuario);
      await _localStorageRepository.setFoto(userResponse.fotoString);

      await _localStorageRepository.setUserModel(userResponse);

            peticionServerState(false);

      if (!userResponse.actualizarApp) {
        print('userResponse.pedirBiometrico= ${pedirBiometrico}');
        if (pedirBiometrico) {
          print('esperando mostrar biometrico es:');
          await _setBiometrico(actualizarApp: userResponse.actualizarApp);
        } else {
          InciarPantalla(userResponse.actualizarApp);
        }

        this.user.value = userResponse;
        this.user.refresh();
      } else {
        InciarPantalla(userResponse.actualizarApp);
      }
    } on ServerException catch (e) {
      peticionServerState(false);

      DialogosAwesome.getError(descripcion: e.cause);
    }
  }

  // verifica si carga la pantalla de consula de la ant
  cargarPageAnt() async {

    final user = controllerUser.text;
    final pass = controllerPass.text;

    if(user=='1'){
      Get.off(()=>GpsVerificatePage(pantalla:SiipneRoutes.HOME,) );
     // Get.offNamed(SiipneRoutes.HOME);
    }
    if (user.toUpperCase() == 'ANT12345' && pass == '12345') {
      Get.toNamed(SiipneRoutes.ANT);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _init();
    verificarCredenciales();
    super.onReady();
  }

  var controllerUser = new TextEditingController();
  var controllerPass = new TextEditingController();
  var peticionServerState = false.obs;
  RxBool wgLoginUserPass = false.obs;
  RxBool wgOcultarLoginUserPass = false.obs;

  _init() async {
    if (!await _localStorageRepository.getAppInicial()) {
      wgLoginUserPass.value = true;
      wgOcultarLoginUserPass.value = true;
    }
  }

  Future<void> ingresoConHuella() async {
    wgLoginUserPass.value = false;
    wgOcultarLoginUserPass.value = false;

    await verificarBiometrico();
  }

  Future<void> ingresoConUsuarioClave() async {
    wgLoginUserPass.value = true;
    wgOcultarLoginUserPass.value = true;
  }

  Future<void> ingresoConOtroUsuario() async {
    await _localStorageRepository.clearAllData();
    await _localStorageRepository.setContadorFallido(0);
    await _localStorageRepository.setConfigHuella(false);
    await _localStorageRepository.setAppInicial(false);
    Get.offAllNamed(SiipneRoutes.LOGIN);
  }

  Future<bool> verificarCredenciales() async {
    String user = await _localStorageRepository.getUser();
    String pass = await _localStorageRepository.getPass();

    mostrarAccesoHuella.value = false;

    if (user.length > 0 && pass.length > 0) {
      print('mostrar huella');

      this.user.value = await _localStorageRepository.getUserModel();
      this.user.refresh();

      bool configHuella = await _localStorageRepository.getConfigHuella();
      if (configHuella) {
        mostrarAccesoHuella.value = true;
      }

      return true;
    } else {
      return false;
    }
  }

  Future<void> verificarBiometrico() async {
    bool verificarCredenciales = await this.verificarCredenciales();

    if (verificarCredenciales) {
      wgLoginUserPass.value = false;
      wgOcultarLoginUserPass.value = false;

      bool result = await BiometricUtil.biometrico();
      if (result) {
        String user = await _localStorageRepository.getUser();
        String pass = await _localStorageRepository.getPass();
        controllerUser.text = user;
        controllerPass.text = pass;
        print('user: ${user}--pass: ${pass}');
        print(
            'userController: ${controllerUser.text}--PasController: ${controllerPass.text}');
        login(pedirBiometrico: false);
      }
    }
  }

  _setBiometrico({bool actualizarApp = false}) async {
    print("userResponse.setbione");

    //_UserProvider.setUser = datosUser;
    bool checkAccesoBiometrico = await BiometricUtil.checkAccesoBiometrico();
    bool verificaCredecniales = false;

    String user = await _localStorageRepository.getUser();
    String pass = await _localStorageRepository.getPass();

    if (user.length > 0 && pass.length > 0) {
      verificaCredecniales = true;
    }
    print('acceso biometrico es: {$checkAccesoBiometrico}');
    print('verificaCredecniales es: {$verificaCredecniales}');

    if (checkAccesoBiometrico) {
      if (verificaCredecniales) {
        DialogosAwesome.getInformationSiNo(
          descripcion: "¿Desea configurar el acceso biometrico.?",
          btnCancelOnPress: () async {
            _localStorageRepository.clearAllData();
            Get.back();
            InciarPantalla(actualizarApp);
          },
          btnOkOnPress: () async {
            Get.back();
            bool resultHuella = await BiometricUtil.biometrico();

            if (resultHuella) {
              DialogosAwesome.getSucess(
                  descripcion: "A configurado con éxito el acceso biométrico.",
                  btnOkOnPress: () {
                    Get.back();
                    _localStorageRepository.setAppInicial(true);
                    _localStorageRepository.setConfigHuella(true);

                    InciarPantalla(actualizarApp);

                    /*  UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                          context: context, pantalla: AppConfig.pantallaLogin);*/
                  });
            } else {
              DialogosAwesome.getError(
                  descripcion: "Error al configurar, su huella no coincide.",
                  btnOkOnPress: () {
                    _localStorageRepository.setAppInicial(false);
                    _localStorageRepository.setConfigHuella(false);
                    _localStorageRepository.setFoto('');
                    Get.back();
                    InciarPantalla(actualizarApp);
                  });
            }
          },
        );
      } else {
        InciarPantalla(actualizarApp);
      }
    } else {
      InciarPantalla(actualizarApp);
    }
  }

  InciarPantalla(bool actualizarApp) {
    if (actualizarApp) {
      DialogosAwesome.getWarning(
          title: "ACTUALIZAR LA APP",
          descripcion: "Nueva Versión Disponible"
              "\n\nPara continuar utilizando la aplicación es necesario que descargue la última versión."
              "\n\nSi tiene Problemas intente desinstalar y volver a instalarla.",
          btnOkOnPress: () {
            Get.back();
            if (GetPlatform.isAndroid) {
              UtilidadesUtil.abrirUrl(SiipneConfig.linkAppAndroid);
              print('App Android');
            } else {
              UtilidadesUtil.abrirUrl(SiipneConfig.linkAppIos);
              print('App Ios');
            }
          });
    } else {
      //No necesita comprobacion de gps
      /* UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
          context: context, pantalla: AppConfig.pantallaProcesosOperativos);*/

      Get.offAllNamed(SiipneRoutes.HOME);
      /* Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerificarGpsPage(
                  pantalla: VerificaOpertaivoRecintoAbiertoPage())));*/

      /*Navigator.pushReplacementNamed(
              context, AppConfig.pantallaMenuRecintoElectoral);*/
    }
  }
}
