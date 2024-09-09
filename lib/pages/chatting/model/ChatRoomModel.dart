class ChatRoomModel{

  String? chatroomid;
  Map<String, dynamic>? participants;
  String? lastMessage;
  String? lastTime;
  bool? newMessage;



  ChatRoomModel({
    this.chatroomid,
    this.participants,
    this.lastMessage,
    this.lastTime,
    this.newMessage
  });
  ChatRoomModel.fromMap(Map<String,dynamic>map)
  {
    chatroomid=map["chatroomid"];
    participants=map["participants"];
    lastMessage=map["lastMessage"];
    lastTime= map["lastTime"];
    newMessage = map["newMessage"] == true ? true : false;
  }

  Map<String,dynamic> toMap()
  {
    return{
      "chatroomid":chatroomid,
      "participants":participants,
      "lastMessage":lastMessage,
      "lastTime":lastTime,
      "newMessage": newMessage?? true

    };
  }





}