import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TweetLikeController{

  void LikeTweet(String id) async
  {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Tweets").doc(id).get();
    var uid= FirebaseAuth.instance.currentUser!.uid!;


    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;

    if(map["likes"].contains(uid)){
      await FirebaseFirestore.instance.collection("Tweets").doc(id).update({
        "likes": FieldValue.arrayRemove([uid])
      });
    }
    else

    {
      await FirebaseFirestore.instance.collection("Tweets").doc(id).update({
        "likes":FieldValue.arrayUnion([uid])
      });
    }

  }
}