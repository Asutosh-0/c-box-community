import 'package:c_box/navigation_bar/navigation_bar.dart';
import 'package:c_box/pages/AuthPage/Login.dart';
import 'package:c_box/pages/AuthPage/OtpVerify.dart';
import 'package:c_box/services/Authentication.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late EmailAuth emailAuth;
  TextEditingController emailC= TextEditingController();

  TextEditingController passwordC= TextEditingController();

  TextEditingController cPasswordC= TextEditingController();



  void showLoading(){
    showDialog(context: context, builder: (context){
      return Center(
          child:SizedBox(
            width: 25, // Adjust the width to reduce the size
            height: 25, // Adjust the height to reduce the size
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 2.0,
            ),
          ),
        )
      ;
    });
  }

  void showUpdate(String message)
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        content: Text(message,style: TextStyle(color: Colors.white),
        ),

        duration: Duration(seconds: 3),
        // backgroundColor: Colors.blue.withOpacity(0.1)
            backgroundColor: Colors.transparent
          ,));

  }

  void CheckValue() async
  {
    String email= emailC.text.trim();
    String password= passwordC.text.trim();
    String cPassword= cPasswordC.text.trim();

    if(email.isEmpty || password.isEmpty || cPassword.isEmpty )
      {
        print("enter all the field");
        showUpdate("enter all the field");

      }
    else{
      if(password != cPassword)
      {
        print("password not match");
        showUpdate("password not match");
      }
      else{
        showLoading();
        // sign up
         String res = await SignUpUser(email, password);
         if(res == "success")
           {
             showUpdate("account create successfully");
             // navigating next User
             Navigator.pop(context);
             Navigator.push(context, MaterialPageRoute(builder: (context)=> Otpverify()));
           }
         else{

           Navigator.pop(context);
           showUpdate(res);
           print(res);


         }





      }

    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailAuth = new EmailAuth(sessionName: "Verify your C-Box Account");
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
                    SizedBox(height: 40,),
                    Row(
                      children: [
                        Container(
                            width: 35,
                            height: 35,
                            child: Image.asset("assets/c_box.png",fit: BoxFit.cover,)
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("C-Box",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            Text("C O M M U N I T Y",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11,color: Colors.black87),)
                          ],
                        )
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                          },
                          child: Text("I have an account",
                              style: TextStyle(color: Colors.blue[900])),
                        )
                      ],
                    ),
                    SizedBox(height: 40),
                    Text("Email"),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: TextField(
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        controller: emailC,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black45),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
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
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        controller: passwordC,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black45),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    Text("Conform Password"),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: TextField(
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        controller: cPasswordC,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black45),
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
                        onPressed: () {

                          CheckValue();
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> Navigation_Bar()));
                        },
                        child: Text("SIGN UP",
                            style: TextStyle(color: Colors.white)),
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
                    SizedBox(height: 20,)
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




