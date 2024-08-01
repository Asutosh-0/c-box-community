import 'dart:io';
import 'package:flutter/material.dart';
import 'package:c_box/pages/Screens/video_player_widget.dart'; // Import for video playback
import '../../models/blog.dart';

class BlogDetailPage extends StatefulWidget {
  final Blog blog1;

  BlogDetailPage({required this.blog1});

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  late Blog blog;

  @override
  void initState() {
    super.initState();
    blog = widget.blog1;
  }

  void _toggleFollow() {
    setState(() {
      blog.isFollowed = !blog.isFollowed;
    });
  }

  void _toggleLike() {
    setState(() {
      blog.isLiked = !blog.isLiked;
      if (blog.isLiked) {
        blog.likeCount++;
      } else {
        blog.likeCount--;
      }
    });
  }

  void _saveBlog() {
    // Handle save logic here, e.g., save to local storage or database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Blog saved successfully', style: TextStyle(color: Colors.green)),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_placeholder.png'),
                  radius: 20.0,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.author,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      blog.date.toLocal().toString().split(' ')[0],
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _toggleFollow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blog.isFollowed ? Colors.grey : Colors.blue,
                  ),
                  child: Text(blog.isFollowed ? 'Unfollow' : 'Follow'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              blog.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 20),
            if (blog.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.file(
                  File(blog.imageUrl!),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                ),
              ),
            if (blog.videoUrl != null)
              VideoPlayerWidget(videoFile: File(blog.videoUrl!)),
            SizedBox(height: 20),
            Text(
              blog.content,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 20),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        blog.isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                        color: blog.isLiked ? Colors.red : Colors.grey,
                      ),
                      onPressed: _toggleLike,
                    ),
                    SizedBox(width: 5),
                    Text(blog.likeCount.toString()),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.comment_outlined),
                      onPressed: () {
                        // Navigate to comments page
                      },
                    ),
                    SizedBox(width: 5),
                    Text('0'), // Replace with actual comment count
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        // Share functionality
                      },
                    ),
                    SizedBox(width: 5),
                    Text('Share'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.save),
                      onPressed: _saveBlog,
                    ),
                    SizedBox(width: 5),
                    Text('Save'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
