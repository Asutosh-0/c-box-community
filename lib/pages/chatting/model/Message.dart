class MessageModel{
  String? messageid;
  String? sender;
  String? fromId;
  String? text;
  bool? seen;
  String? createdon;
  Type? type;



  MessageModel({this.messageid ,this.sender, this.text, this.seen, this.createdon,this.fromId,this.type});


  MessageModel.fromMap(Map<String,dynamic> map)
  {
    messageid= map["messageid"];
    sender=map["sender"];
    fromId= map["fromId"];
    text=map["text"];
    seen=map["seen"];
    createdon=map["createdon"];
    type = map["type"].toString() == Type.image.name ? Type.image : Type.text;
  }

  Map<String,dynamic> toMap(){
    return{
      "messageid":messageid,
      "sender":sender,
      "fromId":fromId,
      "text":text,
      "seen":seen,
      "createdon":createdon,
      "type":type
    };
  }
}

enum Type{
 text,
 image
}