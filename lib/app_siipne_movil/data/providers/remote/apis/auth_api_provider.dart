part of '../../providers_impl.dart';

class AuthApiProviderImpl extends AuthRepository {
  @override
  Future<User> auth(AuthRequest authRequest) async {
    try {
      Object? body = {
        "user": authRequest.user,
        "pass": "b9325d3c93713bef80a22ef6aeef8ccdd45f3f18",
        "isAndroid": authRequest.isAndroid.toString(),
        "versionCodeApp": authRequest.versionCodeApp.toString(),
        "imei": authRequest.imei,
        "tipoRed": authRequest.tipoRed,
        "nameRed": authRequest.nameRed
      };
      String json = await UrlApiProvider.post(
          isLogin: true, body: body, segmento: 'auth');

      return userModelFromJson(json).user;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<void> logout(String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
