import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

import '../story features/model/story.dart';

class HistorySingleStatusScreen extends StatefulWidget {
  final List<StatusItem> statusItem;
  const HistorySingleStatusScreen({super.key, required this.statusItem});

  @override
  State<HistorySingleStatusScreen> createState() => _HistorySingleStatusScreenState();
}

class _HistorySingleStatusScreenState extends State<HistorySingleStatusScreen> {
  StoryController controller= StoryController();

  List<StoryItem> storyItems =[];

  void initStoryPageItem()
  {
    for(int i=0; i<widget.statusItem.length; i++)
    {
      storyItems.add(
          StoryItem.pageImage(url: widget.statusItem[i].url!, controller: controller,caption: Text( widget.statusItem[i].caption!,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),))
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

