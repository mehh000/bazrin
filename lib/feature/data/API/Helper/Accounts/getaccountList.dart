import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Getaccountlist {
  static Future<dynamic> getAccountsList([
    int page = 0,
    String search = '',
  ]) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.get(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/accounts?page=$page&search=$search',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      // print('✅ Expense data: ${response.data['content']}');
      return {
        "data": response.data['content'],
        "totalPage": response.data['totalPages'],
      };
    } on DioError catch (e) {
      // print(' DioError: ${e.response?.statusCode}');
      // print('Response data: ${e.response?.data}');
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
