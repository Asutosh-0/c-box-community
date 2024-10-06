import 'dart:math';
import 'package:c_box/pages/AuthPage/Login.dart';
import 'package:c_box/pages/AuthPage/OtpVerify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController cPasswordC = TextEditingController();
  TextEditingController userNameC = TextEditingController();
  String userName = "";
  String email ="";
  bool satisfy = true;

  void showLoading() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 2.0,
            ),
          ),
        );
      },
    );
  }

  void showUpdate(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  void checkValue() async {
    String userName = userNameC.text.trim();
    String email = emailC.text.trim();
    String password = passwordC.text.trim();
    String cPassword = cPasswordC.text.trim();

    if(satisfy == true) {
      if (userName.isEmpty || email.isEmpty || password.isEmpty ||
          cPassword.isEmpty) {
        showUpdate("Please fill in all fields");
      } else if (password != cPassword) {
        showUpdate("Passwords do not match");
      } else {
        showLoading();

        String res = await sendOTP(email);

        Navigator.pop(context); // Close the loading dialog

        if (res == 'fail') {
          showUpdate("OTP sending failed");
        } else {
          showUpdate("OTP sent successfully");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtpVerify(
                    name: userName,
                    email: email,
                    password: password,
                    otp: res,
                  ),
            ),
          );
        }
      }
    }
  }

  Future<String> sendOTP(String email) async {
    String recipientEmail = email;
    String mailMessage = otpGenerator().toString();

    String userName = "cboxcommunity1@gmail.com";
    String password = "wcmu jhcl hvtx ziws";

    final smtpServer = gmail(userName, password);
    final message = Message()
      ..from = Address(userName, 'C BOX')
      ..recipients.add(recipientEmail)
      ..subject = 'OTP'
      ..text = 'Hi, \n\n Here is your verification code for Email OTP \n\n\n $mailMessage \n\n\n Do not share your OTP with anyone.';

    try {
      await send(message, smtpServer);
      return mailMessage;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return 'fail';
    }
  }

  int otpGenerator() {
    final random = Random();
    return 10000 + random.nextInt(90000); // Generates a number between 10000 and 99999
  }

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    cPasswordC.dispose();
    userNameC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: width > 550 ? 500 : width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          child: Image.asset(
                            "assets/c_box.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "C-Box",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Text(
                              "C O M M U N I T Y",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Text(
                      "SIGN UP",
                      style: TextStyle(fontSize: 24, color: Colors.black87),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("or", style: TextStyle(fontSize: 13)),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);

                          },
                          child: Text(
                            "I have an account",
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Text("Username"),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: TextField(
                        onChanged: (value){
                          setState(() {
                             userName = value;
                          });
                        },
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        controller: userNameC,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black45,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    if (userName!= "")
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("UserDetail").where("userName",isEqualTo: userName).snapshots(),
                        builder: (context, snapshot) {
if(snapshot.connectionState == ConnectionState.waiting)
  {
    return Text("lodding...",style: TextStyle(fontSize: 10));
  }

                          QuerySnapshot qsnap = snapshot.data as QuerySnapshot;
                          if(qsnap.docs.length > 0 ) {


                            // setState(() {
                            //   satisfy = false;
                            // });
                            return Text("userName already present",
                              style: TextStyle(fontSize: 10,color: Colors.red),);
                          }
                          else{
                            return Text("",style: TextStyle(fontSize: 1),);
                          }
                        }
                      ),
                    SizedBox(height: 30),

                    Text("Email"),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: TextField(
                        onChanged: (value){
                          setState(() {
                            email = value;

                          });
                        },
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        controller: emailC,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black45,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    if (email!= "")
                      StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("UserDetail").where("email",isEqualTo: email).snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting)
                            {
                              return Text("lodding...",style: TextStyle(fontSize: 10));
                            }

                            QuerySnapshot qsnap = snapshot.data as QuerySnapshot;
                            if(qsnap.docs.length > 0 ) {

                              // setState(() {
                              //   satisfy = false;
                              // });
                              return Text("email already present",
                                style: TextStyle(fontSize: 10,color: Colors.red),);
                            }
                            else{
                              return Text("",style: TextStyle(fontSize: 1),);
                            }
                          }
                      ),
                    SizedBox(height: 30),
                    Text("Password"),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: TextField(
                        obscureText: true,
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        controller: passwordC,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black45,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text("Confirm Password"),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: TextField(
                        obscureText: true,
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        controller: cPasswordC,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black45,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: checkValue,
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.black26,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("or", style: TextStyle(color: Colors.blue)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.black26,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            child: SvgPicture.asset(
                              "assets/vectors/flat_color_iconsgoogle_x2.svg",
                              width: 27,
                              height: 27,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text("Sign in with Google"),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
