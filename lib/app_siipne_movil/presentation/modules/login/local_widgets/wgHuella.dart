import 'package:clean_architecture_flutter/app_siipne_movil/core/values/siipne_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers.dart';
import 'desingBtn.dart';

class WgHuella extends StatelessWidget {
  static Object id = 'wgHuella';

  const WgHuella({Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        id: id,
        builder: (_) => _.mostrarAccesoHuella.value
            ? DesingBtn(
                title: "INGRESO CON HUELLA",
                img: SiipneImages.icon_huella,
                onTap: _.ingresoConHuella)
            : Container());
  }
}
