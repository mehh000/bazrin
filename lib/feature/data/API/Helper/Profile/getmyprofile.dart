import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Getmyprofile {
  static dynamic getMyProfile() async {
    final dio = Dio(BaseOptions(baseUrl: ApiAddress.HOST_STORE));
    final accessToken = LocalStorage.box.get('accessToken');
    if (accessToken == null) {
      return 'access token not found';
    }

    final shopresponse = await Getmyshop.getMyshop();

    if (accessToken != null) {
      try {
        final res = await dio.get(
          '/${shopresponse['shopNameslug']}/${shopresponse['branchNameslug']}/staff/context',
          options: Options(headers: {'authorization': 'Bearer $accessToken'}),
        );
        await LocalStorage.box.put('myprofile', res.data);
        return res.data;
      } on DioError catch (e) {
        print('DioError: ${e.response?.statusCode}');
        print(' Response data: ${e.response?.data}');
      } catch (e) {
        print('Unknown error: $e');
      }
    } else {
      return 'access token not found';
    }
  }
}
