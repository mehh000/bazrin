import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Deletesalereturnbyid {
  static Future<dynamic> deleteSaleReturnbyId(id) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      await dio.delete(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/sale-returns/$id',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      return 'success';
    } on DioError catch (e) {
      // print(' DioError: ${e.response?.statusCode}');
      // print('Response data: ${e.response?.data}');
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
