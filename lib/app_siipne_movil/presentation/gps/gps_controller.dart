
part of 'gps_impl_helper.dart';

class GpsController extends GetxController {

  StreamSubscription<myGeolocator.Position>? positionSubscription;
  Rx<LatLng> ubicacion=new LatLng(0.0,0.0).obs;
  var obteniendoUbicacion = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //Verifica si tiene los Permisos y el GPS Activo
  Future<String> checkPermisosGpsActivated() async {
    // PermisoGPS verifica si el usuario ya dio permisos
    final permisoGPS = await Permission.location.isGranted;
    // GPS está activo verifica si el gps del dispositivo se encuentra activo
    final gpsActivo = await myGeolocator.Geolocator.isLocationServiceEnabled();

    if (permisoGPS && gpsActivo) {
      return "true";
    } else if (!permisoGPS) {
      String msj="Necesitamos acceder a la ubicación del Dispositivo.\n\n Por favor active los Permisos de la Ubicación";

      return msj;
    } else {
      return "Necesitamos acceder a la ubicación del Dispositivo.\n\n Por favor active el GPS de su dispositivo";
    }
  }

  Future checkGpsPermisoStatus( String pantalla) async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
      // GPS está activo verifica si el gps del dispositivo se encuentra activo
        final gpsActivo = await myGeolocator.Geolocator.isLocationServiceEnabled();
        print(status);
        print(gpsActivo);
        if(gpsActivo) {
          //aceptado
          Get.offAllNamed(pantalla);
        }

        break;

      case PermissionStatus.limited:
      //indeterminado

      case PermissionStatus.denied:
      //denegado

      case PermissionStatus.restricted:
      //restringida

      case PermissionStatus.permanentlyDenied:
        //permisos denegas por completo
        //Redirecciona al usuario para que de manuera manual asigne los permisos
        openAppSettings();
    }
  }

  void iniciarSeguimiento() async {

    if (this.positionSubscription == null) {
      obteniendoUbicacion(true);
      print("iniciarSeguimiento");
      final positionStream =myGeolocator.Geolocator.getPositionStream(
        //configuracion de la presion del GPS
        //entre mas preciso mas consumo de bateria
          desiredAccuracy: myGeolocator.LocationAccuracy.high,
          distanceFilter:
          10 //la distancia en metros que captura un nuevo valor el gps cuando el usuario se mueve
      );
      this.positionSubscription = positionStream.handleError((error) {
        print("tcambia ubicacion ${error}");
        this.positionSubscription!.cancel();
        this.positionSubscription = null;
        obteniendoUbicacion(false);
      }).listen((position) {

         ubicacion.value=  LatLng(position.latitude, position.longitude);
         print("cambia ubicacion ${ubicacion.value.latitude}, ${ubicacion.value.longitude}");
         ubicacion.refresh();
         obteniendoUbicacion(false);
      });

    }


  }
}
