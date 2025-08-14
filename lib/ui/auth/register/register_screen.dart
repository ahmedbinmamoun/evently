import 'package:event/model/my_user.dart';
import 'package:event/providers/app_language_provider.dart';
import 'package:event/providers/event_list_provider.dart';
import 'package:event/providers/user_provider.dart';
import 'package:event/ui/auth/register/register_navigator.dart';
import 'package:event/ui/auth/register/register_view_model.dart';
import 'package:event/ui/home/widgets/custom_elevated_button.dart';
import 'package:event/ui/home/widgets/custom_text_form_feild.dart';
import 'package:event/ui/onboarding/widgets/image_toggle_switch.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_routes.dart';
import 'package:event/utils/app_style.dart';
import 'package:event/utils/dialog_utils.dart';
import 'package:event/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator{
 


  RegisterViewModel viewModel = RegisterViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }
  

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.blackColor),
          title: Text(
            AppLocalizations.of(context)!.register,
      
            style: AppStyle.medium20Black.copyWith(
              color: Theme.of(context).highlightColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.transparentColor,
        ),
      
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.01,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.2,
                  child: Image.asset(AppAssets.logo),
                ),
                SizedBox(height: height * 0.03),
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      CustomTextFormFeild(
                        controller: viewModel.nameController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.plaese_enter_name;
                          }
      
                          return null;
                        },
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).hintColor,
                        ),
                        hintText: AppLocalizations.of(context)!.name,
                        colorBorderSide: Theme.of(context).cardColor,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextFormFeild(
                        controller: viewModel.emailController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.plaese_enter_email;
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(text);
                          if (!emailValid) {
                            return AppLocalizations.of(
                              context,
                            )!.enter_valid_email;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Image.asset(
                          AppAssets.emailIcon,
                          color: Theme.of(context).hintColor,
                        ),
                        hintText: AppLocalizations.of(context)!.email,
                        colorBorderSide: Theme.of(context).cardColor,
                      ),
      
                      SizedBox(height: height * 0.02),
                      CustomTextFormFeild(
                        controller: viewModel.passwordController,
                        obscureText: true,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.plaese_enter_password;
                          }
                          if (text.length < 6) {
                            return AppLocalizations.of(
                              context,
                            )!.password_should_be_at_least;
                          }
                          return null;
                        },
                        prefixIcon: Image.asset(
                          AppAssets.passwordIcon,
                          color: Theme.of(context).hintColor,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).hintColor,
                        ),
                        hintText: AppLocalizations.of(context)!.password,
                        colorBorderSide: Theme.of(context).cardColor,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextFormFeild(
                        controller: viewModel.rePasswordController,
                        obscureText: true,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.plaese_enter_re_password;
                          }
                          if (viewModel.passwordController.text != text) {
                            return AppLocalizations.of(
                              context,
                            )!.re_password_doesnt_match;
                          }
                          return null;
                        },
                        prefixIcon: Image.asset(
                          AppAssets.passwordIcon,
                          color: Theme.of(context).hintColor,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).hintColor,
                        ),
                        hintText: AppLocalizations.of(context)!.re_password,
                        colorBorderSide: Theme.of(context).cardColor,
                      ),
      
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        onPressed: () {
                          viewModel.register(context: context);
                        },
                        text: AppLocalizations.of(context)!.create_account,
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.already_have_account,
                            style: AppStyle.medium16Black.copyWith(
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: AppStyle.medium16Primary.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
      
                      SizedBox(height: height * 0.02),
                      Container(
                        width: width * 0.15,
                        child: ImageToggleSwitch(
                          firstAsset: AppAssets.usaFlag,
                          secondAsset: AppAssets.egyptFlag,
                          isFirstSelected: true,
                          onToggle: (isEnglish) {
                            isEnglish
                                ? appLanguageProvider.changeLanguage('en')
                                : appLanguageProvider.changeLanguage('ar');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 
  void loginWithGoogle() {}

 
  
  @override
  void hideLoading() {
    // TODO: implement hideLoading
    DialogUtils.hideLoading(context: context);
  }
  
  @override
  void showLoading(String loading) {
    // TODO: implement showLoading
    DialogUtils.showDialgLoding(context: context);
  }
  
  @override
  void showMessage({required String message, String? posActionsName, Function? posAction, String? negActionsName, Function? negAction, String? title}) {
    // TODO: implement showMessage
    DialogUtils.showMessage(context: context, message: message,posAction: posAction,posActionsName: posActionsName,negAction: negAction,negActionsName: negActionsName,title: title);
  }
  
  
}
