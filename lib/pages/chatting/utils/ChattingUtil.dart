import 'package:c_box/pages/chatting/model/ChatRoomModel.dart';
import 'package:c_box/pages/chatting/model/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageUtil{
  
  
  void SendMessage(MessageModel message,ChatRoomModel chatroom) async
  {
    await FirebaseFirestore.instance.collection("ChatRoom").doc(chatroom.chatroomid)
        .collection("Messages").doc(message.messageid).set(message.toMap());

    await FirebaseFirestore.instance.collection("ChatRoom").doc(chatroom.chatroomid).update({
      "lastMessage":message.type == MessageType.text? message.text : "Images",
      "lastTime":message.time,
      "newMessage":true
    });

  }
  void DeleteMessage(MessageModel message, ChatRoomModel chatRoomModel) async
  {
    await FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomModel.chatroomid)
        .collection("Messages").doc(message.messageid).delete();
  }
  void EditMessage(MessageModel message, ChatRoomModel chatRoomModel,String text) async
  {
    await FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomModel.chatroomid)
        .collection("Messages").doc(message.messageid).update({
      "text": text,
      "seen":false

    });
  }
}