part of '../../providers_impl.dart';

class UrlApiProvider {
  static Future<String> post(
      {String segmento = '', Object? body, bool isLogin = false}) async {
    try {
      http.Client client = http.Client();

      final String url = Host.gethost(onlyUrl: true);
      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }

      final response =
          await client.post(uri, body: body).timeout(Duration(seconds: 8));

      if (response.statusCode == 200) {
        log(response.body);
        return response.body.toString();
      } else if (response.statusCode == 401 && isLogin) {
        throw ServerException(cause: "El Usuario o la clave es incorrecta");
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
       throw ExceptionHelper.captureError(e);
    }
  }
}
