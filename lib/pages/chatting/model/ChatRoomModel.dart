class ChatRoomModel{

  String? chatroomid;
  Map<String, dynamic>? participants;
  String? lastMessage;
  String? lastTime;


  ChatRoomModel({
    this.chatroomid,
    this.participants,
    this.lastMessage,
    this.lastTime
  });
  ChatRoomModel.fromMap(Map<String,dynamic>map)
  {
    chatroomid=map["chatroomid"];
    participants=map["participants"];
    lastMessage=map["lastMessage"];
    lastTime= map["lastTime"];
  }

  Map<String,dynamic> toMap()
  {
    return{
      "chatroomid":chatroomid,
      "participants":participants,
      "lastMessage":lastMessage,
      "lastTime":lastTime

    };
  }





}