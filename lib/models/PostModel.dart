class PostModel{
  String? userName;
  String? uid;
  String? postId;
  String? postUrl;
  String? caption;
  String? profilePic;
  List? likes;
  int? commentCount = 0;
  int? shareCount = 0;
  bool? isVideo;

  PostModel({
    this.userName,
    this.uid,
    this.postId,
    this.postUrl,
    this.caption,
    this.profilePic,
    this.likes,
    this.commentCount,
    this.shareCount ,
    this.isVideo
  });

  PostModel.fromMap(Map <String,dynamic> map )
  {
    userName = map["userName"];
    uid = map["uid"];
    postId = map["postId"];
    postUrl= map["postUrl"];
    caption = map["caption"];
    profilePic= map["profilePic"];
    likes = map["likes"];
    commentCount = map["commentCount"];
    shareCount = map["shareCount"];
    isVideo = map["isVideo"];

  }
  Map<String,dynamic> toMap()
  {
    return{
      "userName":userName,
      "uid":uid,
      "postId":postId,
      "postUrl":postUrl,
      "caption": caption,
      "likes": likes,
      "commentCount":commentCount,
      "shareCount":shareCount,
      "isVideo" : isVideo
    };
  }


}