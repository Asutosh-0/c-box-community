import 'package:any_link_preview/any_link_preview.dart';
import 'package:c_box/pages/twitter%20features/widgets/carouse_image.dart';
import 'package:c_box/pages/twitter%20features/widgets/hashtag_text.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
class TweetCard extends StatelessWidget {
  const TweetCard({super.key});

  @override
  Widget build(BuildContext context) {

    String text= "#chandra People are looking for leaders \nThey want answers\n There ain't no answer\n There ain't going to be any answer \n There never has been an answer\n That's the answer \n www.google.com";
    List<String> imageLink = [
"https://images.app.goo.gl/Kn5FnbkoAc9vqT869",
      "https://images.app.goo.gl/WiKvCwZUfEJwStFr9",
      "https://images.app.goo.gl/Hssc8pXampJ1tFE9A"



    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: CircleAvatar(
              
                child: Icon(Icons.person_outline_rounded),
                radius: 20,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Text( "chandra",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                        ),
                      ),

                      Text( "@chandra . ${
                          timeago.format(DateTime(2024,08 , 18 ,10,50,57,950),
                            locale: "en_short"
                          )
                      }",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        color: Colors.grey

                      ),
                      ),


                    ],
                  ),
                  //
                  // replied to
                  HashtagText(text: text),
                  // if(tweet.tweetType == TweetType.image)
                  // CarouseImage(imageLink: imageLink),

                  // if(tweet.link.isnotEmpty)...[
                    const SizedBox(height: 4,),
                    AnyLinkPreview(link: "https://${"www.google.com"}"),
                  // ]




                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
