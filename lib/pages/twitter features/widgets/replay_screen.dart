import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/twitter%20features/Model/TweetModel.dart';
import 'package:c_box/pages/twitter%20features/sevices/tweet_controller.dart';
import 'package:c_box/pages/twitter%20features/widgets/tweet_Card.dart';
import 'package:c_box/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReplayScreen extends StatefulWidget {
  final UserModel userModel;
  final Tweet tweet;
  const ReplayScreen({super.key, required this.userModel, required this.tweet});

  @override
  State<ReplayScreen> createState() => _ReplayScreenState();
}

class _ReplayScreenState extends State<ReplayScreen> {
  final  reTweetController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);


          },
          icon: Icon(Icons.arrow_back),

        ),
        elevation: 2,
          shadowColor: Colors.black,
        title: Text("tweet"),
      ),
      body:
        Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TweetCard(isMain: true,tweet:widget.tweet, userModel:widget.userModel),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              Expanded(

                  child:StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Tweets").doc(widget.tweet!.tweetId!)
                        .collection("ReTweets").snapshots(),
                    builder: (context, snapshot)
                    {
                      if(snapshot.connectionState == ConnectionState.active)
                        {
                          QuerySnapshot  qSnap = snapshot.data as QuerySnapshot;
                          return ListView.builder(
                              itemCount: qSnap.docs.length,
                              itemBuilder: (context,index){
                                Tweet tweet= Tweet.formMap(qSnap.docs[index].data() as  Map<String,dynamic> );

                                return TweetCard(isMain: false,tweet: tweet, userModel: widget.userModel,);

                              });

                        }else{
                        return Text("loading...");
                      }

                    }
                  ) ),


              Row(
                children: [
                  Expanded
                    (
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:Border.all(
                              width: 1,
                              color: Colors.black87
                          ),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: reTweetController,
                          decoration: InputDecoration(
                              hintText: "replay",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                      ),
                    ),

                  ),
                  IconButton(onPressed: ()async{

                    TweetController tweetObj= TweetController();
                    tweetObj.reTweetOnMainTweet(mainTweet: widget.tweet, text: reTweetController.text.trim(),
                        userModel: widget.userModel, context: context);

                    if(tweetObj.clear == true)
                      {
                        setState(() {
                          reTweetController.clear();

                        });
                      }

                  }, icon: Icon(Icons.send))
                ],
              ),

              SizedBox(height: 10,)

            ],
          ),

      ),

    );

  }
}
