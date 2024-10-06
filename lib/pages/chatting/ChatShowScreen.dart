import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/chatting/chat_screen.dart';
import 'package:c_box/pages/chatting/utils/helper.dart';
import 'package:c_box/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../services/postServices.dart';
import 'model/ChatRoomModel.dart';

class ChatShowScreen extends StatelessWidget {
  final UserModel userModel;
  const ChatShowScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black87,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "C-Box",
              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
            ),
            Text(
              "  chats",
              style: TextStyle(
                fontSize: 11,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notification_add)),
          SizedBox(width: 10,)
        ],
      ),
      body: Container(

        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("ChatRoom")
              .where("participants.${userModel.uid}", isEqualTo: true)
              // .orderBy("lastTime",descending: true)
              .snapshots(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;

                return ListView.builder(
                    itemCount: querySnapshot.docs.length,
                    itemBuilder: (context, index) {
                      ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                          querySnapshot.docs[index].data() as Map<String, dynamic>);

                      Map<String, dynamic> participants = chatRoomModel.participants!;

                      List<String> participantsKey = participants.keys.toList();

                      participantsKey.remove(userModel.uid);

                      return FutureBuilder(
                          future: getUserById(participantsKey[0]),
                          builder: (context, userData) {
                            if (userData.connectionState == ConnectionState.done) {
                              if (userData.hasData) {
                                UserModel targetUser = userData.data as UserModel;

                                return ListTile(
                                  onTap: () {


                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                              targetUser: targetUser,
                                              selfUser: userModel,
                                              chatRoomModel: chatRoomModel,
                                            )));
                                  },
                                  title: Text(
                                    targetUser.userName.toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  subtitle: chatRoomModel.lastMessage.toString() != ""
                                      ? Text(
                                    chatRoomModel.lastMessage.toString(),
                                    style: TextStyle(fontSize: 13, color: Colors.black45),
                                  )
                                      : Text("Say hi to your new friend"),
                                  leading: CircleAvatar(
                                    radius: 17,
                                    backgroundImage: targetUser.profilePic != null
                                        ? NetworkImage(targetUser.profilePic!)
                                        : null,
                                    child: targetUser.profilePic == null
                                        ? Icon(Icons.person, size: 17)
                                        : null,
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      if(chatRoomModel.newMessage == true)

                                      Text(".",style: TextStyle(fontSize: 20,color: Colors.black54),),
                                      Text(

                                        getFormatedString(context, chatRoomModel.lastTime!),
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            } else {
                               return Container();
                            }
                          });
                    });
              } else {
                return Center(
                  child: Text("No chats"),
                );
              }
            } else {
              return showLoaddingAmination(indicator: Indicator.ballBeat, showPathBackground: true);
            }
          },
        ),
      ),
    );
  }
}
