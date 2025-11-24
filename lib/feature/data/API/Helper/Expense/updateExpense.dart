import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Updateexpense {
  static Future<dynamic> UpdateExpense(data, id) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.put(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/expenses/$id',
        data: {
          "categoryId": data['category']['id'],
          "date": data['date'],
          "invoiceNumber": data['invoiceNumber'],
          "payments": [
            {
              "accountId": data['paymentData']['id'],
              "amount": data['payamount'],
            },
          ],

          "note": data['note'],
          "items": data['items'],

          // .toList(),
          "attachments": [],
        },
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      // print('send data $data');
      // print(' Expense data: ${response.data}');
      return {'success': response.data};
    } on DioError catch (e) {
      // print(' DioError: ${e.response?.statusCode}');
      // print('Response data: ${e.response?.data}');
      return {'error': e.response?.data};
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}



// .map(
//             (item) => {
//               "productId": item['productId'],
//               "quantity": item['quantity'],
//               "unitCost": item['unitCost'],
//             },
//           )