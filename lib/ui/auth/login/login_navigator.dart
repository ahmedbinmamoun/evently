abstract class LoginNavigator {
  void hideLoading();
  void showLoading();
  void showMessage({
    required String message,
    String? posActionsName,
    Function? posAction,
    String? negActionsName,
    Function? negAction,
    String? title,});
}