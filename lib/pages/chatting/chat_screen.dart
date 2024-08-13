import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/chatting/model/ChatRoomModel.dart';
import 'package:c_box/pages/chatting/model/Message.dart';
import 'package:c_box/pages/chatting/utils/ChattingUtil.dart';
import 'package:c_box/pages/chatting/utils/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  final UserModel selfUser;
  final ChatRoomModel chatRoomModel;
  final UserModel targetUser;
  const ChatScreen({super.key, required this.targetUser, required this.selfUser, required this.chatRoomModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageC= TextEditingController();



  void messageSend() async
  {
    String message = messageC.text.trim();
    if(message.isNotEmpty)
      {
        MessageModel messageModel = MessageModel(
          messageid: Uuid().v1(),
          sender: widget.selfUser.uid,
          toId: widget.targetUser.uid,
          time: DateTime.now().millisecondsSinceEpoch.toString(),
          text: message,
          seen: false

        );
        MessageUtil().SendMessage(messageModel, widget.chatRoomModel);
        messageC.clear();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.black,
        actions: [
          Container(
            width: 70,
            child: Row(
              children: [
                Icon(Icons.video_call_outlined),
                SizedBox(width: 15,),
                Icon(Icons.phone),
              ],
            ),
          ),
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert),
            onSelected: (int result) {
              // Handle the selected menu item
              switch (result) {
                case 0:
                  break;
                case 1:
                // Do something for option 2
                  break;
                case 2:
                // Do something for option 3
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('option 1'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Option 2'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Option 3'),
              ),
            ],
          ),
        ],
        titleSpacing: 0,
        title:
            ListTile(
              title: Container(child:
                Text(widget.targetUser.userName!,style: TextStyle(fontSize: 15),),
              ),
              leading: CircleAvatar(
                radius: 15,
              child: Icon(Icons.person,size: 20,weight: 1),
            ),
        ),
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(

          children: [
            Expanded(child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("ChatRoom").doc(widget.chatRoomModel.chatroomid)
                    .collection("Messages").orderBy("time",descending: true).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.active)
                    {
                      if(snapshot.hasData)
                        {
                          QuerySnapshot qsnap= snapshot.data as QuerySnapshot;


                          return ListView.builder(
                            reverse:  true,
                              itemCount: qsnap.docs.length,
                              itemBuilder: (contex,index)
                          {
                            MessageModel message= MessageModel.fromMap(qsnap.docs[index].data() as Map<String,dynamic>);

                            if(message.toId !=  widget.targetUser.uid) {
                              if (message.seen == false)
                                SeenUserMessage(message, widget.chatRoomModel);
                            }
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: message.sender == widget.selfUser.uid ? MainAxisAlignment.end : MainAxisAlignment.start ,
                              children: [
                                Flexible(

                                    child: Column(
                                      mainAxisSize:MainAxisSize.min,
                                      crossAxisAlignment: message.sender == widget.selfUser.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start ,


                                      children: [
                                        Card(
                                          elevation:2,
                                          margin: EdgeInsets.all(8),
                                          // color:Colors.blueAccent,
                                          shape:RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(7),
                                              topRight: Radius.circular(7),
                                              bottomRight: message.sender == widget.selfUser.uid ? Radius.circular(0):Radius.circular(7),
                                              bottomLeft: message.sender != widget.selfUser.uid ? Radius.circular(0):Radius.circular(7),
                                            ),
                                          ),
                                          // padding: EdgeInsets.all(4),
                                          //        decoration:BoxDecoration(
                                          // borderRadius: BorderRadius.only(
                                          //   topLeft: Radius.circular(7),
                                          //   topRight: Radius.circular(7),
                                          //   bottomRight: message.sender == widget.selfUser.uid ? Radius.circular(0):Radius.circular(7),
                                          //   bottomLeft: message.sender != widget.selfUser.uid ? Radius.circular(0):Radius.circular(7),
                                          // ),
                                          //          border: Border.all(color: Colors.lightBlue),
                                          //          color:  message.sender == widget.selfUser.uid ? Color.fromARGB(255, 221, 245, 255): Color.fromARGB(255, 221, 245, 255)
                                          //
                                          //  ),

                                          child: Padding(
                                            padding:  EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                              left: message.sender != widget.selfUser.uid ? 15:8,
                                              right: message.sender == widget.selfUser.uid ?15:8,

                                            ),
                                            child: Text(
                                                message.text.toString()
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.all(4.0),

                                            child: Container(

                                              width: 70,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: message.sender == widget.selfUser.uid ? MainAxisAlignment.end : MainAxisAlignment.start ,

                                                children: [
                                                  if( message.sender != widget.selfUser.uid )
                                                    SizedBox(width: 10,),
                                                  Text("${getFormatedString(context, message.time!)}",style: TextStyle(fontSize: 10),),
                                                  SizedBox(width: 4,),
                                                  if(message.sender ==  widget.selfUser.uid)
                                                  Icon(Icons.check,size: 11,color: message.seen == true ? Colors.blue :null,),
                                                  SizedBox(width: 5,),
                                                ],


                                              ),
                                            ),

                                        )
                                      ],
                                    ),
                                ),



                              ],

                            );

                          });
                        }
                      else
                        {
                          return Center(
                            child: Text(
                              "Say hi To your friend"
                            ),
                          );
                        }

                    }
                  else
                    {
                      return Center(
                        child:SizedBox(
                          width: 25, // Adjust the width to reduce the size
                          height: 25, // Adjust the height to reduce the size
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            strokeWidth: 2.0,
                          ),
                        ),
                      );

                    }



                }
              ),

            )),
            Container(
              child: Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: Container(
                        child: TextField(
                          controller: messageC,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Enter the message",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none
                            ),
                            suffixIcon: Icon(Icons.camera_alt)
                          ),
                        ),
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: (){
                        messageSend();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.brown.shade400,
                        child: Icon(Icons.send,color: Colors.white,),
                      ),
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
