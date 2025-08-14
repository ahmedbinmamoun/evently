abstract class ResetPasswordNavigator {

  void showLoading(String loading);
  void hideLoading();
  void showMessage({
    required String message,
    String? posActionsName,
    Function? posAction,
    String? negActionsName,
    Function? negAction,
    String? title,});
}