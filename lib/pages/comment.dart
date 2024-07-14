
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/home.dart';

class Comment extends StatefulWidget {
  const Comment({super.key});

  @override
  State<Comment> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<Comment> {
  final List<CommentModel> comments = [
    CommentModel(
      username: "Norman Henry",
      content: "Took my dog for a walk in my favorite park this afternoon. Look who we found! Haven't seen @andytlr in a long time.",
      avatarUrl: "https://cdn.pixabay.com/photo/2017/09/26/17/34/ballet-2789416_640.jpg", // Local asset
      isLiked: false,
    ),
    CommentModel(
      username: "Eliza Garza",
      content: "Nothing special !!",
      avatarUrl: "https://cdn.pixabay.com/photo/2017/09/26/17/34/ballet-2789416_640.jpg",
      isLiked: false,
    ),
    CommentModel(
      username: "Stanley Campbell",
      content: "Ok Bro, See u soon ..",
      avatarUrl: "https://cdn.pixabay.com/photo/2017/09/26/17/34/ballet-2789416_640.jpg",
      isLiked: false,
    ),
    CommentModel(
      username: "Cody Gonzalez",
      content: "Meet Tomorrow",
      avatarUrl: "https://cdn.pixabay.com/photo/2017/09/26/17/34/ballet-2789416_640.jpg",
      isLiked: false,
    ),
    CommentModel(
      username: "Jonathan Farmer",
      content: "Sure Bro ...",
      avatarUrl: "https://cdn.pixabay.com/photo/2017/09/26/17/34/ballet-2789416_640.jpg",
      isLiked: false,
    ),
    CommentModel(
      username: "Russell Hayes",
      content: "Go Ahead !!",
      avatarUrl: "https://cdn.pixabay.com/photo/2017/09/26/17/34/ballet-2789416_640.jpg",
      isLiked: false,
    ),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            body: Row(
              children: [
                Expanded(child: HomeScreen()),
                VerticalDivider(width: 1),
                Expanded(child: CommentScreen(comments: comments, controller: _controller)),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("Comments"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.lightGreenAccent,
            ),
            body: CommentScreen(comments: comments, controller: _controller),
          );
        }
      },
    );
  }
}

class CommentModel {
  final String username;
  final String content;
  final String avatarUrl;
  bool isLiked;

  CommentModel({
    required this.username,
    required this.content,
    required this.avatarUrl,
    this.isLiked = false,
  });
}

class CommentScreen extends StatelessWidget {
  final List<CommentModel> comments;
  final TextEditingController controller;

  CommentScreen({required this.comments, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return CommentWidget(
                comment: comments[index],
                onLike: () {
                  // Update the comment's isLiked property
                  comments[index].isLiked = !comments[index].isLiked;
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Comment something...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // Clear the text field after sending the comment
                  controller.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CommentWidget extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onLike;

  CommentWidget({required this.comment, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: comment.avatarUrl.startsWith('assets/')
            ? AssetImage(comment.avatarUrl)
            : NetworkImage(comment.avatarUrl) as ImageProvider,
      ),
      title: Text(comment.username),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.content),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TextButton(onPressed: () {}, child: Text("Reply")),
                TextButton(onPressed: () {}, child: Text("Hide")),
                TextButton(onPressed: () {}, child: Text("See Translation")),
              ],
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          comment.isLiked ? Icons.favorite : Icons.favorite_border,
          color: comment.isLiked ? Colors.red : null,
        ),
        onPressed: onLike,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
