import 'dart:io';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/navigation_bar/navigation_bar.dart';
import 'package:c_box/pages/Screens/profile.dart';
import 'package:c_box/pages/pages/VideoShowScreen.dart';
import 'package:c_box/pages/twitter%20features/widgets/add_tweet_Screen.dart';
import 'package:c_box/services/postServices.dart';
import 'package:c_box/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../chatting/UserBottomSeet.dart';
import '../story features/widget/select_status_screen.dart';

class Post extends StatefulWidget {
  final UserModel userModel;
  const Post({super.key, required this.userModel});

  @override
  State<Post> createState() => _Post();
}

class _Post extends State<Post> {
  XFile? _file;
  TextEditingController captionC= TextEditingController();
  bool isVideo= false;



  void ShowButtomSheet(BuildContext context) async
  {
    await showModalBottomSheet(context: context,
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

                OptionItem(icon: Icon(Icons.image), text: "Image", onTap: () async{
                  Navigator.pop(context);
                  XFile? file = await  ImagePicker().pickImage(source: ImageSource.gallery,imageQuality:10 );
                  if(file != null)
                  {
                    setState(() {
                      _file = file;
                      isVideo= false;
                    });
                  }


                }),
                OptionItem(icon: Icon(Icons.video_file_outlined), text: "Video", onTap: ()async{

                  Navigator.pop(context);
                  try {
                    XFile? file = await ImagePicker().pickVideo(
                      source: ImageSource.gallery,

                    );
                    if (file != null) {
                      setState(() {
                        _file = file;
                        isVideo = true;
                      });
                    } else {
                      setState(() {

                      });
                    }
                  } catch (e) {
                    showUpdate("An error occurred while selecting the file", context);
                  }


                }),

              ]
          );
        });
  }

  void checkValue() async
  {
    print("check value function excute");
    String caption = captionC.text.trim();
    if(_file != null)
      {
        showLoading(context);
        String response =  await UploadPost(widget.userModel, File(_file!.path), caption, isVideo);
        if(response == "success")
          {
            Navigator.pop(context);
            showUpdate("post uploaded successfully", context);
            print("success Full upload");
            setState(() {
              _file = null;
              captionC.clear();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Navigation_Bar(userModel: widget.userModel)));
            });

          }
        else if(response == "error")
          {
            showUpdate("check internet connection", context);
            Navigator.pop(context);
            print("Check InterNet");

          }
        else
          {
            showUpdate(response, context);
            Navigator.pop(context);
            print(response);
          }

      }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor:Colors.black,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              backgroundColor: Colors.black
            ),
              onPressed: () async{
                checkValue();
              }, child: Text("post",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
          SizedBox(width: 15,),
        ],
      ),
      body:


      LayoutBuilder(
        builder: (context,constraint) {

          double width= constraint.maxWidth;
          return Center(
            child: Container(
              width: width> 500 ? 550 : width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Expanded(child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            controller: captionC,
                            decoration: InputDecoration(
                              hintText: "write something about your post",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none
                              )
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),

                        if(isVideo == false )
                        Expanded(child: (Container(
                          width: MediaQuery.of(context).size.width,

                          decoration: BoxDecoration(
                            image:  _file != null ? DecorationImage(
                              image: FileImage(File(_file!.path)),
                            ) : null

                          ),


                        ))),


                        if(isVideo == true)
                          Expanded(child: (Container(
                            width: MediaQuery.of(context).size.width,

                            // decoration: BoxDecoration(
                            //     image:  _file != null ? DecorationImage(
                            //       image: FileImage(File(_file!.path)),
                            //     ) : null
                            //
                            // ),
                           child: VideoShowScreen(file: File(_file!.path),),


                          ))),

                      ],
                    ),
                  )),

                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [


                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              ShowButtomSheet(context);
                          
                            },
                            child: Container(
                                height: 60,
                                width: 60,
                          
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black12,
                          
                                ),
                          
                                    child: Center(child: Icon(Icons.perm_media,size: 20,color: Colors.black54,))
                            ),
                          ),
                          Text("Media")
                        ],
                      ),
                      SizedBox(width: 20,),
                       Column(
                         children: [
                           GestureDetector(
                             onTap: ()async{
                               // select the status
                               XFile? _file = await ImagePicker().pickImage(source: ImageSource.gallery);
                               if(_file!= null)
                               {
                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (context)=>SelectStatusScreen(file: File(_file.path,),userModel: widget.userModel,) ));
                               }

                             },
                             child: Container(
                                height: 60,
                                width: 60,
                             
                             
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.black12,
                             
                                    ),
                             
                             
                                    child: Center(child:Icon(Icons.person_add,size: 20,color: Colors.black54,)),
                             
                                                   ),
                           ),
                           Text("Story")
                         ],
                       ),
                      SizedBox(width: 20,),

                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddTweetScreen(userModel: widget.userModel,)));
                          
                            },
                            child: Container(
                                height: 60,
                                width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black12,
                          
                              ),
                          
                                    child: Center(child: FaIcon(FontAwesomeIcons.twitter,size: 20,color: Colors.black54,)),
                          
                            ),
                          ),
                          Text("Tweets"),
                        ],
                      ),

                    ],
                  ),
                  SizedBox(height: 30,),


                ],
              ),
            ),
          );

        }
      ),
    );
  }
}
