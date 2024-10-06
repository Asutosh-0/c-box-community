import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/pages/HistorySingleStatusScreen.dart';
import 'package:c_box/pages/story%20features/model/story.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../models/PostModel.dart';
import '../../utils.dart';
import 'PostShowScreen.dart';

class Showhistory extends StatefulWidget {
  final UserModel userModel;
  const Showhistory({super.key, required this.userModel});

  @override
  State<Showhistory> createState() => _ShowhistoryState();
}

class _ShowhistoryState extends State<Showhistory> {


  Future<List<StatusItem>> getStatusItem() async
  {

    List<StatusItem> items = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("History").where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    for(int i=0 ;i<querySnapshot.docs.length ; i++)
      {
        StatusItem statusItem = StatusItem.fromMap(querySnapshot.docs[i].data() as Map<String, dynamic>);

        items.add(statusItem);
      }

    return items;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black,
        title: Text("history", style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row
              (
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Story",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
              ),



              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: ()async{
                      List<StatusItem> items  = [];
                      items = await getStatusItem();
                      if(items.isNotEmpty)
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HistorySingleStatusScreen(statusItem: items) ));
                        }
                    },
                      child: Text("All",style: TextStyle(fontSize: 15,color: Colors.blue),))),




            ],),
            StatusHistory(),
            SizedBox(height: 20,),
            Row
              (
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("View",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                ),

                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text("All",style: TextStyle(fontSize: 15,color: Colors.blue),)),

              ],),
            ViewHistory(userModel: widget.userModel,),

          ],
        ),
      ),
    );
  }
}

class StatusHistory extends StatelessWidget {
  const StatusHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("History").where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          // Check if the snapshot has data and connection state is active
          if (snapshot.connectionState == ConnectionState.waiting) {
            return showSingleAnimationDialog(context, Indicator.ballRotateChase, true);

          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No status history found"));
          }

          QuerySnapshot qsnap = snapshot.data as QuerySnapshot;


          return ListView.builder(
            itemCount: qsnap.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Map<String, dynamic> statusdata = qsnap.docs[index].data() as Map<String, dynamic>;

              StatusItem statusItem = StatusItem.fromMap(statusdata);
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HistorySingleStatusScreen(statusItem: [statusItem]) ));
                  
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: 100,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black54,
                    image:  DecorationImage(
                        image:NetworkImage(statusdata["url"]),fit: BoxFit.cover)
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



class ViewHistory extends StatelessWidget {
  final UserModel userModel;
  const ViewHistory({super.key, required this.userModel});

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
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<PostModel>>(
        future: getListOfSave(),
        builder: (context, snapshot) {
          // Check if the snapshot has data and connection state is active
          if (snapshot.connectionState == ConnectionState.waiting) {
            return showSingleAnimationDialog(context, Indicator.ballRotateChase, true);
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No status history found"));
          }
          

          return ListView.builder(
            itemCount: snapshot.data!.length!,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              PostModel postModel = snapshot.data![index];
              
              return GestureDetector(
                onTap: (){
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
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: 100,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black54,
                      image:  DecorationImage(
                          image:NetworkImage(postModel.postUrl!),fit: BoxFit.cover)
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

