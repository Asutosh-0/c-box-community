import 'package:c_box/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../services/postServices.dart';
import '../Screens/profile.dart';

class ShowFollowingScreen extends StatefulWidget {
  final UserModel userModel;
  const ShowFollowingScreen({super.key, required this.userModel});

  @override
  State<ShowFollowingScreen> createState() => _ShowFollowingScreenState();
}

class _ShowFollowingScreenState extends State<ShowFollowingScreen> {



  List<String> following = [];



  Future<List<UserModel>> getUserModels() async
  {
    List<UserModel>  userList= [];
    if(following.isNotEmpty)
    {
      for(int i =0;i<following.length; i++)
      {
        UserModel userModel= await getUserById(following[i]);
        print(userModel.userName);
        userList.add(userModel);
      }

    }


    return userList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    following = widget.userModel.following!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black,
        title: Text("following",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
      ),
      body: Container(

        child: FutureBuilder<List<UserModel>>(
            future: getUserModels(),
            builder: (context,snapshot)
            {
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
              return  ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    UserModel userModel = snapshot.data![index];

                    return GestureDetector(
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(userModel: userModel,selfUser: widget.userModel,)));
                        },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(5),
                        child:
                        Card(
                          elevation: 2,
                          // color:   Color(0xFF0FFFF6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          shadowColor: Colors.black,
                          child: ListTile(

                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: userModel.profilePic != null
                                  ? NetworkImage(userModel.profilePic!)
                                  : null,

                              child: userModel.profilePic == null
                                  ? Icon(Icons.person,size: 20)
                                  : null,
                            ),

                            title: Text(userModel.userName ?? 'No Username',style: TextStyle(fontWeight: FontWeight.w500),),
                            subtitle: Text(userModel.fullName ?? 'No Full Name'),
                          ),
                        ),


                      ),
                    );

                  });
            }

        ),
      ),
    );
  }
}
