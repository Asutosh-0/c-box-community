import 'package:c_box/models/user_model.dart';
import 'package:c_box/services/postServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../models/PostModel.dart';
import '../../utils.dart';
import 'PostShowScreen.dart';

class SavePostScreen extends StatelessWidget {
  final UserModel userModel;
  const SavePostScreen({super.key, required this.userModel});

  Future<PostModel> getPostModelById(String id)async
  {
    DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection("PostDetail").doc(id).get();
    PostModel postModel= PostModel.fromMap(snapshot.data() as Map<String,dynamic>);
    return postModel;

  }

  Future<List<PostModel>> getListOfSave() async {
    List<PostModel> posts = [];

    List<String>? save = userModel.save; // No need to force unwrap
    if (save != null && save.isNotEmpty) {
      for (String id in save) {
        PostModel postModel = await getPostModelById(id); // No need to unwrap
        posts.add(postModel);
        print(postModel.postId);
      }
    }

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return
    
      Scaffold(
        appBar: AppBar(
          title: Text("save",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
          elevation: 2,
          shadowColor: Colors.black,
        ),
    body:
      Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10),
      child: FutureBuilder<List<PostModel>>(
        future: getListOfSave(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return showLoaddingAmination(indicator: Indicator.ballBeat, showPathBackground: true);

          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  PostModel postModel = snapshot.data![index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Postshowscreen(
                            postModel: postModel,
                            userModel: userModel,
                          ),
                        ),
                      );
                    },
                    child: Material(
                      // Adding Material widget here
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              postModel.postUrl ?? 'https://via.placeholder.com/150',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );

                },
              );
            } else {
              return Center(child: Text("No Data"));
            }
          } else {
            return Center(child: Text("Error loading data"));
          }
        },
      ),
    ));
  }
}
