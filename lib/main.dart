import 'package:parksmart/views/loginpage.dart';
import 'package:parksmart/views/payment_page.dart';
import 'package:parksmart/views/signuppage.dart';
import 'package:parksmart/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:parksmart/views/homepage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lighttheme(context),
      darkTheme: MyTheme.darktheme(context),
      home: const LoginPage(),
      
      routes: {
       "home": (context) => const HomePage(),
       "pay": (context) => const PaymentPage(),
      },
    );
  }
}

