import 'dart:io';

import 'package:event/model/my_user.dart';
import 'package:event/providers/app_language_provider.dart';
import 'package:event/providers/event_list_provider.dart';
import 'package:event/providers/user_provider.dart';
import 'package:event/ui/auth/login/login_navigator.dart';
import 'package:event/ui/auth/login/login_view_model.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator{
  GoogleSignInAccount? _user;
  

  LoginViewModel viewModel = LoginViewModel();

  

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

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.06,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * 0.2,
                child: Image.asset(AppAssets.logo),
              ),
              SizedBox(height: height * 0.02),
              Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
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
                    SizedBox(height: height * 0.01),
                    TextButton(
                      onPressed: () {},
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.resetPasswordRouteName,
                            );
                          },
                          child: Text(
                            '${AppLocalizations.of(context)!.forget_password} ? ',
                            style: AppStyle.bold16Primary.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    CustomElevatedButton(
                      onPressed: () {
                        viewModel.login(context);
                      },
                      text: AppLocalizations.of(context)!.login,
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dont_have_account,
                          style: AppStyle.medium16Black.copyWith(
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.registerRouteName);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.create_account,
                            style: AppStyle.medium16Primary.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.primaryLight,
                            indent: width * 0.06,
                            endIndent: width * 0.04,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.or,
                          style: AppStyle.medium16Primary,
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.primaryLight,
                            indent: width * 0.04,
                            endIndent: width * 0.06,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      onPressed: (){
                        signUpWithGoogle(context);
                      },
                      backgroundColor: AppColors.transparentColor,
                      borderColorSide: AppColors.primaryLight,
                      hasIcon: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.googleIcon),
                          SizedBox(width: width * 0.02),
                          Text(
                            AppLocalizations.of(context)!.login_with_google,
                            style: AppStyle.bold20Primary,
                          ),
                        ],
                      ),
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
    );
  }


Future<void> signUpWithGoogle(BuildContext context) async {
  DialogUtils.showDialgLoding(context: context);

  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      DialogUtils.hideLoading(context: context);
      return;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final firebaseUser = userCredential.user;

    if (firebaseUser == null) {
      DialogUtils.hideLoading(context: context);
      return;
    }

    var user = await FirebaseUtils.readDataFromFireStore(firebaseUser.uid);

    if (user == null) {
      user = MyUser(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? 'User',
        email: firebaseUser.email ?? '',
      );
      await FirebaseUtils.addUserToFireStore(user);
    }

    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.updateUser(user);

    var eventListProvider = Provider.of<EventListProvider>(context, listen: false);
    eventListProvider.changeSelectedIndex(0, user.id);
    eventListProvider.getAllFavoriteEventFromFirsStore(user.id);

    

    DialogUtils.hideLoading(context: context);

    DialogUtils.showMessage(
      context: context,
      message: AppLocalizations.of(context)!.login_succesfully,
      title: AppLocalizations.of(context)!.succesfully,
      posActionsName: AppLocalizations.of(context)!.ok,
      posAction: () {
        Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
      },
    );
  } catch (e) {
    DialogUtils.hideLoading(context: context);
    DialogUtils.showMessage(
      context: context,
      message: AppLocalizations.of(context)!.error,
      title: AppLocalizations.of(context)!.error,
      posActionsName: AppLocalizations.of(context)!.ok,
    );
  }
}

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    DialogUtils.hideLoading(context: context);
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
    DialogUtils.showDialgLoding(context: context);
  }
  
  @override
  void showMessage({required String message, String? posActionsName, Function? posAction, String? negActionsName, Function? negAction, String? title}) {
    // TODO: implement showMessage
    DialogUtils.showMessage(context: context, message: message,posActionsName: posActionsName,posAction: posAction);
  }
  
  
  


  
}