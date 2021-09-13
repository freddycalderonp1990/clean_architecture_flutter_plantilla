import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

class PhotoHelper{
  static Uint8List?  convertStringToUint8List(String? fotoString){

    try {
      Uint8List? imgDecode = null;
      if (fotoString != null && fotoString != '') {
        print('si hay imagen ${fotoString}');
        final decodedBytes = base64Decode(fotoString
            .toString()
            .split(',')
            .last);
        imgDecode = decodedBytes;

        log(imgDecode.toString());
      }
      return imgDecode;
    }
    catch(e){
      log('Error al convertir imagen en ${e}');
    }
  }
}