import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Supplierspayments {
  static Future<dynamic> getSupplierPayments(String type) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.get(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/supplier-payments?type=$type&invoiceNumber&supplierId&accountId',
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
