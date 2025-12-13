import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Getpossale {
  static Future<dynamic> getPosSale([
    int page = 0,
    String saleType = '',
    String startDate = '',
    String endDate = '',
    String customerId = '',
  ]) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.get(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/pos?page=$page&saleType=$saleType&startDate=$startDate&endDate=$endDate&customerId=$customerId',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      // print('✅ products data: ${response.data['content']}');
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
