
import 'package:bazrin/feature/presentation/common/classes/imports.dart';


class Getexpensebyid {
  static Future<dynamic> getExpenseById(id) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.get(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/expenses/$id',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      // print(' Expense data: ${response.data['content']}');
      return response.data;
    } on DioError catch (e) {
      // print(' DioError: ${e.response?.statusCode}');
      // print('Response data: ${e.response?.data}');
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
