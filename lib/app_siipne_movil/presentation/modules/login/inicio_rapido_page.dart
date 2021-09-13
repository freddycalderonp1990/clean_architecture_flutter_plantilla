part of '../pages.dart';

class InicioRapidoPage extends GetView<LoginController> {
  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    // TODO: verifique
/*

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateTieneFoto(context);
    });*/
    print('buildd');

    Widget wg = Obx(() => WorkAreaPageWidget(
          mostrarVersion: true,
          imgPerfil: _loginController.user.value.foto,
          peticionServer: controller.peticionServerState.value ,
          sizeTittle: 7,
          contenido: <Widget>[getContenido(responsive)],
        ));

    wg = Stack(
      children: [
        wg,
        Container(
            child: Stack(
          children: [
            Positioned(
                left: responsive.isVertical()
                    ? responsive.altoP(1)
                    : responsive.anchoP(1),
                top: responsive.isVertical()
                    ? responsive.altoP(1)
                    : responsive.anchoP(2),
                child: SafeArea(
                  child: CupertinoButton(
                    minSize: responsive.isVertical()
                        ? responsive.altoP(5)
                        : responsive.anchoP(5),
                    padding: EdgeInsets.all(3),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black26,
                    onPressed: () {
                      // TODO: verifique
                      /*  prefsSelectApp.setSelectSiipne(false);
                      prefsSelectApp.setSelecMiUpc(false);
                      UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                          context: context, pantalla: AppConfig.pantallaBienvenida);*/
                    },
                    //volver atras
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: responsive.isVertical()
                          ? responsive.altoP(3)
                          : responsive.anchoP(3),
                    ),
                  ),
                ))
          ],
        ))
      ],
    );

    return GetBuilder<LoginController>(
      builder: (_c) => wg,
    );
  }

  Widget getContenido(ResponsiveUtil responsive) {
    return Column(
      children: [
        Text(
          controller.user.value.apenom,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: responsive.anchoP(5)),
        ),
        SizedBox(
          height: responsive.altoP(2),
        ),
        WgHuella(),
        SizedBox(
          height: responsive.altoP(1),
        ),
        wgOtroUsuario(responsive)
      ],
    );
  }

  Widget wgOtroUsuario(ResponsiveUtil responsive) {
    Widget wg = DesingBtn(
        title: "¿NO ERES TÚ?",
        img: SiipneImages.icon_usuario,
        onTap: () async {
          DialogosAwesome.getWarningSiNo(
              descripcion:
                  "Por su seguridad el acceso por huella sera desactivado."
                  "\n¿Desea Continuar?",
              btnOkOnPress: controller.ingresoConOtroUsuario);
        });

    return wg;
  }
}
