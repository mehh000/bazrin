import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Customerspayments {
  static Future<dynamic> getCustomerPayments(String type) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();
 //SALE_DUE_PAYMENT|SALE_DUE_DISMISSAL|SALE_RETURN_DUE_PAYMENT|SALE_RETURN_DUE_DISMISSAL
    try {
      final response = await dio.get(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/customer-payments?type=$type',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      // print('✅ Payemnt data: ${response.data['content']}');
      return response.data['content'];
    } on DioError catch (e) {
      print(' DioError: ${e.response?.statusCode}');
      print('Payemnt data: ${e.response?.data}');
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
