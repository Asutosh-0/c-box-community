import 'package:c_box/pages/twitter%20features/widgets/tweets_display_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TweetShowScreen extends StatefulWidget {
  const TweetShowScreen({super.key});

  @override
  State<TweetShowScreen> createState() => _TweetShowScreenState();
}

class _TweetShowScreenState extends State<TweetShowScreen> {

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: AppBar(
        title: Text("tweets",style: TextStyle(fontSize: 19),),
        centerTitle: false,
        elevation: 2,
        shadowColor: Colors.black,

      ),

      body:  Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: TweetsDisplayScreen()


      ),
    );



  }
}
