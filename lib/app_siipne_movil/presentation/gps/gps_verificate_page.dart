//en esta pantalla se encarga de escuchar cualdo el usaurio activa el gps y
//redireccionarlo a al pantalla que necesite usar gps

// se encarga de verificar y redireccionar segun los permisos a la pantalla que le corresponde

part of 'gps_impl_helper.dart';

//Pantalla 1, es la primera en llamarse
//Se encarga de verificar si el usuario ya dio los permisos correspondientes al GPS
//y si la ubicacion esta activada

//Si esta activo se muestra la pantalla que necesita usar el GPS
//Caso contrario se redirecciona a la pantalla donde solicita los permisos o activar el GPS



class GpsVerificatePage extends GetView<GpsController>  with WidgetsBindingObserver  {
  final String? pantalla;
  final bool btnAtras;
  final imgFondo;
  final Route<Object?>? pantallaIrAtras;


  final bool cerrarTodasPantallas;

  GpsVerificatePage(
      {Key? key,
      this.pantalla,
      this.cerrarTodasPantallas = false,
      this.btnAtras = true,
      this.imgFondo = null,
      this.pantallaIrAtras})
      : super(key: key);

  //CONFIGURACIONES
  final anchoContenedor = SiipneConfig.anchoContenedor;


  RxString msj=''.obs;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    //super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    //super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if(pantalla!=null) {
      if (state == AppLifecycleState.resumed) {
        if (await myGeolocator.Geolocator.isLocationServiceEnabled()) {
          if (cerrarTodasPantallas) {
            Get.offAllNamed(pantalla!);
          } else {
            Get.toNamed(pantalla!);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return WorkAreaPageWidget(
      peticionServer: controller.obteniendoUbicacion.value,
      pantallaIrAtras: pantallaIrAtras,
      btnAtras: btnAtras,
      imgFondo: imgFondo,
      title: "SOLICITAR ACCESO AL GPS",
      contenido: [
        FutureBuilder(
          future: verificarGps(),
          //al cargar la pantalla se procede a verificar el acceso al gps
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //captura la data que retorna el metodo checkGpsYLocation
            print("snapshot.hasData= ${snapshot.hasData}");
            if (snapshot.hasData) {
              if (snapshot.data != "true") {
                msj.value= snapshot.data;

                return ContenedorDesingWidget(
                    margin: EdgeInsets.all(10),
                    anchoPorce: anchoContenedor,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                         Obx(()=> Text(
                           msj.value,
                           textAlign: TextAlign.center,
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: responsive.anchoP(5)),
                         )),
                          Image.asset(
                            SiipneImages.imgLocationAccess,
                            height: responsive.altoP(40),
                          ),
                          SizedBox(
                            height: responsive.altoP(4),
                          ),
                          BotonesWidget(
                            iconData: Icons.check,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            title: "CONTINUAR...",
                            onPressed: () async {
                              if(pantalla==null){
                                msj.value= "Pagina no implementada. \n\n Contacte con el administrador.";

                              }
                              else{

                                controller.checkGpsPermisoStatus(pantalla!);
                              }

                              DialogosAwesome.getError(descripcion:   msj.value);

                            },
                          )
                        ],
                      ),
                    ));
              } else {


                 controller.iniciarSeguimiento();

                return ContenedorDesingWidget(child: Text("GPS LISTO"));
              }
            } else {
              return Center(child: CircularProgressIndicator(strokeWidth: 2));
            }
          },
        )
      ],
    );
  }

  Future<String> verificarGps() async {
    String result = await controller.checkPermisosGpsActivated();
    print("result ${result}");
    if (result == "true") {
      if(pantalla==null){
        return "Pagina no implementada";
      }
      Get.offAllNamed(pantalla!);
      return result;
    } else {
      return result;
    }


  }
}
