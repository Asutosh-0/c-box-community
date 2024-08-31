
import 'dart:core';
import 'dart:core';
import 'dart:io';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/twitter%20features/Model/TweetModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../../../utils.dart';

class TweetController {
  bool clear = false;
  void shareTweet({
    required List<File> images,
     required  String text,
    required UserModel userModel,
    required BuildContext context})
  {
    if(text.isEmpty)
      {
        showUpdate("plesed enter text", context);
        return;
      }
    if(images.isNotEmpty)
    {
      _shareImageTweet(images: images, text: text, userModel: userModel, context: context);

    }
    else
      {
        _shareTextTweet(userModel: userModel, text: text, context: context);

      }
    clear= true;

  }
  void reTweetOnMainTweet({
    required Tweet mainTweet,
    required  String text,
    required UserModel userModel,
    required BuildContext context}) async
  {
    try {
      //code
      showLoading(context);
      final hashTags = _getHashTagsFromText(text);
      String link = _getLinkFromText(text);
      String tweetId = Uuid().v1();
      String time = DateTime
          .now()
          .toString();
      Tweet tweet = Tweet(
          text: text,
          hashTags: hashTags,
          link: link,
          profilePic: userModel.profilePic,
          imageLinks: [],
          uid: userModel.uid,
          userName: userModel.userName,
          tweetId: tweetId,
          likes: [],
          tweetType: TweetType.text,
          tweetedAt: time,
          reTweetedBy: "",
          reshareCount: 0);

      await FirebaseFirestore.instance.collection("Tweets").doc(mainTweet.tweetId).collection("ReTweets").doc(tweetId).set(
          tweet.toMap());
      int count = mainTweet.reshareCount! as int;
      await FirebaseFirestore.instance.collection("Tweets").doc(mainTweet.tweetId).update({
        "reshareCount": count +1
      });
      Navigator.pop(context);
      showUpdate("reTweet successfully", context);
      clear = true;
      return;
    }
    catch(er)
    {

      showUpdate("${er.toString()}", context);

      return;
    }



  }

  _shareImageTweet({
    required List<File> images,
    required String text,
    required UserModel userModel,
    required BuildContext context
})async{
    // code
    try {
      //code
      showLoading(context);
      final hashTags = _getHashTagsFromText(text);
      String link = _getLinkFromText(text);
      String tweetId = Uuid().v1();
      String time = DateTime
          .now()
          .toString();


      List<String> imagesUrl = await _UploadListOfFile(images, context);

      Tweet tweet = Tweet(
          text: text,
          hashTags: hashTags,
          link: link,
          profilePic: userModel.profilePic,
          imageLinks: imagesUrl,
          uid: userModel.uid,
          userName: userModel.userName,
          tweetId: tweetId,
          likes: [],
          tweetType: TweetType.image,
          tweetedAt: time,
          reTweetedBy: "",
          reshareCount: 0);

      await FirebaseFirestore.instance.collection("Tweets").doc(tweetId).set(
          tweet.toMap());
      Navigator.pop(context);
      showUpdate("tweet successfully", context);
      return;
    }
    catch(er)
    {
      showUpdate("${er.toString()}", context);
      return;
    }

  }
  _shareTextTweet({
    required UserModel userModel,
    required String text,
    required BuildContext context
})async
  {
    try {
      //code
      showLoading(context);
      final hashTags = _getHashTagsFromText(text);
      String link = _getLinkFromText(text);
      String tweetId = Uuid().v1();
      String time = DateTime
          .now()
          .toString();
      Tweet tweet = Tweet(
          text: text,
          hashTags: hashTags,
          link: link,
          profilePic: userModel.profilePic,
          imageLinks: [],
          uid: userModel.uid,
          userName: userModel.userName,
          tweetId: tweetId,
          likes: [],
          tweetType: TweetType.text,
          tweetedAt: time,
          reTweetedBy: "",
          reshareCount: 0);

      await FirebaseFirestore.instance.collection("Tweets").doc(tweetId).set(
          tweet.toMap());
      Navigator.pop(context);
      showUpdate("tweet successfully", context);
      return;
    }
    catch(er)
    {
      showUpdate("${er.toString()}", context);
      return;
    }
  }
  // get link from text
   String _getLinkFromText(String text)
   {
     // rinku is a good boy www.google.com
     // [rinku, is , a , good ,boy, www.google.com]

     String link= "";
     List<String> WordINSentences = text.split(" ");
     for (String word in WordINSentences)
       {
         if(word.startsWith("https://") || word.startsWith("www.")){
           link = word;
         }
       }

     return link;
   }

   // get all hashTag
List<String> _getHashTagsFromText(String text)
{
  List<String> HashTag = [];
  List<String> WordINSentences = text.split(" ");
  for (String word in WordINSentences)
  {
    if(word.startsWith("#")){
       HashTag.add(word);
    }
  }
  return HashTag;
}
// upload list of images
Future<List<String>> _UploadListOfFile(List<File> images,BuildContext context)async{
    List<String> filesUrl = [];
    for(File file in images)
      {
        String id = Uuid().v1();
        String url = await  _UploadFile(file, id);
        if(url != "error")
          {
            filesUrl.add(url);
          }
        else
        {
          showUpdate("something wrong", context);
          return filesUrl;
        }
      }

    return filesUrl;


}

Future<String> _UploadFile(File file,String id) async
{
  try {
    String url = "";
    Reference reference = FirebaseStorage.instance.ref().child("TweetMedia/$id");
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

}