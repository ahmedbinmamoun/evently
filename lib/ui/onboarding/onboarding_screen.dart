import 'package:event/providers/app_language_provider.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'page_1.dart';
import 'page_2.dart';
import 'page_3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  int currentPage = 0;
  


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).shadowColor,
        title: Image.asset(AppAssets.titleLogo),
        centerTitle: true,
      ),
      body: IntroductionScreen(
        key: introKey,
        pages: [
          onboardingPage1(context),
          onboardingPage2(context),
          onboardingPage3(context),
        ],
        showSkipButton: false,
        showNextButton: false,
        showDoneButton: false,
        showBackButton: false,
      
        onChange: (index) {
          setState(() => currentPage = index);
        },
      
        globalFooter: Padding(
          padding:  EdgeInsets.symmetric( 
            horizontal: width * 0.01,
            ),
            
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                
                
             IconButton(
                  icon: Image.asset(
                    appLanguageProvider.isEnglish() ?
                    AppAssets.prevArrow  
                    :
                    AppAssets.forwardArrow,
                    height: height * 0.05,
                    width: width * 0.1,
                    color: currentPage == 0 ? AppColors.transparentColor : null, 
                  ),
                  onPressed: currentPage == 0
                      ? null
                      : () {
                          introKey.currentState?.previous();
                        },
                ),
                
              Row(
                children: List.generate(3, (index) {
                  bool isActive = currentPage == index;
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? width * 0.05 : width * 0.02,
                    height: height * 0.01,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primaryLight : Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),
                
              IconButton(
                    icon: Image.asset(
                      appLanguageProvider.isEnglish() ?
                      AppAssets.forwardArrow 
                      :
                      AppAssets.prevArrow,
                      height: height * 0.05,
                    width: width * 0.1,
                    ),
                    onPressed: () {
                      if (currentPage < 2) {
                        introKey.currentState?.next();
                      } else {
                        Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
                      }
                    },
                  ),
            ],
          ),
        ),
      
        dotsDecorator:  DotsDecorator(
          activeColor: AppColors.transparentColor,
          color: AppColors.transparentColor,
        ),
      ),
    );
  }
}