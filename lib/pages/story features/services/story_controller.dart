import 'dart:io';

import 'package:c_box/models/user_model.dart';
import 'package:c_box/navigation_bar/navigation_bar.dart';
import 'package:c_box/pages/story%20features/model/storyModel.dart';
import 'package:c_box/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class StatusController{

  void uploadStatus({
    required  File file,
    required String caption,
    required UserModel userModel,
    required BuildContext context
}) async
  {
    try{
      var statusId= Uuid().v1();
      String id = Uuid().v1();
      List<String> whoCanSee =[];
      whoCanSee.addAll(userModel.following as Iterable<String>);
      whoCanSee.addAll(userModel.followers as Iterable<String>);
      whoCanSee = whoCanSee.toSet().toList(); // remove the dublicate data

      String url = await  _UploadFile(file, id);

      List<String> statusUrl=[];
      if(url != "error")
      {
        showLoading(context);
        // featch the existing status
        var snapshot= await FirebaseFirestore.instance.collection("Status").where("uid", isEqualTo: userModel.uid).get();
        if(snapshot.docs.isNotEmpty)
          {
            Status status = Status.fromMap(snapshot.docs[0].data() as Map<String,dynamic>);
            statusUrl = status.statusUrl;
            statusUrl.add(url);
            await FirebaseFirestore.instance.collection("Status").doc(status.statusId).update({
              "statusUrl":statusUrl
            });
            Navigator.pop(context);
            return;
          }
        else{
          statusUrl =[ url];
        }
        Status status = Status(
            caption: caption,
            statusId: statusId,
            uid: userModel.uid!,
            userName: userModel.userName!,
            profilePic: userModel.profilePic!,
            statusUrl: statusUrl,
            createdAt: DateTime.now(),
            whoCanSee: whoCanSee);
        await FirebaseFirestore.instance.collection("Status").doc(status.statusId).set(status.toMap());

        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Navigation_Bar(userModel: userModel) ));
      }
      else
      {
        showUpdate("something wrong", context);
      }



    }
    catch(er)
    {
      showUpdate(er.toString(), context);
    }

  }

  Future<String> _UploadFile(File file,String id) async
  {
    try {
      String url = "";
      Reference reference = FirebaseStorage.instance.ref().child("Status/$id");
      UploadTask uploadTask = reference.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      url = await snapshot.ref.getDownloadURL();

      print(url);
      return url;
    }
    catch(er)
    {
      return "error";
    }
  }


  Future<List<Status>> getStatus({
    required BuildContext context,
    required UserModel userModel
  }) async
  {
    final List<Status>  statusList = [];

    try{
      List<String> following= userModel.following!;
      for(int i =0; i < following.length ;i++)
        {
         var StatusSnapshot = await FirebaseFirestore.instance.collection("Status")
             .where("uid",isEqualTo:following[i] )
             .where("createdAt",isGreaterThan: DateTime.now().subtract( Duration(hours: 24)).millisecondsSinceEpoch)
             .get();
         for(var tempStatus in StatusSnapshot.docs)
           {
             Status status = Status.fromMap(tempStatus.data() as Map<String,dynamic>);

             if(status.whoCanSee.contains(userModel.uid))
               {
                 statusList.add(status);

               }
           }

        }


    }
    catch(er)
    {
      // showUpdate(er.toString(), context);
      print(er.toString());
    }

    return statusList;

  }
}