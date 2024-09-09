import 'package:c_box/pages/story%20features/model/story.dart';

class Status{
  final String caption;
  final String uid;
  final String userName;
  final String profilePic;
   List<Map<String,dynamic>> items;
  final List<String> statusUrl;
  final List<String> whoCanSee;

  factory Status.fromMap(Map<String, dynamic> json) {
    return Status(
      caption: json["caption"]?? "",
      uid: json["uid"]?? "",
      userName: json["userName"]?? "",
      profilePic: json["profilePic"]?? "",
      statusUrl:List<String>.from(json["statusUrl"]),
      items: List<Map<String,dynamic>>.from(json["items"]),
      whoCanSee:List<String>.from(json["whoCanSee"])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "caption":caption,
      "uid": uid,
      "userName": userName,
      "profilePic": profilePic,
      "items":items,
      "statusUrl": statusUrl,
      "whoCanSee": whoCanSee,
    };
  }

  Status({ required this.uid, required this.userName, required this.profilePic,required this.items,
    required this.statusUrl, required this.whoCanSee,required this.caption});


}