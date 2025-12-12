import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Getpurchase {
  static Future<dynamic> getPurchaseList([
    int? page,
    String supplierId = '',
    String productId = '',
    String returnTypeId = '',
    String startDate = '',
    String endDate = '',
  ]) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.get(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/purchases?page=$page&supplierId=$supplierId&productId=$productId&returnTypeId=$returnTypeId&startDate=$startDate&endDate=$endDate',
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
