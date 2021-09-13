


import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilidadesUtil {

  static bool plataformaIsAndroid() {
    return  GetPlatform.isAndroid;

  }

  static Future<String> getVersionCodeNameApp() async{

    String versionName = await getVersionName();
    String versionCode =await getVersionCode();

    String result= versionName+' - '+versionCode;

    return result;
  }

  static Future<String> getVersionName() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;


    String result= versionName;

    return result;
  }

  static Future<String> getVersionCode() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String versionCode = packageInfo.buildNumber;

    String result= versionCode;

    return result;
  }

  static abrirUrl(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }





}
