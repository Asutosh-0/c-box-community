import 'package:c_box/firebase_options.dart';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/navigation_bar/navigation_bar.dart';
import 'package:c_box/pages/AuthPage/Login.dart';
import 'package:c_box/pages/AuthPage/OtpVerify.dart';
import 'package:c_box/pages/AuthPage/signup.dart';
import 'package:c_box/pages/user_detail_screen.dart';
import 'package:c_box/services/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);


  User? user= FirebaseAuth.instance.currentUser;
  if(user!= null)
    {
      UserModel? userModel = await getUserModel(user.uid.toString());
      if(userModel != null)
        {
          runApp(
            ExistLogin(userModel: userModel)
          );
        }
      else
        {
          runApp(LoginApp());
        }
    }
  else
    {
      runApp(LoginApp());

    }

}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "C Box",
      home:  Login(),
    );
  }
}

class ExistLogin extends StatelessWidget {
  final UserModel userModel;
  const ExistLogin({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "C Box",
      home:  Navigation_Bar(userModel: userModel,),

    );
  }
}

