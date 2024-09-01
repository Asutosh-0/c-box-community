import 'dart:io';
import 'package:c_box/pages/story%20features/services/story_controller.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';

class SelectStatusScreen extends StatefulWidget {
  final File file;
  final UserModel userModel;
  const SelectStatusScreen({super.key, required this.file, required this.userModel});

  @override
  State<SelectStatusScreen> createState() => _SelectStatusScreenState();
}

class _SelectStatusScreenState extends State<SelectStatusScreen> {
  final statusCaptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("status",style: TextStyle(fontSize: 15,fontWeight:
        FontWeight.bold,color: Colors.black),),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child:
            AspectRatio(aspectRatio: 9/6,
              child: Image.file(widget.file),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:Border.all(
                              width: 1,
                              color: Colors.black87
                          ),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: SizedBox(

                        height: 50,
                        child: TextField(
                          style: TextStyle(fontSize: 16),
                          controller: statusCaptionController,
                          decoration: InputDecoration(
                              hintText: "add caption",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      StatusController().uploadStatus(file: widget.file,
                          caption:statusCaptionController.text.trim() ,
                          userModel: widget.userModel, context: context);

                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      )
    );
  }
}
