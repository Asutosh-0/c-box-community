import 'dart:io';

import 'package:c_box/models/PostModel.dart';
import 'package:c_box/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

Future<String> UploadPost(UserModel usermodel, File file, String caption,bool isVideo) async
{
  try{
    String id = Uuid().v1();
    String postUrl = await  getImageUrl(file, id);
    if(postUrl != "Error")
      {
        PostModel postModel = PostModel(
          userName: usermodel.userName,
          uid: usermodel.uid,
          postId: id,
          postUrl: postUrl,
          profilePic: usermodel.profilePic,
          caption: caption,
          likes: [],
          commentCount: 0,
          shareCount: 0,
          isVideo:  isVideo
        );
        await FirebaseFirestore.instance.collection("PostDetail").doc(id).set(postModel.toMap());

        return "success";
      }
    else
      {
       return "error";
      }
  }
  catch(er)
  {
    return er.toString();
  }

}



Future<String> getImageUrl(File file, String id)async{

  String url = "Error";

  try {
    Reference reference = FirebaseStorage.instance.ref().child("Media/$id");
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