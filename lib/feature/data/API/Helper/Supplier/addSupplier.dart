import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Addsupplier {
  static Future<dynamic> addSupplier(data) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.post(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/suppliers',
        data: {
          "name": data['name'],
          "phone": data['phone'],
          "email": data['email'],
          "address": data['address'],
          "status": "ACTIVE",
        },
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

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
