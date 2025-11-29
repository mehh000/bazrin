import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Addpossell {
  static Future<dynamic> addPosSell(data) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.post(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/pos',
        data: data,
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      // print('send data $data');
      // print(' Expense data: ${response.data}');
      return 'success';
    } on DioError catch (e) {
      print(' DioError: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      return {'error': e.response?.data};
    } catch (e) {
      print(' Unknown error: $e');
    }
  }
}

/* {
          "customerId": "6922a1913babf9778db55d37",
          "quotationId": null,
          "lineItems": [
            {
              "productId": "6925892095cc67d65cbb5ff9",
              "quantity": 2,
              "variant": [],
              "model": null,
              "discount": null,
            },
          ],
          "payments": [
            {"accountId": "6922abf63babf9778db55d40", "amount": 0},
          ],
          "discount": {"type": "PERCENT", "value": "29"},
          "cashTender": {"receivedAmount": 0, "returnAmount": 0},
          "deliveryCost": 86,
          "vatPercent": "98",
           "installment": {"numberOfMonths": 5, "interestRate": 0},
        }, */
