import 'package:c_box/models/PostModel.dart';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/Screens/profile.dart';
import 'package:c_box/pages/chatting/ChatShowScreen.dart';
import 'package:c_box/pages/commentPage.dart';
import 'package:c_box/services/postServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

          IconButton(onPressed: (){}, icon: Icon(Icons.notification_add)),

          const SizedBox(width: 10),

          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatShowScreen(userModel: widget.userModel) ));
          }, icon: Icon(Icons.message_outlined)),


          SizedBox(width: 10),
          IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt)),
          SizedBox(width: 10,)
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(95),
          child: Container(
            height: 100,
            color: Colors.purple[30],
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Scroll horizontally
              itemCount: searchUsers.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> user = searchUsers[index];
                return Container(
                  width: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(user['profileImageUrl']),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user["username"],
                          maxLines: 1,
                          style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          child : StreamBuilder(

              stream: FirebaseFirestore.instance.collection("PostDetail").snapshots(),
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
              children: [
                IconButton(
                  icon: Icon(
                     postModel.likes!.contains(userModel.uid) ? Icons.favorite : Icons.favorite_outline,
                      color: postModel.likes!.contains(userModel.uid) ? Colors.red: Colors
                          .black54),
                  onPressed: () async {
                    print(
                        'Favorite clicked at index ');
                    LikePost(postModel.postId!);
                  },
                ),
                SizedBox(width: 5),
                IconButton(
                  icon: Icon(
                      Icons.comment_outlined,
                      color: Colors
                          .black54),
                  onPressed: () {
                    print(
                        'Comment clicked at index ');
                    Navigator.push(context,
                      MaterialPageRoute(builder: (
                              context) =>CommentPage(userModel: userModel, postModel: postModel)),
                    );
                  },
                ),
                SizedBox(width: 5),
                IconButton(
                  icon: Icon(
                      Icons.send_outlined,
                      color: Colors
                          .black54),
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
