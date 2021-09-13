part of '../../providers_impl.dart';

class AntApiProviderImpl extends TestAntRepository {
  @override
  Future<String> getDataString(String placa) async {
    try {
      http.Client client = http.Client();

      print('response.statusCode');
      final String url =
          'https://des.policia.gob.ec/appmovil/dgi/index.php?modulo=placasAnt&placa=${placa}';
      final uri = Uri.parse(url);

      final response = await client.post(uri).timeout(Duration(seconds: 8));
      print('response.statusCode ${response.statusCode.toString()}');
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return response.body.toString();
      } else if (response.statusCode == 401) {
        throw ServerException(cause: "No Autorizado");
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } on ServerException catch (e) {
      throw ServerException(cause: e.cause);
    } catch (e) {

      String msj='';
      if(SiipneConfig.AmbienteUrl!=Ambiente.produccion){
        msj=e.toString();
      }
      throw ServerException(
          cause:
              'No es posible conectar con el servidor. Contacte con el administrador jjajajaja'+msj);
    }
  }

  @override
  Future<TestAntModel> getData(String placa) async {
    try {
      String datos=await this.getDataString( placa);
      return testAntModelFromJson(datos);
    } on ServerException catch (e) {
      throw ServerException(cause: e.cause);
    } catch (e) {
      String msj='';
      if(SiipneConfig.AmbienteUrl!=Ambiente.produccion){
        msj=e.toString();
      }
      throw ServerException(
          cause:
          'No es posible conectar con el servidor. Contacte con el administrador jjajajaja'+msj);
    }
  }
}
