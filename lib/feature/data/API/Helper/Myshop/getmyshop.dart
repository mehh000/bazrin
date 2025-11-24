
import 'package:bazrin/feature/presentation/common/classes/imports.dart';


class Getmyshop {
  static dynamic getMyshop() async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');

    if (accessToken != null) {
      try {
        final response = await dio.get(
          '/stores',
          options: Options(headers: {'authorization': 'Bearer $accessToken'}),
        );
        await LocalStorage.box.put('storeData', response.data);
        // print(' Store Data: ${response.data}');
        dynamic responseData = {
          'data': response.data,
          'shopNameslug': response.data['owned'][0]['slug'],
          'branchNameslug': response.data['owned'][0]['branches'][0]['slug'],
        };
        return responseData;
      } on DioError catch (e) {
        // print('DioError: ${e.response?.statusCode}');
        // print(' Response data: ${e.response?.data}');
      } catch (e) {
        // print('Unknown error: $e');
      }
    } else {
      return 'access token not found';
    }
  }
}
