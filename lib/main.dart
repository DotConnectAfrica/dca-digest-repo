import 'package:dca_digital_digests/screens/help_center.dart';
import 'package:dca_digital_digests/screens/learn_more_webview.dart';
import 'package:dca_digital_digests/screens/my_account.dart';
import 'package:dca_digital_digests/screens/news_description.dart';
import 'package:dca_digital_digests/screens/news_page.dart';
import 'package:dca_digital_digests/screens/splash_screen.dart';
import 'package:dca_digital_digests/screens/terms.dart';
import 'package:dca_digital_digests/screens/webview.dart';
import 'package:dca_digital_digests/screens/welcome_screen.dart';
import 'package:dca_digital_digests/widgets/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'auth/login.dart';
import 'auth/sign_up_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(create: (context) => ThemeService(),
    child: const MyApp(),
  ));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  String? get pageTitle => null;
  String? get url => null;

  String? get title => null;
  String? get link => null;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'splash_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'splash_screen': (context) => SplashScreen(),
        'screen_webview': (context) => ScreenWebView('Title', 'https://www.google.com/'),
        'screen_terms':(context) => Terms(0),
        'screen_account':(context) => ScreenMyAccount(),
        'screen_help_center' : (context) => HelpCenter(),
        'signup_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'news_page': (context) => NewsPageScreen(),
        'news_description' : (context) => NewsDescription(pageTitle, url),
        'learn_more_webview' : (context) => LearnWebView(title, link )
      },
    );
  }
}
