import 'package:c_box/pages/chatting/model/ChatRoomModel.dart';
import 'package:c_box/pages/chatting/model/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageUtil{
  
  
  void SendMessage(MessageModel message,ChatRoomModel chatroom) async
  {
    await FirebaseFirestore.instance.collection("ChatRoom").doc(chatroom.chatroomid)
        .collection("Messages").doc(message.messageid).set(message.toMap());

    await FirebaseFirestore.instance.collection("ChatRoom").doc(chatroom.chatroomid).update({
      "lastMessage":message.text
    });

  }
}