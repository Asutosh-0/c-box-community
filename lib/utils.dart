import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:loading_indicator/loading_indicator.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };


}

showLoading(BuildContext context){
  showDialog(context: context, builder: (context){
    return Center(
      child:SizedBox(
        width: 25, // Adjust the width to reduce the size
        height: 25, // Adjust the height to reduce the size
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          strokeWidth: 2.0,
        ),
      ),
    )
    ;
  });

  // return showLoaddingAmination(indicator: Indicator.ballPulseSync, showPathBackground: true);
}

void showUpdate(String message,BuildContext context)
{
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,style: TextStyle(color: Colors.white),
        ),

        duration: Duration(seconds: 3),
        // backgroundColor: Colors.blue.withOpacity(0.1)
        backgroundColor: Colors.transparent
        ,));

}

const List<Color> _kDefaultRainbowColors = const [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];
showSingleAnimationDialog(
    BuildContext context, Indicator indicator, bool showPathBackground) {

  return Container(
    child: Container(
      width: MediaQuery.of(context).size.width*0.3,
      height: 150,
      padding: const EdgeInsets.all(64),
      child: Center(
        child: LoadingIndicator(
          indicatorType: indicator,
          colors: _kDefaultRainbowColors,
          strokeWidth: 4.0,
          pathBackgroundColor:
          showPathBackground ? Colors.black45 : null,
        ),
      ),
    ),
  );
}

class showLoaddingAmination extends StatelessWidget {
  final Indicator indicator;
  final bool showPathBackground;
  const showLoaddingAmination({super.key, required this.indicator, required this.showPathBackground});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 180,
          height: 180,

          padding: const EdgeInsets.all(64),
          child: Center(
            child: LoadingIndicator(
              indicatorType: indicator,
              colors: _kDefaultRainbowColors,
              strokeWidth: 4.0,
              pathBackgroundColor:
              showPathBackground ? Colors.black45 : null,
            ),
          ),
        ),
      ),

    );
  }
}




 