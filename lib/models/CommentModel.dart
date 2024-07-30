class Comment {
  String? userName;
  String? uid;
  String? commentId;
  String? comment;
  String? profilePic;
  List? likes;
  late final datePublished;

  Comment({this.userName,  this.uid, this.commentId, this.comment,this.profilePic,
     this.likes, this.datePublished});

  Map<String, dynamic> toMap() {
    return {
      "userName": userName,
      "uid": uid,
      "commentId": commentId,
      "comment": comment,
      "profilePic": profilePic,
      "likes": likes,
      "datePublished": DateTime.now()
    };
  }
  Comment fromMap(Map<String,dynamic> map)
  {
    return Comment(userName: map["userName"],
        uid: map["uid"] ,
        commentId: map["commentId"],
        comment: map["comment"],
        profilePic: map["profilePic"],
        likes:  map["likes"],
        datePublished: map["datePublished"]) ;

  }


}




