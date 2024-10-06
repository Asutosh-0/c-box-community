
class UserModel{
  String? userName;
  String? email;
  String? password;
  String? profilePic;
  String? uid;
  String? bio;
  String? address;
  List<String>? followers;
  List<String>? following;
  String? faceId;
  String? fullName;
  List<String>? save;
  List<String>? viewHistory;

  UserModel({ this.userName , this.email, this.password ,
    this.profilePic, this.uid, this.bio, this.address,
    this.followers, this.following,this.faceId, this.fullName,this.save,this.viewHistory});

  UserModel.fromMap(Map<String, dynamic> map)
  {
    userName = map["userName"];
    email =  map["email"];
    password = map["password"];
    profilePic = map["profilePic"];
    uid = map["uid"];
    bio = map["bio"];
    address = map["address"];
    followers =  List<String>.from(  map["followers"] ?? []);
    following = List<String>.from( map["following"] ?? []);
    faceId= map["faceId"];
    fullName = map["fullName"];
    save = List<String>.from(map["save"] ?? []);
    viewHistory= List<String>.from(map["viewHistory"] ?? []);

  }

  Map<String , dynamic> toMap()
  {
    return {
      "userName" : userName,
      "email" : email,
      "password": password,
      "profilePic": profilePic,
      "uid": uid,
      "bio" : bio,
      "address": address,
      "followers" : followers,
      "following" : following,
      "faceId": faceId,
      "fullName" :fullName,
      "save":save,
      "viewHistory":[]
    };
  }


}