import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class AddorderSaleReturn {
  static Future<dynamic> addOrderSaleReturn(data) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.post(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/sale-returns',
        data: {
          "invoiceNumber": data['invoiceNumber'],
          "saleId": data['saleId'],
          "returnTypeId": data['returnTypeId'],
          "returnDate": data['returnDate'],
          "note": data['note'],
          "items": data['items'],
          "payments": data['payments'],
        },
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      // print('send data $data');
      // print(' Expense data: ${response.data}');
      return 'success';
    } on DioError catch (e) {
      // print(' DioError: ${e.response?.statusCode}');
      // print('Response data: ${e.response?.data}');
      return {'error': e.response?.data};
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
