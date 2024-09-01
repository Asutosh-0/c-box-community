class Status{
  final String statusId;
  final String caption;
  final String uid;
  final String userName;
  final String profilePic;
  final List<String> statusUrl;
  final DateTime createdAt;
  final List<String> whoCanSee;

  factory Status.fromMap(Map<String, dynamic> json) {
    return Status(
      caption: json["caption"]?? "",
      statusId: json["statusId"]?? "",
      uid: json["uid"]?? "",
      userName: json["userName"]?? "",
      profilePic: json["profilePic"]?? "",
      statusUrl:List<String>.from(json["statusUrl"]),
      createdAt: DateTime.fromMicrosecondsSinceEpoch(json["createdAt"]),
      whoCanSee:List<String>.from(json["whoCanSee"])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "statusId": statusId,
      "caption":caption,
      "uid": uid,
      "userName": userName,
      "profilePic": profilePic,
      "statusUrl": statusUrl,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "whoCanSee": whoCanSee,
    };
  }

  Status({required this.statusId, required this.uid, required this.userName, required this.profilePic,
    required this.statusUrl, required this.createdAt, required this.whoCanSee,required this.caption});


}