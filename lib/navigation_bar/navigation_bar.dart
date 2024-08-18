import 'package:c_box/models/user_model.dart';
import 'package:c_box/pages/Screens/TweetShowScreen.dart';
import 'package:c_box/pages/Screens/ReelsScreen.dart';
import 'package:c_box/pages/Screens/post.dart';
import 'package:c_box/pages/Screens/profile.dart';
import 'package:c_box/pages/Screens/search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../pages/Screens/home.dart';

  // ignore: camel_case_types
  class Navigation_Bar extends StatefulWidget {

    final UserModel userModel ;
    const Navigation_Bar({super.key, required this.userModel});

    @override
    State<Navigation_Bar> createState() => _Navigation_Bar();
  }

  // ignore: camel_case_types
  class _Navigation_Bar extends State<Navigation_Bar> {
     List<Widget> get _screens => [
      
       Home(userModel: widget.userModel,),
      Search(userModel: widget.userModel,),
      Post(userModel:  widget.userModel,),
       ReelsScreen(userModel: widget.userModel,),
       TweetShowScreen(),
    ];


    int selectedIndex = 0;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: const Color(0xFF7B66FF),
        //   leading: Image.asset('c_box.png',width: 100,height: 200,),
        //   // title: const Text('Navigation Bar Demo'),
        // ),
        bottomNavigationBar: MediaQuery.of(context).size.width < 600
            ? BottomNavigationBar(
                currentIndex: selectedIndex,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.indigoAccent,
                onTap: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                backgroundColor: const Color(0xFF7B66FF), // Set the background color here
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: 'Search'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle,size: 30,), label: 'Add Post'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.play_arrow_outlined), label: 'Reels'),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.twitter), label: 'Tweets'),
                ],
              )
            : null,
        body: Row(
          
          children: [
            if (MediaQuery.of(context).size.width >= 600)
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                // backgroundColor: const Color(0xFF7B66FF), // Set the background color here
                backgroundColor: Colors.blue.withOpacity(0.2),
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    selectedIcon: Icon(Icons.home_filled),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.search),
                    selectedIcon: Icon(Icons.search_rounded),
                    label: Text('Search'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.add,size: 30,),
                    selectedIcon: Icon(Icons.add_circle),
                    label: Text('Add Post'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.play_arrow_outlined),
                    selectedIcon: Icon(Icons.play_arrow),
                    label: Text('Reels'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(FontAwesomeIcons.twitter),
                    selectedIcon: Icon(FontAwesomeIcons.twitter),
                    label: Text('Tweets'),
                  ),
                ],

                leading: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                        children: [
                          Image.asset('c_box.png',width: 50,),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Column(
                                children: [
                                  Text("C Box",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                  ),
                                  Text("Community",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                  ),
                            
                                ]
                              ),
                            ),
                          )
                          ],
                          ),
                      ),
                    )
                  ]
                ),
              ),
            Expanded(
              child: _screens[selectedIndex],
            )
          ],
        ),
      );
    }
  }
