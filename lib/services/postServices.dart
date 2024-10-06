import 'dart:developer';
import 'dart:io';

import 'package:c_box/models/PostModel.dart';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/Screens/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

void LikePost(String id)  async
{
  DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("PostDetail").doc(id).get();
  var uid= FirebaseAuth.instance.currentUser!.uid!;

  Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;

  if(map["likes"].contains(uid)){
    await FirebaseFirestore.instance.collection("PostDetail").doc(id).update({
      "likes": FieldValue.arrayRemove([uid])
    });
  }
  else
    {
      await FirebaseFirestore.instance.collection("PostDetail").doc(id).update({
        "likes":FieldValue.arrayUnion([uid])
      });
    }



}

Future<UserModel> getUserById(String uid) async
{
  DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection("UserDetail").doc(uid).get();
  UserModel userModel= UserModel.fromMap(snapshot.data() as Map<String,dynamic>);
  return userModel;
}

Future<PostModel> getPostModelById(String id)async
{
  DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection("PostDetail").doc(id).get();
  PostModel postModel= PostModel.fromMap(snapshot.data() as Map<String,dynamic>);
  return postModel;


}

FollowUser(UserModel model) async
{

  String id= FirebaseAuth.instance.currentUser!.uid!;

  if(model.followers!.contains(id))
  {
    model.followers!.remove(id);
    await FirebaseFirestore.instance.collection("UserDetail").doc(model!.uid).update(model.toMap());
    log("unfollow");

    await FirebaseFirestore.instance.collection("UserDetail").doc(id).update({
      "following": FieldValue.arrayRemove([model.uid])
    });
    print("update value");
    return "follow";

  }
  else{
    model.followers!.add(id);
    await FirebaseFirestore.instance.collection("UserDetail").doc(model!.uid).update(model.toMap());
    log("unfollow");


    await FirebaseFirestore.instance.collection("UserDetail").doc(id).update({
      "following": FieldValue.arrayUnion([model.uid])
    });
    print("update value");





    return "unfollow";
  }

}
savePostHistory(UserModel userModel, PostModel postModel) async
{


  DocumentSnapshot snap = await FirebaseFirestore.instance
      .collection("UserDetail").doc(userModel.uid).get();
  Map<String, dynamic> detail = snap.data() as Map<
      String,
      dynamic>;

  List<String> viewHistory =List<String>.from(detail["viewHistory"] ?? []);
  if(viewHistory.contains(postModel.postId))
    {
      viewHistory.remove(postModel.postId);
    }
  viewHistory.add(postModel!.postId!);
  FirebaseFirestore.instance.collection("UserDetail").doc(
      userModel.uid).update(
      {
        "viewHistory": viewHistory
      }

  );

}
