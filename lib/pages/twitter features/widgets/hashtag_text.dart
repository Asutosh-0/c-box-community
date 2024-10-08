import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HashtagText extends StatelessWidget {
  final String text;
  const HashtagText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textspans =[];

    text.split(" ").forEach((element){

      if(element.startsWith('#'))
        {
          textspans.add(
            TextSpan(
              text: "$element ",
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.bold
              )
            )
          );
        }
      else if( element.startsWith("www.") ||  element.startsWith("https://"))
        {
          textspans.add(
              TextSpan(
                  text: "$element ",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  )
              )
          );

        }
      else{
        textspans.add(
            TextSpan(
                text: "$element ",
                style: const TextStyle(
                  color: Colors.black,
                    fontSize: 14,

                )
            )
        );

      }
    } );
    return  RichText(text: TextSpan(
      children: textspans
    ));
  }
}
