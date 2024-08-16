class BlogModel {
  String? blogId;
  String? uid;
  String? title;
  String? content;
  String? author;
  String? date;
  String? postUrl;
  List<String>? like;
  bool? isFollow; // Add this property
  int? commentCount;
  BlogModel(

    this.blogId,
    this.uid,
    this.title,
     this.content,
     this.author,
     this.date,
   this. postUrl,
    this.like ,
    this.isFollow , // Initialize this property
    this.commentCount ,
  );
  BlogModel.fromMap(Map<String, dynamic> map)
  {
    blogId= map["blogId"];
    uid=map["uid"];
    title= map["title"];
    content= map["content"];
    author= map["author"];
    date = map["date"];
    postUrl = map["postUrl"];
    like = map["like"];
    isFollow= map["isFollow"];
    commentCount= map["commentCount"];

  }
  Map<String , dynamic> toMap()
  {
    return {
      "blogId":blogId,
      "uid":uid,
      "title":title,
      "content":content,
      "author": author,
      "date":date,
      "posUrl": postUrl,
      "like":like,
      "isFollow":isFollow,
      "commentCount":commentCount


    };

  }

}
