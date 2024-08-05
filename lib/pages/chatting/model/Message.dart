class MessageModel{
  String? messageid;
  String? sender;
  String? toId;
  String? text;
  bool? seen;
  String? time;
  Type? type;



  MessageModel({this.messageid ,this.sender, this.text, this.seen, this.time,this.toId,this.type});


  MessageModel.fromMap(Map<String,dynamic> map)
  {
    messageid= map["messageId"];
    sender=map["sender"];
    toId= map["toId"];
    text=map["text"];
    seen=map["seen"];
    time=map["time"];
    type = map["type"].toString() == Type.image.name ? Type.image : Type.text;
  }

  Map<String,dynamic> toMap(){
    return{
      "messageId":messageid,
      "sender":sender,
      "toId":toId,
      "text":text,
      "seen":seen,
      "time":time,
      "type":type
    };
  }
}

enum Type{
 text,
 image
}