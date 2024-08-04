import 'package:c_box/main.dart';
import 'package:c_box/models/PostModel.dart';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/EditProfilePage.dart';
import 'package:c_box/pages/chatting/chat_screen.dart';
import 'package:c_box/pages/Screens/post.dart';
import 'package:c_box/services/postServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  final UserModel userModel;
  const Profile({super.key, required this.userModel});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final List<Map<String, String>> listPosts = List.generate(
    20,
    (index) => {
      'image': 'https://cdn.pixabay.com/photo/2016/03/15/17/07/girl-1258727_640.jpg',
    },
  );
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getModel();
  }

  // void getModel() async
  // {
  //   userModel = await getUserById(widget.uid);
  // }

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
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/c_box.png'),
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


                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Editprofile() ));
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

                                    },
                                    child: Text("follow",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white),),
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
                                    onPressed: (){
                                      // Edit profile page add
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>  ChatScreen(targetUser: widget.userModel,) ));

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
                                    final post = listPosts[index];

                                    DocumentSnapshot dsnap = snapData.docs[index] as DocumentSnapshot;

                                    PostModel postmodel = PostModel.fromMap(dsnap.data() as Map<String, dynamic>);

                                    return Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(postmodel.postUrl!),
                                          fit: BoxFit.cover,
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

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (){
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Editprofile()),
                );
        },
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
