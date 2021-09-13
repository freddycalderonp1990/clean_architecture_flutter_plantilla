import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Ambiente { desarrollo, prueba, produccion }

class SiipneConfig {
  static const AmbienteUrl=Ambiente.desarrollo;

  static const String linkAppAndroid =
      "https://play.google.com/store/apps/details?id=ecuador.policianacional.dntic.siipnemovil2";
  static const String linkAppIos =
      "https://apps.apple.com/ec/app/siipnemovil-2/id1552944115";

  static const Color colorBordecajas = Colors.blueAccent;
  static const Color colorBotonesWidget = Colors.lightBlue;

  static const double radioBordecajas = 15.0;
  static const double sobraBordecajas = 12.0;

  static const double tamTextoTitulo = 4.0; //tamaño del texto en porcentaje
  static const double tamTexto = 3.5; //tamaño del texto en porcentaje

  static const double anchoContenedor = 90.0;


}
