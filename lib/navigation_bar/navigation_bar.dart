import 'package:c_box/pages/Home.dart';
import 'package:c_box/pages/post.dart';
import 'package:c_box/pages/profile.dart';
import 'package:c_box/pages/search.dart';
import 'package:flutter/material.dart';

  // ignore: camel_case_types
  class Navigation_Bar extends StatefulWidget {
    const Navigation_Bar({super.key});

    @override
    State<Navigation_Bar> createState() => _Navigation_Bar();
  }

  // ignore: camel_case_types
  class _Navigation_Bar extends State<Navigation_Bar> {
    final List<Widget> _screens = [
      
      const Home(),
      Search(),
      const Post(),
      Container(
        color: Colors.redAccent,
      ),
      const Profile(),
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
                      icon: Icon(Icons.add), label: 'Add Post'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.play_arrow_outlined), label: 'Reels'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people), label: 'Profile'),
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
                backgroundColor: const Color(0xFF7B66FF), // Set the background color here
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
                    icon: Icon(Icons.add),
                    selectedIcon: Icon(Icons.add_circle),
                    label: Text('Add Post'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.play_arrow_outlined),
                    selectedIcon: Icon(Icons.play_arrow),
                    label: Text('Reels'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.people),
                    selectedIcon: Icon(Icons.people_alt),
                    label: Text('Profile'),
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
