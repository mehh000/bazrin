import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Updateunits {
  static Future<dynamic> UpdateUnit(data, String id) async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();
    final cleanId = id;

    try {
      final response = await dio.put(
        '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/units/$cleanId',
        data: {"name": data['name'], "status": data['status']},
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      // print('from backend $data and id $cleanId');
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
