import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../../utils.dart';
import '../model/storyModel.dart';

class StatusScreen extends StatefulWidget {
  final Status status;
  const StatusScreen({super.key, required this.status});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}
class _StatusScreenState extends State<StatusScreen> {

  StoryController controller= StoryController();
  List<StoryItem> storyItems =[];


  void initStoryPageItem()
  {
    for(int i=0; i<widget.status.statusUrl!.length; i++)
      {
        storyItems.add(
          StoryItem.pageImage(url: widget.status.statusUrl[i], controller: controller)
        );
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initStoryPageItem();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storyItems.isEmpty ? Center(child: Text("Loding...",style: TextStyle(fontSize: 16),)):
          StoryView(storyItems: storyItems,
              controller: controller,
            onVerticalSwipeComplete: (direction){
            if(direction == Direction.down){

              Navigator.pop(context);
            }
            },
          )
      ,
    );
  }
}
