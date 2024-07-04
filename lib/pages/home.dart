import 'package:c_box/pages/comment.dart';
import 'package:c_box/pages/signin.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {

  final List<Map<String, dynamic>> searchUsers = [
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/03/15/17/07/girl-1258727_640.jpg',
      'username': 'johndoe',
      'fullName': 'John Doe',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2017/09/26/17/34/ballet-2789416_640.jpg',
      'username': 'janedoe',
      'fullName': 'Jane Doe',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2019/05/28/05/06/female-4234344_640.jpg',
      'username': 'mikebrown',
      'fullName': 'Mike Brown',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/10/20/08/36/woman-1754895_640.jpg',
      'username': 'emilyjones',
      'fullName': 'Emily Jones',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2019/07/25/10/43/ballerina-4362282_640.jpg',
      'username': 'alexsmith',
      'fullName': 'Alex Smith',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/03/15/17/07/girl-1258727_640.jpg',
      'username': 'sarahwilliams',
      'fullName': 'Sarah Williams',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/07/08/23/17/girl-1505407_640.jpg',
      'username': 'davidlee',
      'fullName': 'David Lee',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2023/01/01/16/35/street-7690347_640.jpg',
      'username': 'laurajohnson',
      'fullName': 'Laura Johnson',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/10/20/08/36/woman-1754895_640.jpg',
      'username': 'emilyjones',
      'fullName': 'Emily Jones',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2019/07/25/10/43/ballerina-4362282_640.jpg',
      'username': 'alexsmith',
      'fullName': 'Alex Smith',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/03/15/17/07/girl-1258727_640.jpg',
      'username': 'sarahwilliams',
      'fullName': 'Sarah Williams',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2016/07/08/23/17/girl-1505407_640.jpg',
      'username': 'davidlee',
      'fullName': 'David Lee',
    },
    {
      'profileImageUrl': 'https://cdn.pixabay.com/photo/2023/01/01/16/35/street-7690347_640.jpg',
      'username': 'laurajohnson',
      'fullName': 'Laura Johnson',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // var Size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 5,
        backgroundColor: Colors.purple[50],
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Material(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset('assets/c_box.png'),
          ),
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "C-Box",
              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
            ),
            Text(
              "community",
              style: TextStyle(
                fontSize: 11,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.purple[50],
            radius: 15,
            child: const Icon(Icons.notification_add, color: Colors.deepPurple),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Colors.purple[50],
            radius: 15,
            child: Icon(Icons.send, color: Colors.deepPurple),
          ),
          SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(95),
          child: Container(
            height: 100,
            color: Colors.purple[30],
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Scroll horizontally
              itemCount: searchUsers.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> user = searchUsers[index];
                return Container(
                  width: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(user['profileImageUrl']),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user["username"],
                          maxLines: 1,
                          style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.6),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(searchUsers[index]["profileImageUrl"]), // profile image url
                              ),
                              title: Text(searchUsers[index]["username"]),
                              subtitle: Text(searchUsers[index]["fullName"]),
                              trailing: const Icon(Icons.menu),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.40,
                              child: Image(
                                image: NetworkImage(searchUsers[index]["profileImageUrl"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 15,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.favorite_outline, color: Colors.purpleAccent),
                                    onPressed: () {
                                      print('Favorite clicked at index $index');
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignIn()),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 5),
                                  IconButton(
                                    icon: Icon(Icons.comment_outlined, color: Colors.purpleAccent),
                                    onPressed: () {
                                      print('Comment clicked at index $index');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const Comment()),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 5),
                                  IconButton(
                                    icon: Icon(Icons.send_outlined, color: Colors.purpleAccent),
                                    onPressed: () {
                                      print('Send clicked at index $index');
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 6),
                            Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${3323} likes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                      Container(
                                        child: Text(
                                          "having a great day with blowing a mind",
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Text("10 November 2023"),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  IconButton(
                                    onPressed: () {
                                      print('Save clicked at index $index');
                                    },
                                    icon: Icon(Icons.save_alt_outlined),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: searchUsers.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void main() => runApp(MaterialApp(home: Home()));
