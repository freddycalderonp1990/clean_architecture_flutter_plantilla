


import 'data/repository/data_repositories.dart';


import 'data/providers/providers_impl.dart';
import 'domain/repositories/domain_repositories.dart';

import 'package:get/get.dart';


class DependencyInjection extends Bindings{

  static ini(){

/*    //repositorios
    Get.lazyPut<AuthRepository> (() => AuthApiImpl());
    Get.lazyPut<LocalStorageRepository> (() => LocalStoreImpl());
    Get.lazyPut<LocalStoreImpl> (() => LocalStoreImpl());

    //providers
    Get.lazyPut<AuthApiProviderImpl> (() => AuthApiProviderImpl());
    Get.lazyPut<LocalStoreProviderImpl> (() => LocalStoreProviderImpl());
*/
    //repositori
    //Al utilizar lazuPut solo se crea una vez la dependencia,
    //con fenix: true, le decimos que se vuelva a crear cuando la necesitamos

    Get.lazyPut<AuthRepository> (() => AuthApiImpl(), fenix: true);
    Get.lazyPut<LocalStorageRepository> (() => LocalStoreImpl(), fenix: true);
    Get.lazyPut<TestAntRepository> (() => TestAntApiImpl(), fenix: true);

    //Providers
    Get.lazyPut<AuthApiProviderImpl> (() => AuthApiProviderImpl(), fenix: true);
    Get.lazyPut<LocalStoreProviderImpl> (() => LocalStoreProviderImpl(), fenix: true);
    Get.lazyPut<AntApiProviderImpl> (() => AntApiProviderImpl(), fenix: true);




  }

  @override
  void dependencies() {
    print('DependencyInjection');
    ini();

    /* Get.lazyPut<Dio>(() => Dio(BaseOptions(baseUrl: 'http://192.168.80.90')));
    Get.lazyPut<LoginApi>(() => LoginApi());
    Get.lazyPut<LoginRepository>(() => LoginRepository());*/
  }


}