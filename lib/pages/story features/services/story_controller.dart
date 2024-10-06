import 'dart:io';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/navigation_bar/navigation_bar.dart';
import 'package:c_box/pages/story%20features/model/story.dart';
import 'package:c_box/pages/story%20features/model/storyModel.dart';
import 'package:c_box/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StatusController {
  // Upload status
  void uploadStatus({
    required File file,
    required String caption,
    required UserModel userModel,
    required BuildContext context,
  }) async {
    try {
      showLoading(context);

      String id = Uuid().v1();
      List<String> whoCanSee = [];
      whoCanSee.addAll(userModel.following as Iterable<String>);
      whoCanSee.addAll(userModel.followers as Iterable<String>);
      whoCanSee = whoCanSee.toSet().toList(); // remove duplicates

      String url = await _uploadFile(file, id);
      StatusItem newItem = StatusItem(
        caption: caption,
        url: url,
        time: DateTime.now(),
        seenUser: [],
      );

      List<String> statusUrl = [];
      if (url != "error") {
        // Fetch the existing status
        var snapshot = await FirebaseFirestore.instance
            .collection("Status")
            .where("uid", isEqualTo: userModel.uid)
            .get();

        if (snapshot.docs.isNotEmpty) {
          // Existing status found, append new data
          Status existingStatus = Status.fromMap(snapshot.docs[0].data() as Map<String, dynamic>);
          statusUrl = existingStatus.statusUrl;
          List<Map<String, dynamic>> existingItems = existingStatus.items;

          // Add new status data to existing lists
          statusUrl.add(url);
          existingItems.add(newItem.toMap());

          // Update the existing document with the new status item and URL
          await FirebaseFirestore.instance
              .collection("Status")
              .doc(existingStatus.uid)
              .update({
            "statusUrl": statusUrl,
            "items": existingItems,
            "whoCanSee": whoCanSee,
            "profilePic": userModel.profilePic,
          });
        } else {
          // If no existing status, create a new status
          statusUrl = [url];

          Status newStatus = Status(
            caption: caption,
            uid: userModel.uid!,
            userName: userModel.userName!,
            items: [newItem.toMap()],
            profilePic: userModel.profilePic!,
            statusUrl: statusUrl,
            whoCanSee: whoCanSee,
          );

          // Save the new status to Firestore
          await FirebaseFirestore.instance
              .collection("Status")
              .doc(newStatus.uid)
              .set(newStatus.toMap());
        }
        // DocumentSnapshot snap =  await FirebaseFirestore.instance.collection("History").doc(userModel.uid!).get();
        //
        // Map<String,dynamic> map = snap.data() as Map<String,dynamic>;
        // List<Map<String,dynamic>> statusList= map["statusHistory"] ?? [] ;
        // statusList.add(newItem.toMap());
        // FirebaseFirestore.instance.collection("History").doc(userModel.uid!).set({
        //   "uid":userModel.uid,
        //   "statusHistory": FieldValue.arrayUnion(statusList)
        // });
        //
        Map<String, dynamic> item = newItem.toMap();
        item["type"] = "status";
        item["uid"]= FirebaseAuth.instance.currentUser!.uid!.toString();

        FirebaseFirestore.instance.collection("History").add(item);

        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Navigation_Bar(userModel: userModel)),
        );
      } else {
        showUpdate("Something went wrong", context);
      }
    } catch (er) {
      showUpdate(er.toString(), context);
    }
  }


  // Upload the file to Firebase Storage
  Future<String> _uploadFile(File file, String id) async {
    try {
      String url = "";
      Reference reference = FirebaseStorage.instance.ref().child("Status/$id");
      UploadTask uploadTask = reference.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      url = await snapshot.ref.getDownloadURL();

      print(url);
      return url;
    } catch (er) {
      return "error";
    }
  }


  Future<List<Status>> getStatus({
    required BuildContext context,
    required UserModel userModel,
  }) async {
    final List<Status> statusList = [];

    try {
      List<String> following = userModel.following!;
      for (int i = 0; i < following.length; i++) {
        print(following[i]);
        var statusSnapshot = await FirebaseFirestore.instance
            .collection("Status")
            .where("uid", isEqualTo: following[i])
            .get();

        for (var tempStatus in statusSnapshot.docs) {
          Status status =
          Status.fromMap(tempStatus.data() as Map<String, dynamic>);
          print(status.userName);
          // Filter out status items older than 24 hours
          List<Map<String, dynamic>> validItems = status.items.where((item) {
            StatusItem sitem = StatusItem.fromMap(item);
            return sitem.time!
                .isAfter(DateTime.now().subtract(Duration(hours: 24)));
          }).toList();

          // If there are expired items, update Firestore with the new filtered list
          if (validItems.length != status.items.length) {
            await FirebaseFirestore.instance
                .collection("Status")
                .doc(status.uid)
                .update({
              "items": validItems,
            });
          }

          status.items = validItems;

          // Add to statusList if the user can see the status
          if(status.items.length >0) {
            statusList.add(status);
          }
        }
      }
    } catch (er) {
      print(er.toString());
    }

    return statusList;
  }
  Future<List<StatusItem>> getSelfStatus(UserModel userModel)async{
    List<StatusItem> status=[];
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Status").doc(userModel.uid).get();
    Status item = Status.fromMap(snapshot.data() as Map<String, dynamic>);
    List<Map<String,dynamic>> map = item.items;
    for(Map<String,dynamic> mp in map )
      {
        StatusItem statusItem = StatusItem.fromMap(mp);
        status.add(statusItem);
      }

    return status;
  }
  Future<Status> getSelfStatusItem(UserModel userModel)async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Status").doc(userModel.uid).get();
    Status item = Status.fromMap(snapshot.data() as Map<String, dynamic>);
    return item;
  }

}
