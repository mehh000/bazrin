import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Logout {
  static logout(context) {
    LocalStorage.box.delete('accessToken');
    LocalStorage.box.delete('refreshToken');
    Navigator.of(context).push(
      SlidePageRoute(page: LOGINSCREEN(), direction: SlideDirection.right),
    );
    TostMessage.showToast(
      context,
      message: "Log Out SuccessFully done",
      isSuccess: true,
    );
  }
}
