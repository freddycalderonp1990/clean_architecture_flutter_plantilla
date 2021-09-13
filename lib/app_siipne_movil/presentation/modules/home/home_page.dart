part of '../pages.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  final LoginController _loginController = Get.find<LoginController>();
  final GpsController _gpsController = Get.find<GpsController>();



  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(

      imgPerfil: _loginController.user.value.foto,
      contenido: [
        AnimatedButton(
            text: "Text",
            pressEvent: () {
              Get.offNamed(SiipneRoutes.SPLASH);
            }),
        SizedBox(
          height: 10,
        ),
        Obx(()=>AnimatedButton(
            text:_gpsController.ubicacion.value.latitude!=0.0? "Latitud: ${_gpsController.ubicacion.value.latitude.toString()}, Longitud:${_gpsController.ubicacion.value.longitude.toString()}  ":'SIN COORDENADAS',
            pressEvent: () {
              DialogosAwesome.getConTextImput(
                  descripcion:
                  "Existe un error, contacte conm el administrador de sistema, Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ");
            })),
        SizedBox(
          height: 10,
        ),
        AnimatedButton(
            text: 'EROR',
            pressEvent: () {
              DialogosAwesome.getError(
                  descripcion:
                      "Existe un error, contacte conm el administrador de sistema, Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ");
            }),
        SizedBox(
          height: 10,
        ),
        AnimatedButton(
            text: 'ÉXITO',
            pressEvent: () {
              DialogosAwesome.getSucess(
                  descripcion:
                      "Existe un error, contacte conm el administrador de sistema, Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ");
            }),
        SizedBox(
          height: 10,
        ),
        AnimatedButton(
            text: 'Warning',
            pressEvent: () {
              DialogosAwesome.getWarningSiNo(
                  descripcion:
                      "Existe un error, contacte conm el administrador de sistema, Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ");
            }),
        SizedBox(
          height: 10,
        ),
        AnimatedButton(
            text: 'Informacion',
            pressEvent: () {
              DialogosAwesome.getInformation(
                  descripcion:
                      "Existe un error, contacte conm el administrador de sistema, Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ");
            }),
        SizedBox(
          height: 10,
        ),
        AnimatedButton(
            text: 'Personalizado',
            pressEvent: () {
              DialogosAwesome.getPersonalizado(
                  descripcion:
                      "Existe un error, contacte conm el administrador de sistema, Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ,Existe un error, contacte conm el administrador de sistema, ");
            }),
      ],
    );
  }
}
