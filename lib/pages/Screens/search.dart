import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/Screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final UserModel  userModel;
   const Search({super.key, required this.userModel});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? searchUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 30),
            SizedBox(
              height: 40,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      searchUser = val;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF0FFFF6),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    hintText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 21,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("UserDetail")
                      .where("userName", isGreaterThanOrEqualTo: searchUser ?? "")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot qsnap = snapshot.data as QuerySnapshot;
                        if (qsnap.docs.isNotEmpty) {
                          return ListView.builder(
                            itemCount: qsnap.docs.length,
                            itemBuilder: (context, index) {
                              UserModel userModel = UserModel.fromMap(
                                qsnap.docs[index].data() as Map<String, dynamic>,
                              );
                              return InkWell(
                                onTap: () {
                                  print(userModel.userName);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(userModel: userModel,selfUser: widget.userModel,)));

                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: userModel.profilePic != null
                                        ? NetworkImage(userModel.profilePic!)
                                        : null,
                                    child: userModel.profilePic == null
                                        ? Icon(Icons.person)
                                        : null,
                                  ),
                                  title: Text(userModel.userName ?? 'No Username'),
                                  subtitle: Text(userModel.fullName ?? 'No Full Name'),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text("No data found"));
                        }
                      } else {
                        return Center(child: Text("No data"));
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
