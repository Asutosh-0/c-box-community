import 'package:c_box/firebase_options.dart';
import 'package:c_box/pages/AuthPage/Login.dart';
import 'package:c_box/pages/AuthPage/OtpVerify.dart';
import 'package:c_box/pages/AuthPage/signup.dart';
import 'package:c_box/pages/user_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    // home: Otpverify(),


    // home: UserDetailScreen(),
    home: Login(),
    // home: SignUp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'C Box',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7B66FF)),
      //   useMaterial3: true,
      // ),
      // home:  SignIn()//Navigation_Bar(),
      // home: Login(),
    );

  }
}