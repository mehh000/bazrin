import 'package:bazrin/feature/core/api.dart';
import 'package:bazrin/feature/data/API/Helper/Myshop/getmyshop.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:dio/dio.dart';

class Getexpenseproductslist {
  static Future<dynamic> getExpenseProductsList() async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.get(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/expense-products?page=0&size=10&status=ACTIVE',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      // print('✅ Expense data: ${response.data['content']}');
      return response.data['content'];
    } on DioError catch (e) {
      // print(' DioError: ${e.response?.statusCode}');
      // print('Response data: ${e.response?.data}');
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
