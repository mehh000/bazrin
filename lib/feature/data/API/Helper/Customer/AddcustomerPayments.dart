import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Addcustomerpayments {
  static Future<dynamic> AddCustomerPayments(data) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();
    //ADVANCE_PAYMENT|ADVANCE_PAYMENT_RETURN|PURCHASE_DUE_PAYMENT|PURCHASE_DUE_DISMISSAL|PURCHASE_RETURN_DUE_PAYMENT|PURCHASE_RETURN_DUE_DISMISSAL

    try {
      final response = await dio.post(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/customer-payments',
        data: {
          "invoiceNumber": data['invoiceNumber'],
          "date": data['date'],
          "note": data['note'],
          "accountId": data['accountId'],
          "customerId": data['customerId'],
          "type": data['type'],
          "amount": data["amount"],
        },
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      print('✅ Payemnt data: ${response.data['content']}');
      return 'success';
    } on DioError catch (e) {
      print(' DioError: ${e.response?.statusCode}');
      print('Payemnt data: ${e.response?.data}');
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
