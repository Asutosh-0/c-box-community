import 'dart:io';
import 'package:c_box/models/user_model.dart';
import 'package:c_box/navigation_bar/navigation_bar.dart';
import 'package:c_box/pages/Screens/profile.dart';
import 'package:c_box/pages/VideoShowScreen.dart';
import 'package:c_box/pages/twitter%20features/widgets/add_tweet_Screen.dart';
import 'package:c_box/services/postServices.dart';
import 'package:c_box/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

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
              onPressed: () async{
                checkValue();
              }, child: Text("post")),
          SizedBox(width: 15,),
        ],
        title: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person_outline),

          ),
          title: Text("user_name0055",style: TextStyle(fontSize: 14),),
        ),
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
                    children: [


                      Expanded(child: (Container(
                          height: 60,

                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                              ),

                              onPressed: ()  async{
                                XFile? file = await  ImagePicker().pickImage(source: ImageSource.gallery,imageQuality:10 );
                                if(file != null)
                                {
                                  setState(() {
                                    _file = file;
                                    isVideo= false;
                                  });
                                }


                              },
                              child: Text("image", style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),))
                      ))),
                      SizedBox(width: 20,),
                      Expanded(child: Container(
                          height: 60,

                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                              ),
                              onPressed: () async {
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
                              },

                              child: Center(child: Text("video",
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),)))),

                      ),
                      SizedBox(width: 20,),

                      Expanded(child: Container(
                          height: 60,

                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddTweetScreen(userModel: widget.userModel,)));

                              },
                              child: Center(child: Text("tweet",
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),)))),

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
