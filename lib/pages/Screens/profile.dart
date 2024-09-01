import 'package:c_box/main.dart';
import 'package:c_box/models/PostModel.dart';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/pages/EditProfilePage.dart';
import 'package:c_box/pages/pages/PostShowScreen.dart';
import 'package:c_box/pages/chatting/chat_screen.dart';

import 'package:c_box/services/postServices.dart';
import 'package:c_box/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';

import '../chatting/model/ChatRoomModel.dart';

class Profile extends StatefulWidget {
  UserModel? selfUser;
  final UserModel userModel;
   Profile({super.key, required this.userModel,this.selfUser});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  String? res;
  bool check= false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    if(check== false) {
      if (widget.userModel.followers!.contains(
          FirebaseAuth.instance.currentUser!.uid!)) {
        res = "unfollow";
      }
      else {
        res = "follow";
      }
      check =true;
    }
  }

  checkRes() async
  {
    String value =  await  FollowUser(widget.userModel!);
    res = value;

    // setState(() {
    // });


  }

  Future<ChatRoomModel> getChatRoomModel( ) async{
    ChatRoomModel? chatRoomModel;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("ChatRoom").where("participants.${widget.selfUser!.uid!}",isEqualTo: true).
    where("participants.${widget.userModel.uid!}",isEqualTo: true).get();

    if(querySnapshot.docs.length > 0)
    {
      Map<String,dynamic> map = querySnapshot.docs[0].data() as Map<String,dynamic>;
      ChatRoomModel existChatModel = ChatRoomModel.fromMap(map);
      chatRoomModel = existChatModel;
      print("exit user");
    }
    else
    {
      ChatRoomModel newChatModel = ChatRoomModel(
          chatroomid: Uuid().v1(),
          lastMessage: "",
          participants: {
            "${widget.selfUser!.uid!}" :true,
            "${widget.userModel.uid!}":true
          },
          lastTime: DateTime.now().millisecondsSinceEpoch.toString()

      );
      chatRoomModel = newChatModel;
      await FirebaseFirestore.instance.collection("ChatRoom").doc(newChatModel.chatroomid!).set(newChatModel.toMap());

      print("new user add successfully");
    }


    return chatRoomModel;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black,

        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert),
            onSelected: (int result) {
              // Handle the selected menu item
              switch (result) {
                case 0:
                // Do something for option 1
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginApp() ));
                  break;
                case 1:
                // Do something for option 2
                  break;
                case 2:
                // Do something for option 3
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Log out'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Option 2'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Option 3'),
              ),
            ],
          ),
        ],
        title: ListTile(
          leading: Icon(Icons.person_outline),
          title: Text(widget.userModel.userName!, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold), ),

        ),
      ) ,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top bar
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 14),
                    // Profile statistics
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: widget.userModel!.uid != FirebaseAuth.instance.currentUser!.uid!.toString() ? MainAxisAlignment.start :MainAxisAlignment.start ,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
                            backgroundImage: widget.userModel.profilePic != null
                                ? NetworkImage(widget.userModel.profilePic!)
                                : AssetImage('assets/c_box.png'),
                            child: widget.userModel.profilePic == null
                                ? Icon(Icons.person)
                                : null,
                          ),
                          const SizedBox(width: 24),
                            if(widget.userModel!.uid == FirebaseAuth.instance.currentUser!.uid!.toString() )
                              Expanded(child:
                                Center(child:Container(
                                    width: 120,
                                    height: 30,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),

                                          ),
                                          backgroundColor: Colors.black
                                      ),
                                      onPressed: (){
                                        // Edit profile page add


                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Editprofile(userModel:  widget.userModel,) ));
                                      },
                                      child: Text("EditProfile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white),),
                                    )
                                ),
                                ))


                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    if(widget.userModel!.uid != FirebaseAuth.instance.currentUser!.uid!.toString())
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 30,),
                              Container(
                                  width: 115,
                                  height: 30,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),

                                        ),
                                        backgroundColor: Colors.black
                                    ),
                                    onPressed: (){
                                      // Edit profile page add

                                      setState(() {
                                        checkRes();
                                      });
                                    },
                                    child: Text(res!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white),),
                                  )
                              ),
                              SizedBox(width: 15,),
                              Container(
                                  width: 115,
                                  height: 30,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),

                                        ),
                                        backgroundColor: Colors.black
                                    ),
                                    onPressed: ()async{
                                      // go to char screen
                                      showLoading(context);
                                      ChatRoomModel charRoom = await getChatRoomModel();
                                      Navigator.pop(context);
                                      // Edit profile page add
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>  ChatScreen(targetUser: widget.userModel,selfUser: widget.selfUser!,chatRoomModel:charRoom ,) ));

                                    },
                                    child: Text("Message",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),),
                                  )
                              ),
                            ],
                          ),

                        ),
                      ),
                    SizedBox(height: 15,),
                    // Bio
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "${widget.userModel.userName}", // user name
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text( "${widget.userModel.bio}", // bio data
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text( "${widget.userModel.address}", // bio data
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "${widget.userModel.email}",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),


                    SizedBox(height: 15,),
                    // Buttons
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SizedBox(width: 50,),
                          Expanded(
                            child: Column(
                              children:  [
                                Text(
                                  "${widget.userModel.followers!.length}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14

                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children:  [
                                Text(
                                  '${widget.userModel.following!.length}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Following',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 50,),

                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      height: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: IconButton(
                                onPressed: (){
                                },
                                icon: Icon( Icons.video_library),
                              )),
                          Expanded(
                              child: IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.article_outlined),
                              ))
                        ],

                      ),
                    ),
                    Divider(),
                    const SizedBox(height: 24),
                    // Grid post
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("PostDetail").where("uid", isEqualTo: widget.userModel.uid ).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.active)
                          {
                            if(snapshot.hasData)
                              {
                                var snapData = snapshot.data as QuerySnapshot;
                                return GridView.builder(

                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1 / 1,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                  ),

                                  itemBuilder: (context, index) {
                                    DocumentSnapshot dsnap = snapData.docs[index] as DocumentSnapshot;

                                    PostModel postmodel = PostModel.fromMap(dsnap.data() as Map<String, dynamic>);

                                    return InkWell(
                                      onTap: (){
                                        // post show
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  Postshowscreen(postModel: postmodel, userModel: widget.userModel) ));

                                      },
                                      child:  Container(
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(postmodel.postUrl!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: snapData.docs.length,
                                );



                              }
                            else{
                              return Center(
                                child: Text("No Post"),
                              );
                            }

                          }
                        else{
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
