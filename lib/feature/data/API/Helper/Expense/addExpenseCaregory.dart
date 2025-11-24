import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Addexpensecaregory {
  static Future<dynamic> AddExpensecategory(data) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.post(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/expense-categories',
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
