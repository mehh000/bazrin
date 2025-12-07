import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Getcustomers {
  static Future<dynamic> getCustomersList([int? page]) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.get(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/customers',
        queryParameters: page != null ? {'page': page} : null,
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      // print('✅ suppliers data: ${response.data['content']}');
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
