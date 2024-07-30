import 'package:c_box/models/CommentModel.dart';
import 'package:c_box/models/PostModel.dart';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/services/CommentController.dart';
import 'package:c_box/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  final UserModel userModel;
  final PostModel postModel;
   CommentPage({super.key, required this.userModel, required this.postModel});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController controller = TextEditingController();

  void PutComment() async
  {
    String comment = controller.text.trim();
    if(comment != null)
      {
        controller.clear();
        String res =  await CommentController().postComment(widget.userModel, comment, widget.postModel.postId!);


        // if(res=="success")
        //   {
        //     Navigator.pop(context);
        //     controller.clear();
        //   }
        // else{
        //   Navigator.pop(context);
        //
        // }
      }
    else{
      print("enter the value");
    }

  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: AppBar(
          title:  ListTile(
            leading:  CircleAvatar(
              child: Icon(Icons.person_outline),
            ),
            title: Text("${widget.userModel.userName}"),
          ),
        ),
        body:Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("PostDetail")
                      .doc(widget.postModel.postId)
                      .collection("CommentDetail").snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState  == ConnectionState.active)
                      {
                        if(snapshot.hasData)
                          {
                            var  qSnap = snapshot.data as QuerySnapshot;
                            return ListView.builder(
                              itemCount: qSnap.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot dSnap = qSnap.docs[index] as DocumentSnapshot;
                                Comment comment= Comment().fromMap(dSnap.data() as Map<String,dynamic>);
                                return CommentWidget(comment: comment,);
                              },
                            );

                          }
                        else
                          {
                            return Center(child: Text("no comment"));
                          }

                      }else{
                      return  Center(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "Comment something...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        PutComment();
                        // post comment



                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )


    );
  }
}

class CommentWidget extends StatelessWidget {
  final Comment comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person_outline),
      ),
      title: Text("${comment.userName}"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${comment.comment}"),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TextButton(onPressed: () {}, child: Text("Reply")),
              ],
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.favorite_outline
        ),
        onPressed: (){
          print("like button click");
        },
      ),
    );
  }
}
