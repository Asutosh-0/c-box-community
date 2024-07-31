import 'package:c_box/models/CommentModel.dart';
import 'package:c_box/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CommentController {
  Future<String> postComment(UserModel userModel, String comment, String postId) async {
    try {
      print("post function run");
      String commentId = Uuid().v1();
      Comment postComment = Comment(
        userName: userModel.userName,
        uid: userModel.uid,
        commentId: commentId,
        comment: comment,
        profilePic: userModel.profilePic,
        likes: [],
        datePublished: DateTime.now(),
      );

      // Upload the comment
      await FirebaseFirestore.instance.collection("PostDetail").doc(postId)
          .collection("CommentDetail").doc(commentId).set(postComment.toMap());
      print("comment uploaded successfully");

      // Update the comment count
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("PostDetail").doc(postId).get();
      int currentCommentCount = (snapshot.data() as dynamic)["commentCount"] ?? 0;
      await FirebaseFirestore.instance.collection("PostDetail").doc(postId).update({
        "commentCount": currentCommentCount + 1,
      });
      return "success";
      print("function end");
    } catch (e) {
      print("error");
      return e.toString();
      print(e.toString());
    }
  }
}

void likeComment(String commentId, String postId, String uid) async
{
  DocumentSnapshot snapshot=  await FirebaseFirestore.instance.collection("PostDetail").doc(postId).collection("CommentDetail").doc(commentId).get();
  Map<String, dynamic> map = snapshot.data() as Map<String,dynamic>;

  if(map["likes"].contains(uid))
    {
      await FirebaseFirestore.instance.collection("PostDetail").doc(postId).collection("CommentDetail").doc(commentId).update({
        "likes" : FieldValue.arrayRemove([uid])
      });

    }else
      {
        await FirebaseFirestore.instance.collection("PostDetail").doc(postId).collection("CommentDetail").doc(commentId).update({
          "likes":FieldValue.arrayUnion([uid])
        });

      }
}

