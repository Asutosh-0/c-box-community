import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/user_detail_screen.dart';
import 'package:c_box/services/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpVerify extends StatefulWidget {
  final String name;
  final String password;
  final String otp;
  final String email;

  OtpVerify({required this.name, required this.email, required this.password, required this.otp});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  TextEditingController otpController = TextEditingController();

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Verify OTP",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: Text(
                              "Send OTP",
                              style: TextStyle(color: Colors.blue[900], fontSize: 13),
                            ),
                            onTap: () {
                              // Send OTP
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () async {
                          String inputOtp = otpController.text.trim();

                          // Print the received values
                          print("Name: ${widget.name}");
                          print("Password: ${widget.password}");
                          print("OTP: ${widget.otp}");

                          if (widget.otp == inputOtp) {
                            // sign up
                            String res = await SignUpUser(widget.email, widget.password);
                            if (res == "success") {
                              User? user = FirebaseAuth.instance.currentUser;
                              UserModel userModel = UserModel(
                                userName: widget.name,
                                email: widget.email,
                                password: widget.password,
                                uid: user!.uid,
                                followers: [],
                                following: [],
                              );

                              // showUpdate("Account created successfully");

                              // navigating next User
                              Navigator.pop(context);
                              // Go to user detail
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailScreen(userModel: userModel)));
                            } else {
                              Navigator.pop(context);
                              // showUpdate(res);
                              print(res);
                            }
                          }
                        },
                        child: Text(
                          "Verify",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
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
