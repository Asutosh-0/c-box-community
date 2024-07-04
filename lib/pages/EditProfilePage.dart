import 'package:flutter/material.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  @override
  Widget build(BuildContext context) {
    String? gender;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
        leading: Icon(Icons.arrow_back),
        actions: [

        ],
      ),
      body: SingleChildScrollView(
        child: Container(

          alignment: Alignment.center,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 64,
                    color: Colors.lightBlue,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: 128, // 2 * radius of CircleAvatar
                      height: 128,

                      decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.5), // Shadow color with opacity
                        //     spreadRadius: 3, // Spread radius
                        //     blurRadius: 1, // Blur radius
                        //     offset: Offset(5, 5), // Offset in x and y directions
                        //   ),
                        // ],

                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white, // border color
                          width: 4.0, // border width
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.white54,
                        // backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: MediaQuery.of(context).size.width*0.55,
                    child: IconButton(
                      onPressed: (){
                        print("Image ");
                      },
                      icon: const Icon(Icons.add_a_photo),

                    ),
                  )

                ],
              ),
              Text("change Picture",style: TextStyle(fontSize:14 ,fontWeight: FontWeight.bold,color: Colors.black,
                shadows: [
                Shadow(
                  // offset: Offset(2.0, 2.0),
                  blurRadius: 1.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],),),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                // color: Colors.blueAccent,

                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("User Name",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(height: 5,),
                    Container(
                      height: 45,
                      color: Colors.lightBlue.withOpacity(0.1),
                      child: TextField(
                        decoration:InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),

                          )

                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Gender",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(height: 5,),
                    Container(
                      height: 45,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 1,
                          color: Colors.black54,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: gender,
                          hint: Text(
                            "Select Gender",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                          items: <String>['Male', 'Female']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 12,),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              gender = newValue;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Job Title",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(height: 5,),
                    Container(
                      height: 45,
                      color: Colors.lightBlue.withOpacity(0.1),

                      child: TextField(
                        decoration:InputDecoration(

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),

                            )

                        ),

                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Bio",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(height: 5,),
                    Container(
                      height: 45,
                      color: Colors.lightBlue.withOpacity(0.1),

                      child: TextField(
                        decoration:InputDecoration(

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),

                            )

                        ),

                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Address",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(height: 5,),
                    Container(height: 70,

                      color: Colors.lightBlue.withOpacity(0.1),

                      child: TextField(
                        decoration:InputDecoration(

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),

                            )

                        ),
                        minLines: 2,
                        maxLines: 2,

                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: ElevatedButton(

                          onPressed: (){

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

    );
  }
}
