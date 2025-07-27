import 'dart:io';

import 'package:event/model/my_user.dart';
import 'package:event/providers/app_language_provider.dart';
import 'package:event/providers/event_list_provider.dart';
import 'package:event/providers/user_provider.dart';
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

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignInAccount? _user;
  TextEditingController emailController = TextEditingController(
    text: 'ahmedbinmamoun@gmail.com',
  );

  TextEditingController passwordController = TextEditingController(
    text: '123456',
  );

  var formKey = GlobalKey<FormState>();

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
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormFeild(
                      controller: emailController,
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
                      controller: passwordController,
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
                        login();
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
                      onPressed: signInWithGoogle,
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

  void login() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showDialgLoding(context: context);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        var user = await FirebaseUtils.readDataFromFireStore(
          credential.user?.uid ?? '',
        );
        if (user == null) {
          return;
        }
        var usetProvider = Provider.of<UserProvider>(context, listen: false);
        usetProvider.updateUser(user);

        var eventListProvider = Provider.of<EventListProvider>(
          context,
          listen: false,
        );
        eventListProvider.changeSelectedIndex(0, usetProvider.currentUset!.id);
        eventListProvider.getAllFavoriteEventFromFirsStore(
          usetProvider.currentUset!.id,
        );
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: 'login Succesfully.',
          title: 'Succesfully',
          posActionsName: 'OK',
          posAction: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'Email or password is wrong',
            title: 'Error',
            posActionsName: 'OK',
          );
        } else if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'No network',
            title: 'Error',
            posActionsName: 'OK',
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
          posActionsName: 'OK',
        );
      }
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Clear any existing sessions
      await GoogleSignIn.instance.disconnect();
      await GoogleSignIn.instance.signOut();

      // 2. Initialize with platform awareness
      await GoogleSignIn.instance.initialize(
        serverClientId:
            Platform.isAndroid
                ? '481598051103-8heec3cikfb9cle1c5nlpttmbg577qdr.apps.googleusercontent.com'
                : 'IOS_CLIENT_ID.apps.googleusercontent.com',
      );

      // 3. Start auth flow with MIUI workarounds
      final googleUser = await _runWithMiuiWorkaround(() async {
        return await GoogleSignIn.instance.authenticate();
      });

      if (googleUser == null) {
        debugPrint('User cancelled flow');
        return null;
      }

      // 4. Get auth tokens with retry
      final googleAuth = await _retryGoogleAuth(googleUser);
      if (googleAuth.idToken == null) throw Exception('Null ID token');

      // 5. Firebase integration
      return await FirebaseAuth.instance.signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.idToken,
        ),
      );
    } on PlatformException catch (e) {
      if (e.code == '12500' || e.code == '12501') {}
      rethrow;
    }
  }

  // MIUI-specific workarounds
  Future<T?> _runWithMiuiWorkaround<T>(Future<T?> Function() fn) async {
    try {
      // First attempt
      return await fn();
    } on PlatformException catch (e) {
      if (!_isMiuiError(e)) rethrow;

      // Apply MIUI fixes
      await _configureMiuiSettings();
      await Future.delayed(const Duration(seconds: 1));

      // Second attempt
      return await fn();
    }
  }

  bool _isMiuiError(PlatformException e) {
    return e.code == '12500' ||
        e.code == '12501' ||
        e.message?.contains('canceled') == true;
  }

  Future<void> _configureMiuiSettings() async {
    if (!Platform.isAndroid) return;

    try {
      const channel = MethodChannel('miui_fix');
      await channel.invokeMethod('disableBatteryOptimization');
      await channel.invokeMethod('setAutostart');
    } catch (e) {
      debugPrint('MIUI config failed: $e');
    }
  }

  Future<GoogleSignInAuthentication> _retryGoogleAuth(
    GoogleSignInAccount user,
  ) async {
    for (int i = 0; i < 3; i++) {
      try {
        return await user.authentication;
      } on PlatformException catch (e) {
        if (i == 2 || !_isMiuiError(e)) rethrow;
        await Future.delayed(Duration(seconds: 1 * (i + 1)));
      }
    }
    throw Exception('Auth retries exhausted');
  }
}

class GoogleSignInCancelledException implements Exception {}
