import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Getsuppliers {
  static Future<dynamic> getSuppliersList() async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    try {
      final response = await dio.get(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/suppliers',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      // print('✅ suppliers data: ${response.data['content']}');
      return response.data['content'];
    } on DioError catch (e) {
      // print(' DioError: ${e.response?.statusCode}');
      // print('Response data: ${e.response?.data}');
    } catch (e) {
      // print(' Unknown error: $e');
    }
  }
}
