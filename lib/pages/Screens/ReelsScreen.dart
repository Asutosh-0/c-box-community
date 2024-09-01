import 'package:c_box/models/PostModel.dart';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/pages/ReelsPlayer_item.dart';
import 'package:c_box/pages/widgets/CircleAnimation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../../services/postServices.dart';
import '../pages/commentPage.dart';

class ReelsScreen extends StatefulWidget {
  final UserModel userModel;
  const ReelsScreen({super.key, required this.userModel});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {



  builldProfile(String profilePic)
  {
    return Container(
      width: 50,
      height: 50,
      color: Colors.transparent,

      child: Stack(
        children: [
          Positioned(left: 5,
            child:
            Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
                child: Image(image: NetworkImage(profilePic),fit: BoxFit.cover,)),
          ), )
        ],
      ),
    );
  }
  buildMusicAlbum(String profilePic)
  {
    return SizedBox(
      width: 50,
      height: 50,
      child: Column(
        children: [
          Container(padding: EdgeInsets.all(11),
              height: 40,
              width: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey,
              Colors.white]
            ),
            borderRadius: BorderRadius.circular(20)
          ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(image: NetworkImage(profilePic),fit: BoxFit.cover,),
            ),
          
          )
        ],
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(onPressed: (){

            print("date ${DateTime.now().toString()}");

          }, icon: Icon(Icons.camera_alt_outlined,color: Colors.white,size: 25,)),
          SizedBox(width: 20,)
        ],
      ),
      body:
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection("PostDetail").where("isVideo",isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active)
            {
              QuerySnapshot qsnap = snapshot.data as QuerySnapshot;

              return PageView.builder(
                  itemCount: qsnap.docs.length,
                  controller: PageController(initialPage: 0,viewportFraction: 1),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){

                    PostModel postModel = PostModel.fromMap(qsnap.docs[index].data() as Map<String,dynamic>);
                    return Stack(
                      children: [
                        // ReelsPlayerItem(videoUrl:  "https://firebasestorage.googleapis.com/v0/b/c-box-community.appspot.com/o/Media%2F2c6663e0-572c-11ef-94ad-2b7bd26ab166?alt=media&token=691a8d59-c79b-4da0-a581-5597a37b7caa"),

                        ReelsPlayerItem(videoUrl: postModel.postUrl!),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(

                              height: 100,
                            ),
                            Expanded(child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                    child:Container(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("${postModel.userName}",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                                          Text("${postModel.caption}",style: TextStyle(fontSize: 14,color: Colors.white,),),
                                          Row(
                                            children: [
                                              Icon(Icons.music_note,size: 13,color: Colors.white,),
                                              Text("songName",style:TextStyle(fontSize: 13,color: Colors.white,))
                                            ],
                                          ),
                                          SizedBox(height: 20,)

                                        ],
                                      ),
                                    ) ),
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(top: size.height*0.3),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [


                                      builldProfile(postModel.profilePic!= null ? postModel.profilePic! :""),// profile pic
                                      IconButton(
                                        icon: Icon(
                                          size: 30,
                                            postModel.likes!.contains(widget.userModel.uid) ? Icons.favorite : Icons.favorite_outline,
                                            color: postModel.likes!.contains(widget.userModel.uid) ? Colors.red: Colors
                                                .white),
                                        onPressed: () async {
                                          print(
                                              'Favorite clicked at index ');
                                          LikePost(postModel.postId!);
                                        },
                                      ),
                                      Text("${postModel.likes!.length!} likes",style: TextStyle(fontSize: 14,color: Colors.white),),
                                      SizedBox(height: 7,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context,
                                            MaterialPageRoute(builder: (
                                                context) =>CommentPage(userModel: widget.userModel, postModel: postModel)),
                                          );

                                        },
                                        child: Icon(Icons.comment,
                                          size: 30,
                                          color: Colors.white,),
                                      ),
                                      Text("${postModel.commentCount}",style: TextStyle(fontSize: 15,color: Colors.white),),

                                      SizedBox(height: 7,),
                                      InkWell(
                                        onTap: (){

                                        },
                                        child: Icon(Icons.reply,
                                          size: 30,
                                          color: Colors.white,),
                                      ),
                                      Text("3",style: TextStyle(fontSize: 15,color: Colors.white),),

                                      SizedBox(height: 7,),
                                      CircleAnimation(child: buildMusicAlbum(postModel.profilePic!= null ? postModel.profilePic! :""
                                      )),
                                      SizedBox(height: 10,)


                                    ],
                                  ),
                                )
                              ],
                            )),


                          ],

                        )


                      ],
                    );

                  });

            }
          else
            {
             return   Center(
                child:SizedBox(
                  width: 25, // Adjust the width to reduce the size
                  height: 25, // Adjust the height to reduce the size
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 2.0,
                  ),
                ),
              );
            }

        }
      ),
    );
  }
}
