import 'package:c_box/models/user_model.dart';
import 'package:c_box/navigation_bar/navigation_bar.dart';
import 'package:c_box/services/Authentication.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatefulWidget {
  final UserModel userModel;
  const UserDetailScreen({super.key, required this.userModel});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {

  TextEditingController fullNameC= TextEditingController();
  TextEditingController bioC= TextEditingController();
  TextEditingController addressC= TextEditingController();

  void showLoading(){
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

  void showUpdate(String message)
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



  void SkipButtonClick() async{

    showLoading();
    String response = await   SaveUserModel(widget.userModel!);

    if(response == "success"){

      print("successfully user create ");
      Navigator.pop(context);
      showUpdate("successfully create account");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Navigation_Bar(userModel: widget.userModel,) ));
    }
    else{

      print(response);
      showUpdate(response);
      Navigator.pop(context);

    }


  }

  void SaveButtonClick()async{

    String fullName = fullNameC.text.trim();
    String bio= bioC.text.trim();
    String address= addressC.text.trim();

    if(fullName.isNotEmpty || bio.isNotEmpty || address .isNotEmpty ){

      widget.userModel.fullName = fullName;
      widget.userModel.bio = bio;
      widget.userModel.address= address;

      showLoading();
      String res =  await SaveUserModel(widget.userModel!);
      if(res =="success")
        {
          Navigator.pop(context);
          showUpdate("successfully create account");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Navigation_Bar(userModel: widget.userModel,) ));

        }
      else{
        print(res);
        showUpdate(res);
        Navigator.pop(context);
      }

    }
    else
      {
        print("plesed enter the field");
      }


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints){
          double width= constraints.maxWidth;
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: width> 550 ? 500 : width,
                padding:  EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Container(
                            width: 35,
                            height: 35,
                            child: Image.asset("assets/c_box.png",fit: BoxFit.cover,)
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("C-Box",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            Text("C O M M U N I T Y",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11,color: Colors.black87),)
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 30,),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: InkWell(
                        onTap: (){
                          // take profile pic

                        },
                        child: CircleAvatar(
                          child: Icon(Icons.person_outline_rounded,size: 30,),
                        ),
                      ),
                    ),

                    Text("Profile pic",style: TextStyle(fontSize: 12,color: Colors.black),),

                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Name"),
                      ],
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: TextField(
                        controller: fullNameC,
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          hintText: "enter your full name",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black45),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Bio"),
                      ],
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: TextField(
                        controller: bioC,
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          hintText: "write something about your self..",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black45),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Address"),
                      ],
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black45, width: 1),
                      ),
                      child: TextField(
                        controller: addressC,
                        cursorColor: Colors.black87,
                        cursorWidth: 1,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black45),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30,),

                    Container(

                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child:
                       Row(
                         children: [

                           Expanded(child: Container(
                             margin: EdgeInsets.symmetric(horizontal: 5),
                             child: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(4)
                                 ),
                                 backgroundColor: Colors.black
                               ),
                               onPressed: (){

                                 SkipButtonClick();
                                 print("skip button click");

                               },
                               child: Text("skip",style: TextStyle(color: Colors.white),),
                             ),
                           )),
                           SizedBox(width: 10,),
                           Expanded(child: Container(
                             margin: EdgeInsets.symmetric(horizontal: 5),
                             child: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(4)
                                 ),
                                 backgroundColor: Colors.black
                               ),
                               onPressed: (){
                                 SaveButtonClick();
                                 print("save button clicked");

                               },
                               child: Text("save",style: TextStyle(color: Colors.white),),
                             ),
                           ))
                         ],
                       ),
                    )










                  ],


                ),


              ),
            ) ,
          );
        },
      ),

    );
  }
}
