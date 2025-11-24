import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Addexpenseproduct {
  static Future<dynamic> AddExpenseProduct(data) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.post(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/expense-products',
        data: {"name": data['name'], "status": data['status']},
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      // print('send data $data');
      // print(' Expense Product Data: ${response.data}');

      return 'success';
    } on DioError catch (e) {
      // print(' DioError: ${e.response?.statusCode}');
      // print('Response Product data: ${e.response?.data}');
      return e.response?.data['validationErrors'];
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
