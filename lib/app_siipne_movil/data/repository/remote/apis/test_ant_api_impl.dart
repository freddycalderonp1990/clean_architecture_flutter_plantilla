part of '../../data_repositories.dart';

class TestAntApiImpl extends TestAntRepository {
  final AntApiProviderImpl _antApiProviderImpl = Get.find();

  @override
  Future<String> getDataString(String placa) async {
    try {
      return await _antApiProviderImpl.getDataString(placa);
    } on ServerException catch (e) {
      throw ServerException(cause: e.cause);
    }
  }

  @override
  Future<TestAntModel> getData(String placa) async{
    try {
      return await _antApiProviderImpl.getData(placa);
    } on ServerException catch (e) {
      throw ServerException(cause: e.cause);
    }



  }
}
