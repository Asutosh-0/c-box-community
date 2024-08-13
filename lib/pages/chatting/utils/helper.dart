import 'package:c_box/pages/chatting/model/ChatRoomModel.dart';
import 'package:c_box/pages/chatting/model/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String getFormatedString(BuildContext context,String time)
{
  final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(time)*1000);

  return TimeOfDay.fromDateTime(date).format(context);

}

Future<void> SeenUserMessage(MessageModel  message, ChatRoomModel chatRoom) async
{
  FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoom.chatroomid).collection("Messages")
      .doc(message.messageid).update({
    "seen": true
  });


}

