part of '../../providers_impl.dart';

class Host {
  static gethost({bool onlyUrl = false}) {
    String url = '';
    switch (SiipneConfig.AmbienteUrl) {
      case Ambiente.desarrollo:
        url = "http://192.168.80.90/"; //Desarrollo
        url=_setSegmentoSiipne(url,onlyUrl);
        break;
      case Ambiente.prueba:
        url = "test.policia.gob.ec"; //Pruebas
        url=_setSegmentoSiipne(url,onlyUrl);
        break;
      case Ambiente.produccion:
        url = "siipne.policia.gob.ec"; //Produccion
        url=_setSegmentoSiipne(url,onlyUrl);
        break;
    }
    return url;
  }

  static  _setSegmentoSiipne(String url, onlyUrl) {
    if (onlyUrl) {
      return url;
    }

    String segmento = '/api/v1/siipne-movil/';

    return url + segmento;
  }
}
