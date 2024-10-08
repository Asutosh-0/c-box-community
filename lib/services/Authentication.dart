
import 'dart:io';

import 'package:c_box/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> SignUpUser(String email, String password) async
{
  try
      {
        UserCredential userCredential = await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        if(userCredential!= null)
          {
            return "success";
          }
        else{
          return "error";
        }

      }
      on FirebaseAuthException catch (e)
  {
    return e.code.toString();

  }

}


Future<String> SignInUser(String email,String password) async
{
  try{

    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

    if(userCredential!= null)
      {
        return "success";
      }
    else{
      return "error";
    }
  }
  on FirebaseAuthException catch(er)
  {
    return er.code.toString();

  }

}

Future<String> SaveUserModel(UserModel usermodel) async
{
  try
      {
        FirebaseFirestore.instance.collection("UserDetail").doc(usermodel.uid!).set(usermodel.toMap());

        return "success";

      }
      catch (er){

    return er.toString();

      }
}
Future<String> UpdateUserModel(UserModel usermodel) async
{
  try
  {
    FirebaseFirestore.instance.collection("UserDetail").doc(usermodel.uid!).update(usermodel.toMap());

    return "success";

  }
  catch (er){

    return er.toString();

  }
}

Future<UserModel?> getUserModel(String uid)async{

  UserModel? userModel;

  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection(
        "UserDetail").doc(uid).get();

    if (snapshot.data() != null) {
      userModel = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    }
  }
  catch (er)
  {
    print(er.toString());
  }
    return userModel!;
  
}

Future<String> getProfilePicImageUrl(File file, String id)async{

  String url = "Error";

  try {
    Reference reference = FirebaseStorage.instance.ref().child("ProfilePic/$id");
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    url =  await snapshot.ref.getDownloadURL();

    print(url);
    return url;
  }
  catch(er)
  {
    print(er);
    return url;
  }

}

void UpdateAllPostProfilePic(UserModel userModel) async
{


}
