import 'package:c_box/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final UserModel targetUser;
  const ChatScreen({super.key, required this.targetUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

            )),
            Container(
              child: Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: Container(
                        child: TextField(
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
