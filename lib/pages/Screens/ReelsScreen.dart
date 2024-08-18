import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      PageView.builder(
        itemCount: 3,
          controller: PageController(initialPage: 0,viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){

            return Stack(
              children: [


              ],
            );

      }),
    );
  }
}
