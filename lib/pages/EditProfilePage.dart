import 'dart:io';

import 'package:c_box/models/user_model.dart';
import 'package:c_box/services/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils.dart';

class Editprofile extends StatefulWidget {
  final UserModel userModel;
   Editprofile({super.key, required this.userModel});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  TextEditingController? fullNameC;

  TextEditingController? BioC;

  TextEditingController? AdddressC;

  XFile? _file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameC=TextEditingController(text: widget.userModel.fullName);
    BioC= TextEditingController(text: widget.userModel.bio);
    AdddressC= TextEditingController(text: widget.userModel.address);
  }


  void UpdateValue() async
  {
    String fullName = fullNameC!.text.trim();
    String bio= BioC!.text.trim();
    String address= AdddressC!.text.trim();

    if(fullName.isNotEmpty || bio.isNotEmpty || address .isNotEmpty ){

      widget.userModel.fullName = fullName;
      widget.userModel.bio = bio;
      widget.userModel.address= address;
      if(_file!= null)
        {
          showLoading(context);
          String res= await getProfilePicImageUrl(File(_file!.path), widget.userModel.uid!);
          Navigator.pop(context);
          if(res!= "Error")
            {
              widget.userModel.profilePic = res;
            }
        }


      showLoading(context);
      String res =  await UpdateUserModel(widget.userModel);
      if(res =="success")
      {
        Navigator.pop(context);
        showUpdate("Account update successfully",context);
      }
      else{
        print(res);
        showUpdate(res,context);
        Navigator.pop(context);
      }
      Navigator.pop(context);

    }
    else
    {
      print("plesed enter the field");
      showUpdate("plesed enter the field",context);

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black87,
        centerTitle: true,
        title: Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
        actions: [

        ],
      ),
      body: SingleChildScrollView(
        child: Container(

          alignment: Alignment.center,
          child: SizedBox(
            width: 600,
            child: Column(
              children: [
                SizedBox(height: 30,),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: InkWell(
                    onTap: ()async{
                      // take profile pic
                      XFile? file  = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if(file!= null)
                        {
                          setState(() {
                            _file= file;
                          });
                        }


                    },
                    child: CircleAvatar(
                      backgroundImage:_file== null ?widget.userModel.profilePic != null
                          ? NetworkImage(widget.userModel.profilePic!)
                          : null: FileImage(File(_file!.path)),
                      child:_file== null  ?widget.userModel.profilePic == null
                          ? Icon(Icons.person_outline_rounded)
                          : null : null,
                    ),
                  ),
                ),

                Text("change Picture",style: TextStyle(fontSize: 12,color: Colors.black),),


                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.blueAccent,

                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text("User Name"),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.black45, width: 1),
                        ),
                        child:Center(child: Text(widget.userModel.userName!,style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),))
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(" Full Name"),
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
                          controller:fullNameC ,

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
                          controller: BioC,
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
                          controller: AdddressC,
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

                      SizedBox(height: 10,),
                      Center(
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width*0.8,
                          child: ElevatedButton(

                            onPressed: (){
                              UpdateValue();
                            },
                            child: Text("update",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                              )

                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),




                    ],
                  ),
                )





              ],
            ),
          ),
        ),
      ),

    );
  }
}
