import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/twitter%20features/Model/TweetModel.dart';
import 'package:c_box/pages/twitter%20features/widgets/tweet_Card.dart';
import 'package:c_box/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TweetsDisplayScreen extends StatelessWidget {
  final UserModel userModel;
  const TweetsDisplayScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Tweets").orderBy("tweetedAt",descending: true).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active)
          {
            QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
            return ListView.builder(
              itemCount:  querySnapshot.docs.length,
                itemBuilder: (context,index){
                Tweet tweet = Tweet.formMap(querySnapshot.docs[index].data() as Map<String,dynamic>);
                  return TweetCard(isMain: true,userModel:userModel,tweet: tweet,);

                });

          }
        else{

          return Center(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("loading.."),
                SizedBox(width: 10,),
                SizedBox(
                  width: 25, // Adjust the width to reduce the size
                  height: 25, // Adjust the height to reduce the size
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 2.0,
                  ),
                ),

              ],
            ),
          );

        }


      }
    );
  }
}
