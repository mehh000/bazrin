import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Updatesalereturntype {
  static Future<dynamic> UpdateSaleReturnTypey(data, String id) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      await dio.put(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/sale-return-types/$id',
        data: {"name": data['name'], "status": data['status']},
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      // print('send data $data');
      // print(' Expense categories Data: ${response.data}');

      return 'success';
    } on DioError catch (e) {
      // print(' DioError: ${e.response?.statusCode}');
      // print('Response categories data: ${e.response?.data}');
      return e.response?.data['validationErrors'];
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
