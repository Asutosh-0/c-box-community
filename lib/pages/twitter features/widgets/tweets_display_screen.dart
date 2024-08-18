import 'package:c_box/pages/twitter%20features/widgets/tweet_Card.dart';
import 'package:flutter/cupertino.dart';

class TweetsDisplayScreen extends StatelessWidget {
  const TweetsDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

        itemBuilder: (context,index){
          return TweetCard();

    });
  }
}
