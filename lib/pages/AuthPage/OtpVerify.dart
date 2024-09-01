import 'package:c_box/pages/pages/user_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class Otpverify extends StatefulWidget {
  final UserModel userModel;
  Otpverify({super.key, required this.userModel});

  @override
  State<Otpverify> createState() => _OtpverifyState();
}

class _OtpverifyState extends State<Otpverify> {
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
                padding: EdgeInsets.symmetric(horizontal: 20), // Add padding here
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
                      width: 200, // Make the width responsive
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Add spacing between widgets
                    Container(
                      width: 200, // Make the width responsive
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
                      width: 200, // Make the width responsive
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          // goto  userdetail

                          Navigator.push(context, MaterialPageRoute(builder: (context)=> UserDetailScreen(userModel: widget.userModel,)));
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
