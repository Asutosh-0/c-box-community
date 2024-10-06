import 'package:c_box/main.dart';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/AuthPage/Login.dart';
import 'package:c_box/pages/chatting/UserBottomSeet.dart';
import 'package:c_box/pages/pages/ShowHistory.dart';
import 'package:c_box/pages/pages/save_poct_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void ShowButtomSheet(BuildContext context,UserModel userModel) async
{
      await showModalBottomSheet(context: context,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topLeft:  Radius.circular(20),
    topRight: Radius.circular(20)
    )
    ),
    builder: (_) {
    return ListView(
    shrinkWrap: true,
    children: [
    Container(
    height: 4,
    margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.015 ,horizontal: MediaQuery.of(context).size.width*0.4),
    decoration: BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.circular(8)

    ),
    ),

      OptionItem(icon: Icon(Icons.history), text: "history", onTap: (){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Showhistory(userModel: userModel,) ));

      }),
      OptionItem(icon: Icon(Icons.save), text: "Saved", onTap: (){

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SavePostScreen(userModel: userModel) ));

      }),



      OptionItem(icon: Icon(Icons.settings), text: "setting", onTap: (){
        Navigator.pop(context);

      }),
      OptionItem(icon: Icon(Icons.logout_outlined), text: "logout", onTap: ()async{
       await  FirebaseAuth.instance.signOut();
       Navigator.popUntil(context, (rout)=> rout.isFirst);
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login() ));
      }),

    ]
    );
    });
  }
