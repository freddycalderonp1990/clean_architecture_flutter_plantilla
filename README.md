    # clean_architecture_flutter

 Flutter Clean Architecture.

##TOKEN
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

## Guia Implementacion de Arquitecturas:
Guia Implementacion de Arquitecturas:
Arquitectura con getx: https://github.com/kauemurakami/getx_pattern
CleanArchitecture: https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html
Curso Youtube: Clean Architecture y Getx: https://www.youtube.com/watch?v=Qffojk-vjKY&t=3522s
Curso Youtube: Arquitectura para Getx: https://www.youtube.com/watch?v=11XcWw1cthg

## Guia Implementacion de Arquitecturas:
Se divide en capas
Se maneja la inyeccion de dependencias

Estructura: se crea la carpeta app dentro van las demas capas
*core -> capa relacionada con configuracion, funcionalidades del dispositivo movil
    *exceptions
    *theme
    *utils
    *values
    *app_config.dart
*data -> capa relacionada con la conexion externa (apis, firebase) y a almacenar datos de manera local 
*domain -> se definen las clases bastractas (contratos), nos permite establecer comunicacion entre data -> domain <- presentation
*presentation -> la parte grafica UI (paguinas widgets) del aplicativo
*dependency_injection.dart -> archivo encargado de realizar la inyeccion de dependencias


------------------------------------------------PASOS IMPLEMENTAR CLEAN ARCHITECTURE----------------------------------------------------------------------------------
PASO 1:
capa domain:
    -en la carpeta repositories
        se crean las clases abstract :  
            //Se define que cosas quiero hacer (los contratos)
            //Ejemplo para el login:
                abstract class AuthRepository {                            
                    Future<User> auth(AuthRequest authRequest);
                    Future<void> logout (String token);
                }
PASO 2:
capa data
    - en la carpeta models
        se crean las clases que sirven de modelo de los datos que envia el servidor, es decir parsean los datos a un modelo a utilizar
        Utilizar el siguiente link para crear los modelos: https://app.quicktype.io/ se deb seleccionar el lenguaje dart

PASO 3:
capa data
    - en la carpeta providers
        se crean las clases que establecen conecion con los proveedores (apis, firebase, datos locales del cell)
        las clases debe extender de una clase ubicada en domain/repositories como ejemplo la clase que creamos en el PASO 1.
------------------------------------------------AuthApiProviderImpl----------------------------------------------------------------------------------
        class AuthApiProviderImpl extends AuthRepository {
            @override
            Future<User> auth(AuthRequest authRequest) async {
                try {
                  http.Client client = http.Client();  
                  final String url = 'http://192.168.80.90/auth';
                  final uri = Uri.parse(url);
                  final response = await client.post(uri, body: {
                    "user": authRequest.user,
                    "pass": "b9325d3c93713bef80a22ef6aeef8ccdd45f3f18",
                    "isAndroid": authRequest.isAndroid.toString(),
                    "versionCodeApp": authRequest.versionCodeApp.toString(),
                    "imei": authRequest.imei,
                    "tipoRed": authRequest.tipoRed,
                    "nameRed": authRequest.nameRed
                  }).timeout(Duration(seconds: 8));
                  print('response.statusCode');
                  log(response.statusCode.toString());
                  if (response.statusCode == 200) {
                    log(response.body);
                    return userModelFromJson(response.body).user;
                  } else if (response.statusCode == 401) {
                    throw ServerException(cause: "El Usuario o la clave es incorrecta");
                  } else {
                    throw ServerException.StatusCode(statusCode: response.statusCode);
                  }
                } on ServerException  catch (e){
                  throw ServerException(cause: e.cause);
                }
                catch(e){
                  throw ServerException(cause: 'No es posible conectar con el servidor. Contacte con el administrador ');
                }
            }
            @override
            Future<void> logout(String token) {
            // TODO: implement logout
            throw UnimplementedError();
            }
    }
------------------------------------------------ fin clase AuthApiProviderImpl----------------------------------------------------------------------------------

PASO 4:
capa data
- en la carpeta repository
 encarga de hacer la implementacion de las clases creadas en data/providers, estas clases deben extender de las clases abstractas creadas en domain/repository
  ejemplo:
  class AuthApiImpl extends AuthRepository {
      final AuthApiProviderImpl _authApiProviderImpl = Get.find();
    
      @override
      Future<User> auth(AuthRequest authRequest) async {
      try {
      User user = await _authApiProviderImpl.auth(authRequest);
    
          return user;
      } on ServerException  catch (e){
      throw ServerException(cause: e.cause);
      }
    
      }
    
      @override
      Future<void> logout(String token) {
      // TODO: implement logout
      throw UnimplementedError();
  }
  }

------------------------------------------------ FIN PASOS IMPLEMENTAR CLEAN ARCHITECTURE----------------------------------------------------------------------------------

NOTA:
LOS ERRORES DEBEN CAPTURARSE LO MAS CERCANO DONDE OCURREN

CAPAS:
presentation (Presentacion) ->Relacionado a la interfaz del usuario, se manejan gestor de estados (bloc, provider, getx)
    -modules
        -home 
            -debe contener
            -home_binding.dart
            -home_controller.dart
            -home_page.dart
        -login
        -splash
    -routes
        -app_pages.dart
        -app_routes.dart
    -widgets (generales de la app)
domain (Dominio)->Se trabaja los casos de uso
    -repositories (Se definen los contratos)
        -local
        -remote
    -usecases
data (Datos)-> utiliza el patron repositorio
    -models (modelos a parsear)
    -providers
        -local
            -local_repository
        -remote
            -api
            -firebase
            -otros
core (relacionado al aplicativo)
    -exceptions
    -theme
    -utils
    -values
        -languages
        -app_colors.dart
        -app_images.dart
        -app_string.dart
    -app_config.dark








