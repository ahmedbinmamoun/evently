import 'package:event/ui/home/widgets/custom_elevated_button.dart';
import 'package:event/ui/home/widgets/custom_text_form_feild.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatefulWidget {
   ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forget_password,style: AppStyle.medium16Black,),
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: width * 0.02,
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppAssets.changeSettingImage),
                SizedBox(height: height * 0.02,),
                CustomTextFormFeild(
                  controller: emailController,
                  validator: (text) {
                      if(text == null || text.isEmpty){
                        return AppLocalizations.of(context)!.plaese_enter_email;
                      }
                      final bool emailValid = 
                                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(text);
                                      if(!emailValid){
                                        return AppLocalizations.of(context)!.enter_valid_email; 
                                      }
                      return null;
                    },
                  prefixIcon: Image.asset(AppAssets.emailIcon,color: Theme.of(context).hintColor,),
                  hintText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                  colorBorderSide: Theme.of(context).cardColor,
                  ),
                  SizedBox(height: height * 0.02,),
                CustomElevatedButton(
                  onPressed: (){
                      resetPassword();
                },
                text: AppLocalizations.of(context)!.reset_password,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword() {
    if(formKey.currentState?.validate() == true){
      
    }
    }
}