import 'package:flutter/material.dart';
import 'dart:ui';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };


}

void showLoading(BuildContext context){
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
 