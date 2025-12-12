import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Deleteaccount {
  static Future<dynamic> DeleteAccountByID(id) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.delete(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/accounts/$id',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      // print(' Expense Detete data: ${response.data}');
      return 'success';
    } on DioError catch (e) {
      // print(' DioError: ${e.response?.statusCode}');
      // print('Response Detete data: ${e.response?.data}');
      return {'error': e.response?.data};
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
