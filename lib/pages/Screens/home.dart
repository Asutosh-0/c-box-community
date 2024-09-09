import 'dart:io';

import 'package:c_box/models/PostModel.dart';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/Screens/profile.dart';
import 'package:c_box/pages/chatting/ChatShowScreen.dart';
import 'package:c_box/pages/pages/commentPage.dart';
import 'package:c_box/pages/story%20features/model/storyModel.dart';
import 'package:c_box/pages/story%20features/services/story_controller.dart';
import 'package:c_box/pages/story%20features/widget/select_status_screen.dart';
import 'package:c_box/pages/story%20features/widget/status_screen.dart';
import 'package:c_box/services/postServices.dart';
import 'package:c_box/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import '../chatting/model/ChatRoomModel.dart';

class Home extends StatefulWidget {
  final UserModel userModel;
  const Home({super.key, required this.userModel});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {

  final List<Map<String, dynamic>> searchUsers = [
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/03/15/17/07/girl-1258727_640.jpg',
      'username': 'johndoe',
      'fullName': 'John Doe',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2017/09/26/17/34/ballet-2789416_640.jpg',
      'username': 'janedoe',
      'fullName': 'Jane Doe',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2019/05/28/05/06/female-4234344_640.jpg',
      'username': 'mikebrown',
      'fullName': 'Mike Brown',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/10/20/08/36/woman-1754895_640.jpg',
      'username': 'emilyjones',
      'fullName': 'Emily Jones',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2019/07/25/10/43/ballerina-4362282_640.jpg',
      'username': 'alexsmith',
      'fullName': 'Alex Smith',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/03/15/17/07/girl-1258727_640.jpg',
      'username': 'sarahwilliams',
      'fullName': 'Sarah Williams',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/07/08/23/17/girl-1505407_640.jpg',
      'username': 'davidlee',
      'fullName': 'David Lee',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2023/01/01/16/35/street-7690347_640.jpg',
      'username': 'laurajohnson',
      'fullName': 'Laura Johnson',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/10/20/08/36/woman-1754895_640.jpg',
      'username': 'emilyjones',
      'fullName': 'Emily Jones',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2019/07/25/10/43/ballerina-4362282_640.jpg',
      'username': 'alexsmith',
      'fullName': 'Alex Smith',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/03/15/17/07/girl-1258727_640.jpg',
      'username': 'sarahwilliams',
      'fullName': 'Sarah Williams',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/07/08/23/17/girl-1505407_640.jpg',
      'username': 'davidlee',
      'fullName': 'David Lee',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2023/01/01/16/35/street-7690347_640.jpg',
      'username': 'laurajohnson',
      'fullName': 'Laura Johnson',
    },
  ];

  Future<List<PostModel>> fetchPrioritizedPosts() async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.userModel.uid).get();
    final List<String> following = List<String>.from(userDoc['following'] ?? []);

    // Fetch all posts
    final querySnapshot = await FirebaseFirestore.instance.collection("PostDetail").get();
    final posts = querySnapshot.docs.map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>)).toList();

    // Sort posts based on algorithm
    posts.sort((a, b) {
      int scoreA = 0;
      int scoreB = 0;

      // Recency (more recent posts get a lower score)
      // scoreA += DateTime.now().difference(a.timestamp).inMinutes;
      // scoreB += DateTime.now().difference(b.timestamp).inMinutes;

      // Engagement (more likes and comments get a lower score)
      scoreA -= (a.likes?.length ?? 0) * 10 + (a.commentCount ?? 0) * 5;
      scoreB -= (b.likes?.length ?? 0) * 10 + (b.commentCount ?? 0) * 5;

      // Relationship (posts from followed users get a lower score)
      if (following.contains(a.uid)) scoreA -= 50;
      if (following.contains(b.uid)) scoreB -= 50;

      return scoreA.compareTo(scoreB);
    });

    // Shuffle some posts to introduce randomness
    posts.shuffle(Random());

    return posts;
  }
  @override
  Widget build(BuildContext context) {
    // var Size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 5,
        backgroundColor: Colors.purple[50],
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child:
          Container(
            padding: EdgeInsets.all(3.0),
              width: 25,
              height: 25,
              child: Image.asset("assets/c_box.png",fit: BoxFit.cover,)
          ),
          // Material(
          //   borderRadius: BorderRadius.circular(6),
          //   child: Image.asset('assets/c_box.png'),
          // ),
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "C-Box",
              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
            ),
            Text(
              "community",
              style: TextStyle(
                fontSize: 11,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [

          const SizedBox(width: 10),

          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatShowScreen(userModel: widget.userModel) ));
          }, icon: Icon(Icons.message_outlined)),


          SizedBox(width: 10),
          IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt)),
          SizedBox(width: 10,),

          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(userModel: widget.userModel) ));
            },
            child: Container(
              width: 35,
              height: 35,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17.5)),

              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
                backgroundImage: widget.userModel.profilePic != null
                    ? NetworkImage(widget.userModel.profilePic!)
                    : AssetImage('assets/c_box.png'),
                child: widget.userModel.profilePic == null
                    ? Icon(Icons.person)
                    : null,
              ),
            ),
          ),

          SizedBox(width: 20,)
        ],
        // bottom:
      ),
      body: Center(

        child: SizedBox(
          width: 600,
          child :

          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  PreferredSize(
                    preferredSize: Size.fromHeight(95),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                width: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async{
                                          // select the status
                                          XFile? _file = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if(_file!= null)
                                            {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context)=>SelectStatusScreen(file: File(_file.path,),userModel: widget.userModel,) ));
                                            }
            
                                        },
                                        child: Container(
                                            width: 55,
                                            height: 55,
                                            padding: EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(27.5)),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
                                              backgroundImage: widget.userModel.profilePic != null
                                                  ? NetworkImage(widget.userModel.profilePic!)
                                                  : null,
                                              child: widget.userModel.profilePic == null
                                                  ? Icon(Icons.person)
                                                  : null,
            
                                            )
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          "your story",
                                          maxLines: 1,
                                          style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 44,
                                left: 44,
                                child: Icon(Icons.add_circle),
                              )
                            ],
                          ),
                        ),
            
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
            
                              height: 100,
                              color: Colors.purple[30],
                              child: FutureBuilder<List<Status>>(
                                future: StatusController().getStatus(
                                    context: context,
                                    userModel: widget.userModel
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: Text(
                                        "Loading...",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    );
                                  }

                                  // Check if the snapshot has data
                                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Center(
                                      child: Text(
                                        "No status available.",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    );
                                  }

                                  // Check for errors
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        "Error: ${snapshot.error}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      Status status = snapshot.data![index];

                                      return Container(
                                        width: 70,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
                                                  backgroundImage: status.profilePic != null
                                                      ? NetworkImage(status.profilePic!)
                                                      : null,
                                                  child: status.profilePic == null
                                                      ? Icon(Icons.person)
                                                      : null,
                                                  radius: 25,
                                                ),
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StatusScreen(status: status) ));
                                                },
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                status.uid == widget.userModel.uid ? "me" : status.userName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              )

                            ),
                          ),
                        ),
            
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Expanded(
                    child: StreamBuilder(
            
                        stream: FirebaseFirestore.instance.collection("PostDetail").orderBy("postUrl").snapshots(),
                    // FutureBuilder<List<PostModel>>(
                    //     future: fetchPrioritizedPosts(),
                        builder: (context, snapshot) {
            
            
                          if(snapshot.connectionState == ConnectionState.active)
                          {
                            if(snapshot.hasData)
                            {
                              var qsnap = snapshot.data as QuerySnapshot;
                              return ListView.builder(
            
                                  itemCount: qsnap.docs.length,
                                  itemBuilder:
                                      (context, index) {
                                    DocumentSnapshot dSnap = qsnap.docs[index] as DocumentSnapshot;
                                    PostModel postModel = PostModel.fromMap(
                                        dSnap.data() as Map<String, dynamic>);
            
                                    return Padding(
                                      padding: const EdgeInsets.all(8.6),
                                      child: SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        child: Column(
                                          children: [
            
            
                                            TopBar(postModel: postModel,selfUser: widget.userModel,),
            
                                            if(postModel.isVideo==true )
                                              PostVideo(showVideo: postModel),
            
                                            if(postModel.isVideo == false)
                                            PostBar(postModel: postModel),
            
                                            const SizedBox(height: 15),
            
                                            // Bottom
                                            ButtomBar(postModel:postModel,userModel: widget.userModel!)
            
                                          ],
                                        ),
                                      ),
                                    );
                                  }
            
            
                              );
            
                            }
                            else if(snapshot.hasError)
                            {
                              return Center(
                                child: Text("Check Internet"),
                              );
            
                            }
                            else{
                              return Center(
                                child: Text("Check Internet"),
                              );
                            }
            
                          }
                          else
                          {
                            return Center(
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
                  ),
                ],
              ),
            ),
          ),
          ),
        ),

    );
  }
}


class TopBar extends StatefulWidget {
  final UserModel selfUser;
  final PostModel postModel;
  const TopBar({super.key, required this.postModel, required this.selfUser});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  UserModel? model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getModel();
  }
  getModel()async{
    model = await getUserById(widget.postModel.uid!);
  }

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: InkWell(
        onTap: (){
          if(model != null) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Profile(userModel: model!,selfUser: widget.selfUser,)));
          }
        },
        child: CircleAvatar(
          radius: 18,
          backgroundImage: widget.postModel
              .profilePic != null
              ? NetworkImage(
              widget.postModel.profilePic!)
              : null, // profile image url
          child: widget.postModel.profilePic ==
              null
              ? Icon(Icons.person_outline)
              : null,
        ),
      ),
      title: Text(widget.postModel.userName!),
      // subtitle: Text(postModel.),
      trailing: const Icon(Icons.menu),
    ) ;
  }
}

class PostBar extends StatelessWidget {
  final PostModel postModel;
  const PostBar({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.50,
      child: Image(
        image: NetworkImage(
            postModel.postUrl!),
        fit: BoxFit.cover,
      ),
    );
  }
}
class PostVideo extends StatefulWidget {
  final PostModel showVideo;
  const PostVideo({super.key, required this.showVideo});

  @override
  State<PostVideo> createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo> {
  VideoPlayerController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.showVideo.postUrl != null) {
      _controller = VideoPlayerController.network(widget.showVideo.postUrl!)
        ..initialize().then((_) {
          setState(() {
            _controller?.play();
          });
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  _controller != null && _controller!.value.isInitialized ?
        Container(
          height: MediaQuery.of(context).size.height*0.6,
        child: Center(
          child: InkWell(
            onTap: () {
              setState(() {
                _controller!.value.isPlaying
                    ? _controller!.pause()
                    : _controller!.play();
              });
            },
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
          ),
        ),
      )
          : Container(
      height: MediaQuery.of(context).size.height*0.5,
            child: Center(
                    child: CircularProgressIndicator(),),
          );

  }
}


class ButtomBar extends StatelessWidget {
  final PostModel postModel;
  final UserModel userModel;
  const ButtomBar({super.key, required this.postModel, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child:Column(
        children: [
          Container(
            height: 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: LikeButton(

                    size: 20,
                    onTap: (isLike)async{
                      LikePost(postModel.postId!);
                      // function
                      return !isLike;
                    },

                    likeBuilder: (islike)
                    {
                      return islike ? Icon(Icons.favorite,color: Colors.red,):
                      Icon(Icons.favorite_outline,color: Colors.black,) ;
                    },
                    // likeCount: postModel.likes!.length!,
                    // countPostion: CountPostion.bottom,

                    isLiked:postModel.likes!.contains(userModel.uid) ,
                    countBuilder: (linkCount,isLike,text){
                      return Text(text,style: TextStyle(color: Colors.black),);

                    },
                  ),
                ),
                // IconButton(
                //   icon: Icon(
                //      postModel.likes!.contains(userModel.uid) ? Icons.favorite : Icons.favorite_outline,
                //       color: postModel.likes!.contains(userModel.uid) ? Colors.red: Colors
                //           .black54),
                //   onPressed: () async {
                //     print(
                //         'Favorite clicked at index ');
                //     LikePost(postModel.postId!);
                //   },
                // ),
                SizedBox(width: 4,),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: IconButton(
                    icon: Icon(
                      size: 20,
                        Icons.comment_outlined,
                        color: Colors
                            .black),
                    onPressed: () {
                      print(
                          'Comment clicked at index ');
                      Navigator.push(context,
                        MaterialPageRoute(builder: (
                                context) =>CommentPage(userModel: userModel, postModel: postModel)),
                      );
                    },
                  ),
                ),
                SizedBox(width: 5),
                IconButton(
                  icon: Icon(
                    size: 20,
                      Icons.send_outlined,
                      color: Colors
                          .black),
                  onPressed: () {
                    print(
                        'Send clicked at index ');
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: [
                    Text("${postModel.likes!
                        .length!} likes",
                        style: TextStyle(

                            fontSize: 13)),
                    Container(
                      child: Text(
                        "${postModel.caption}",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                IconButton(
                  onPressed: () {
                    print(
                        'Save clicked at index ');
                  },
                  icon: Icon(Icons
                      .save_alt_outlined),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],

      ),
    );
  }
}
