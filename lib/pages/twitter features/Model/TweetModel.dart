
class Tweet{
  String? text;
  List<String>? hashTags;
  String? link;
  List<String>? imageLinks;
  String? uid;
  String? userName;
  String? profilePic;
  String? tweetId;
  List<String>? likes;
  TweetType? tweetType;
  String? tweetedAt;
  String? reTweetedBy;
  int? reshareCount = 0 ;

  Tweet({
      this.text,
      this.hashTags,
      this.link,
      this.imageLinks,
      this.uid,
      this.userName,
    this.profilePic,
      this.tweetId,
      this.likes,
      this.tweetType,
      this.tweetedAt,
      this.reTweetedBy,
      this.reshareCount});

  Tweet.formMap(Map<String ,dynamic> map)
  {
    text = map["text"];
    hashTags= List<String>.from( map["hashTag"]?? []);
    link= map["link"];
    imageLinks= List<String>.from( map["imageLinks"]?? []);
    uid = map["uid"] ;
    userName= map["userName"];
    profilePic= map["profilePic"];
    tweetId= map["tweetId"];
    likes = List<String>.from( map["likes"]?? []);
    tweetType = map["type"].toString() == TweetType.image.name ? TweetType.image : TweetType.text;
    tweetedAt =  map["tweetedAt"];
    reTweetedBy= map["reTweetedBy"];
    reshareCount =map["reshareCount"];
  }
  Map<String,dynamic> toMap()
  {
    return {
      "text":text,
      "hashTag":hashTags,
      "link":link,
      "imageLinks":imageLinks,
      "uid":uid,
      "userName":userName,
      "profilePic":profilePic,
      "tweetId":tweetId,
      "likes":likes,
      "type":tweetType?.type,
      "tweetedAt":tweetedAt,
      "reTweetedBy":reTweetedBy,
      "reshareCount":reshareCount,

  };

  }

}

enum TweetType{
  text("text"),
  image("image");
  final String type;
  const TweetType(this.type);

}
extension ConvertTweet on String{
  TweetType  toEnum(){
    switch (this){
      case "text":
        return TweetType.text;
      case "image":
        return TweetType.image;
        default:
          return TweetType.text;
    }
  }
}