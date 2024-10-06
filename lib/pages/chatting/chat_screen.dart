import 'dart:io';

import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/chatting/model/ChatRoomModel.dart';
import 'package:c_box/pages/chatting/model/Message.dart';
import 'package:c_box/pages/chatting/utils/ChattingUtil.dart';
import 'package:c_box/pages/chatting/utils/helper.dart';
import 'package:c_box/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'UserBottomSeet.dart';
import 'package:flutter/rendering.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';

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
  File? file;

  // _saveNetworkImage() async {
  //   var response = await Dio().get(
  //       "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
  //       options: Options(responseType: ResponseType.bytes));
  //   final result = await ImageGallerySaver.saveImage(
  //       Uint8List.fromList(response.data),
  //       quality: 60,
  //       name: "hello");
  //   print(result);
  // }

  Future<String> UploadFile(File file,String uid, String id) async {
    try {
      String url = "";
      Reference reference = FirebaseStorage.instance.ref().child("ChattingFile/${uid}/${id}");
      UploadTask uploadTask = reference.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      url = await snapshot.ref.getDownloadURL();

      print(url);
      return url;
    } catch (er) {
      return "error";
    }
  }


  void messageSend(MessageType type,String text) async
  {
    try {
      String message = text;
      if (message.isNotEmpty) {
        MessageModel messageModel = MessageModel(
            messageid: Uuid().v1(),
            sender: widget.selfUser.uid,
            toId: widget.targetUser.uid,
            time: DateTime
                .now()
                .millisecondsSinceEpoch
                .toString(),
            text: message,
            seen: false,
            type: type

        );
        MessageUtil().SendMessage(messageModel, widget.chatRoomModel);
      }
    }
    catch(er)
    {
      showUpdate("${er.toString()}", context);

    }
    messageC.clear();
    setState(() {
      file = null;
    });

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
                backgroundImage:widget.targetUser!.profilePic != null
                    ? NetworkImage(widget.targetUser!.profilePic!)
                    : null,
                child: widget.targetUser.profilePic == null
                    ? Icon(Icons.person,size: 17,)
                    : null,
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
                              if (message.seen == false) {
                                SeenUserMessage(message, widget.chatRoomModel);
                                FirebaseFirestore.instance.collection(
                                    "ChatRoom").doc(
                                    widget.chatRoomModel.chatroomid).update({
                                  "newMessage": false
                                });
                              }
                            }
                            bool isMe = message.sender == widget.selfUser.uid;
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: message.sender == widget.selfUser.uid ? MainAxisAlignment.end : MainAxisAlignment.start ,
                              children: [
                                Flexible(

                                    child:
                                    InkWell(
                                      onLongPress: (){
                                        //buttom seet

                                        showModalBottomSheet(context: context,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:  Radius.circular(20),
                                                    topRight: Radius.circular(20)
                                                )
                                            ),
                                            builder: (_) {
                                              return ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  Container(
                                                    height: 4,
                                                    margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.015 ,horizontal: MediaQuery.of(context).size.width*0.4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius.circular(8)

                                                    ),
                                                  ),
                                                  message.type == MessageType.text ?
                                                  OptionItem(icon: Icon(Icons.copy,color: Colors.blue,size: 26,), text: "Copy Text", onTap: ()async{

                                                   await  Clipboard.setData(ClipboardData(text: message.text!) ).then((value){
                                                      Navigator.pop(context);
                                                      print("text copy");
                                                    });
                                                  })
                                                  :
                                              OptionItem(icon: Icon(Icons.download_rounded,color: Colors.blue,size: 26,), text: "Save Image", onTap: (){
                                               // _saveNetworkImage();
                                                Navigator.pop(context);

                                              }),


                                              Divider(
                                                    color: Colors.black54,
                                                    thickness: 0.5,
                                                    endIndent: 10,
                                                    indent: 10,
                                                  ),
                                                if(  message.type == MessageType.text && isMe)

                                                  OptionItem(icon: Icon(Icons.edit,color: Colors.blue,size: 26,), text: "Edit Message", onTap: (){
                                                    // edit message
                                                    Navigator.pop(context);
                                                    showUpdateDialog(message);

                                                  }),


                                                  if( isMe)
                                                  OptionItem(icon: Icon(Icons.delete,color: Colors.red,size: 26,), text: "Delete Message", onTap: (){

                                                    Navigator.pop(context);
                                                    MessageUtil().DeleteMessage(message, widget.chatRoomModel);

                                                  }),



                                                ],

                                              );
                                            });

                                      },
                                      child:

                                    Column(
                                      mainAxisSize:MainAxisSize.min,
                                      crossAxisAlignment: message.sender == widget.selfUser.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start ,


                                      children: [
                                        if(message.type == MessageType.image)
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: message.sender == widget.selfUser.uid
                                                ? MainAxisAlignment.end
                                                : MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: AspectRatio(
                                                  aspectRatio: 9 / 6,
                                                  child: Container(
                                                    margin: message.sender == widget.selfUser.uid
                                                        ? EdgeInsets.only(left: 50, right: 10, top: 10, bottom: 10) // Right align for self
                                                        : EdgeInsets.only(right: 50, left: 10, top: 10, bottom: 10), // Left align for others
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: Image.network(
                                                      message.text!,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),


                                        if(message.type == MessageType.text)
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
                                              child: message.type == MessageType.text ? Text(
                                                  message.text.toString()
                                              ) : AspectRatio(aspectRatio: 5/3,
                                              child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Image.network(message.text!,fit:BoxFit.contain ,)),),
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
                            )
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
                            suffixIcon: InkWell(
                              onTap: ()async{
                                XFile? xfile= await ImagePicker().pickImage(source: ImageSource.gallery);
                                if(xfile!=null)
                                  {
                                    setState(() {
                                      file =  File(xfile.path);
                                      messageC.text = xfile.name;
                                    });

                                  }


                              },
                                child: Icon(Icons.camera_alt))
                          ),
                        ),
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: ()async{
                        if(file != null)
                          {
                            showLoading(context);
                            String id = Uuid().v1();
                            String url =  await  UploadFile(file!, widget.selfUser!.uid!, id);
                            if(url != "error")
                              {
                                messageSend(MessageType.image,url);

                              }
                            else
                              {
                                showUpdate("something error ", context);
                              }
                            Navigator.pop(context);

                          }
                        else
                          {
                            messageSend(MessageType.text!,messageC.text.trim());

                          }
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

  void showUpdateDialog(MessageModel message) {
    String updateMessage =  message.text!;

    showDialog(context: context, builder: (_){

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: Row(
          children: [
            Icon(Icons.message,size: 20,),
            SizedBox(width: 10,),
            Text("Update Message",style: TextStyle(fontSize: 15),)
          ],
        ),
        content: TextFormField(
          maxLines: null,
          onChanged: (value)=> updateMessage = value,
          initialValue: updateMessage,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
        ),
        actions: [

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.black,
                elevation: 2
              ),

              onPressed: (){

                Navigator.pop(context);
          }, child: Text("Cancel",style: TextStyle(color: Colors.white),)),

          SizedBox(width: 5,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.black,
                  elevation: 2
              ),

              onPressed: (){

                MessageUtil().EditMessage(message,widget.chatRoomModel, updateMessage);

                Navigator.pop(context);
              }, child: Text("Update",style: TextStyle(color: Colors.white),)),
        ],

      );
    });

  }
}
