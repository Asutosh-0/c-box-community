import 'package:c_box/models/PostModel.dart';
import 'package:c_box/models/user_model.dart';
import 'package:flutter/material.dart';

import 'Screens/home.dart';

class Postshowscreen extends StatelessWidget {
  final PostModel postModel;
  final UserModel userModel;
  const Postshowscreen({super.key, required this.postModel, required this.userModel});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black,
        title: Text("post",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(postModel.isVideo==false)
            PostBar(postModel: postModel),

            if(postModel.isVideo == true)
              PostVideo(showVideo: postModel),

            const SizedBox(height: 15),

            // Bottom
            ButtomBar(postModel:postModel,userModel: userModel!)


          ],
        ),
      ),
    );
  }
}
