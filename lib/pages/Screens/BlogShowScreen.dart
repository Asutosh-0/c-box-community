// BlogShowScreen.dart
import 'package:flutter/material.dart';
import 'package:c_box/pages/Screens/video_player_widget.dart';
import 'package:share/share.dart';
import 'package:c_box/models/blog.dart';
import 'blog_detail_page.dart';
import 'package:c_box/pages/comment.dart';
import 'dart:io';

class BlogShowScreen extends StatefulWidget {
  final List<Blog> blogs;

  BlogShowScreen({Key? key, required this.blogs}) : super(key: key);

  @override
  _BlogShowScreenState createState() => _BlogShowScreenState();
}

class _BlogShowScreenState extends State<BlogShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
      ),
      body: ListView.builder(
        itemCount: widget.blogs.length,
        itemBuilder: (context, index) {
          final blog = widget.blogs[index];
          return BlogTile(
            blog: blog,
            onLike: (blogToLike) => _likeBlog(blogToLike),
            onShare: (blogToShare) => _shareBlog(blogToShare),
            onRepost: (blogToRepost) => _repostBlog(blogToRepost),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetailPage(blog1: blog),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _likeBlog(Blog blogToLike) {
    setState(() {
      blogToLike.isLiked = !blogToLike.isLiked;
      if (blogToLike.isLiked) {
        blogToLike.likeCount++;
      } else {
        blogToLike.likeCount--;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(blogToLike.isLiked ? 'You liked the post' : 'You unliked the post'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _shareBlog(Blog blogToShare) {
    Share.share(blogToShare.content);
  }

  void _repostBlog(Blog blogToRepost) {
    setState(() {
      blogToRepost.isReposted = !blogToRepost.isReposted;
      if (blogToRepost.isReposted) {
        blogToRepost.repostCount++;
      } else {
        blogToRepost.repostCount--;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(blogToRepost.isReposted ? 'You reposted the post' : 'You removed the repost'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final Blog blog;
  final void Function(Blog) onLike;
  final void Function(Blog) onShare;
  final void Function(Blog) onRepost;
  final VoidCallback onTap;

  BlogTile({
    required this.blog,
    required this.onLike,
    required this.onShare,
    required this.onRepost,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    blog.date.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            blog.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          if (blog.imageUrl != null)
            Image.file(File(blog.imageUrl!)),
          if (blog.videoUrl != null)
            VideoPlayerWidget(videoFile: File(blog.videoUrl!)),
          SizedBox(height: 10),
          Text(
            blog.content,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  blog.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: blog.isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: () => onLike(blog),
              ),
              Text(blog.likeCount.toString()),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => onShare(blog),
              ),
              IconButton(
                icon: Icon(blog.isReposted ? Icons.repeat : Icons.repeat_rounded),
                onPressed: () => onRepost(blog),
              ),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Comment()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  // Handle save action
                },
              ),
            ],
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
