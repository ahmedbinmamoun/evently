import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/firebase_options.dart';
import 'package:event/providers/app_language_provider.dart';
import 'package:event/providers/app_theme_provider.dart';
import 'package:event/providers/event_list_provider.dart';
import 'package:event/ui/auth/login/login_screen.dart';
import 'package:event/ui/auth/register/register_screen.dart';
import 'package:event/ui/auth/reset_password/reset_password_screen.dart';
import 'package:event/ui/edit_event/edit_event.dart';
import 'package:event/ui/event_details/event_details.dart';
import 'package:event/ui/home/add_event/add_event.dart';
import 'package:event/ui/home/home_screen.dart';
import 'package:event/ui/onboarding/onboarding_screen.dart';
import 'package:event/ui/onboarding/start_screen.dart';
import 'package:event/utils/app_routes.dart';
import 'package:event/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';  


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
await FirebaseFirestore.instance.disableNetwork();

  final appThemeProvider = AppThemeProvider();
  await appThemeProvider.loadTheme();

  final appLanguageProvider = AppLanguageProvider();
  await appLanguageProvider.loadLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appLanguageProvider),
        ChangeNotifierProvider.value(value: appThemeProvider), 
        ChangeNotifierProvider(create: (context)=> EventListProvider())
      ],
      child: Myapp(),
    ),
  );
}




class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginRouteName,
      routes: {
        AppRoutes.homeRouteName : (context) => HomeScreen(),
        AppRoutes.onboardingRouteName : (context) => OnboardingScreen(),
        AppRoutes.startRouteName : (context) => StartScreen(),
        AppRoutes.loginRouteName : (context) => LoginScreen(),
        AppRoutes.registerRouteName : (context) => RegisterScreen(),
        AppRoutes.resetPasswordRouteName : (context) => ResetPasswordScreen(),
        AppRoutes.addEvent : (context) => AddEvent(),
        AppRoutes.editEvent : (context) => EditEvent(),
        AppRoutes.eventDetails : (context) => EventDetails(),
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeProvider.appTheme,

    );
  }
}