import 'dart:io';

import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/twitter%20features/sevices/tweet_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddTweetScreen extends StatefulWidget {
  final UserModel userModel;
  const AddTweetScreen({super.key, required this.userModel});

  @override
  State<AddTweetScreen> createState() => _AddTweetScreenState();
}

class _AddTweetScreenState extends State<AddTweetScreen> {
  final tweetTextController  = TextEditingController();
  List<File> images= [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tweetTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);

          },
          icon: Icon(Icons.close),

        ),
        actions: [
          ElevatedButton(
              onPressed: () async{
         // tweet
                TweetController tweet= TweetController();
                tweet.shareTweet(images: images, text: tweetTextController.text.trim(), userModel: widget.userModel, context: context);
                if(tweet.clear == true)
                  {
                    setState(() {
                      tweetTextController.clear();
                      images = [];
                    });
                  }

              }, child: Text("tweet")),
          SizedBox(width: 10,),

        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10,),
                  CircleAvatar(
                    radius:20,
                    backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
                    backgroundImage: widget.userModel.profilePic != null
                        ? NetworkImage(widget.userModel.profilePic!)
                        : null,
                    child: widget.userModel.profilePic == null
                        ? Icon(Icons.person_outline)
                        : null,
                  ),
                  SizedBox(width: 10,),
                  Expanded(child:
                  TextField(
                    controller: tweetTextController,
                    style: TextStyle(



                    ),
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: "What's happening?",
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                  )
                  )



                ],
              ),
              if(images.isNotEmpty)
             CarouselSlider(
                 items: images.map((file) {
                   return  Container(
                     margin: EdgeInsets.symmetric(horizontal: 5),
                     width: MediaQuery.of(context).size.width,
                       child: Image.file(file));
                 }
                  ).toList(),
                 options: CarouselOptions(
                   height: 400,
                   enableInfiniteScroll: false
                 )
             )

            ],
          ),
        ),
      ),
      bottomNavigationBar:
         Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black,
                width: 0.3
              )
            )

          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15
            ),
            child: Row(
              children: [
                IconButton(onPressed: ()async{
                  // select multiple files

                  images = await pickImages();
                  setState(() {});

                }, icon: Icon(Icons.photo_album)),
                SizedBox(width: 10,),
                IconButton(onPressed: (){

                }, icon: Icon(Icons.photo_filter)),
                SizedBox(width: 10,),
                IconButton(onPressed: (){

                }, icon: Icon(Icons.emoji_emotions))

              ],
            ),
          ),
      ),

    );
  }

  Future<List<File>> pickImages() async
  {
    List<File> images=[];// create a empty list
    final ImagePicker picker =ImagePicker();
    final  imagefile= await picker.pickMultiImage(); //pic multiple imges
    if(imagefile.isNotEmpty)
      {
        for(final image in imagefile)
          {
            images.add(File(image.path));
          }
      }

    return images;
    

  }
}
