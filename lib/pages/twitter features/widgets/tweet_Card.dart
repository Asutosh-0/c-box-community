import 'package:any_link_preview/any_link_preview.dart';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/twitter%20features/Model/TweetModel.dart';
import 'package:c_box/pages/twitter%20features/sevices/re_tweet_controller.dart';
import 'package:c_box/pages/twitter%20features/sevices/tweet_like_controller.dart';
import 'package:c_box/pages/twitter%20features/widgets/carouse_image.dart';
import 'package:c_box/pages/twitter%20features/widgets/hashtag_text.dart';
import 'package:c_box/pages/twitter%20features/widgets/replay_screen.dart';
import 'package:c_box/pages/twitter%20features/widgets/tweet_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;
class TweetCard extends StatelessWidget {
   final bool isMain;
  final Tweet tweet;
  final UserModel userModel;
  TweetCard({super.key, required this.tweet, required this.userModel, required this.isMain});

   DateTime DateFormat(String time)
   {
     // final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
     
     DateTime date = DateTime.parse(time);
     return date;
     
   }
// Example Usage
  String formatTimeAgo(String time) {
    return timeago.format(DateFormat(time), locale: "en_short");
  }
  @override
  Widget build(BuildContext context) {

    String text= "#chandra People are looking for leaders \nThey want answers\n There ain't no answer\n There ain't going to be any answer \n There never has been an answer\n That's the answer \n www.google.com";

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child:  CircleAvatar(
                radius: 20,
                backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
                backgroundImage: tweet.profilePic!= null
                    ? NetworkImage(tweet.profilePic!)
                    : null,
                child: tweet.profilePic == null
                    ? Icon(Icons.person_outline_rounded)
                    : null,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  if(isMain == true) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ReplayScreen(userModel: userModel, tweet: tweet)));
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if(tweet.reTweetedBy!= "")
                    //  Row(
                    //    children: [
                    //      Text("by ${tweet.reTweetedBy}")
                    //    ],
                    //  ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text( "${tweet.userName}",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                          ),
                        ),

                        Text( "@${tweet.userName} . ${formatTimeAgo(tweet.tweetedAt!)}",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          color: Colors.grey

                        ),
                        ),

                      ],
                    ),
                    //
                    // replied to
                    HashtagText(text: tweet.text!),
                    if(tweet.tweetType == TweetType.image)
                    CarouseImage(imageLink: tweet.imageLinks!),
                    //
                    // if(tweet.link!.isNotEmpty)...[
                    //   const SizedBox(height: 4,),
                    //   AnyLinkPreview(link: "https://${tweet.link}"),
                    // ]
                    Container(
                      margin: EdgeInsets.only(top: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LikeButton(

                            size: 25,
                            onTap: (isLike)async{
                          TweetLikeController likeTweet= TweetLikeController();
                          likeTweet.LikeTweet(tweet.tweetId!);
                              // function
                              return !isLike;
                            },

                            likeBuilder: (islike)
                            {
                              return islike ? Icon(Icons.favorite,color: Colors.red,):
                              Icon(Icons.favorite_outline,color: Colors.black,) ;
                            },
                            isLiked: tweet.likes!.contains(userModel.uid),
                            likeCount: tweet.likes!.length,
                            countBuilder: (linkCount,isLike,text){
                              return Text(text,style: TextStyle(color: Colors.black),);

                            },
                          ),
                          // TweetIconButton(icon: Icon(Icons.favorite_outline), text: "0", onTap: (){
                          //
                          // }),
                          if(isMain == true)
                          TweetIconButton(icon: Icon(Icons.message_outlined), text: "${tweet.reshareCount}", onTap: (){

                          }),
                          // TweetIconButton(icon: Icon(Icons.repeat), text: "${tweet.reshareCount}", onTap: (){
                          //   // ReTweetController().ReTweetPost(userModel: userModel, mainTweet: tweet);

                          // }),
                          if(isMain == true)
                          TweetIconButton(icon: Icon(Icons.share_outlined), text: "0", onTap: (){

                          }),


                        ],
                      ),
                    )


                  ],
                ),
              ),
            ),
            SizedBox(width: 10,)
          ],
        )
      ],
    );
  }
}
