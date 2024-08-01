import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/blog.dart'; // Import Blog class

class AddBlogPage extends StatefulWidget {
  @override
  _AddBlogPageState createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  XFile? _imageFile;
  XFile? _videoFile;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  void _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoFile = pickedFile;
      });
    }
  }

  void _addBlog() {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();
    final String imageUrl = _imageFile != null ? _imageFile!.path : '';
    final String videoUrl = _videoFile != null ? _videoFile!.path : '';

    final newBlog = Blog(
      title: title,
      content: content,
      author: 'Your Name', // Replace with actual author
      date: DateTime.now(),
      imageUrl: imageUrl.isNotEmpty ? imageUrl : null,
      videoUrl: videoUrl.isNotEmpty ? videoUrl : null,
    );

    Navigator.pop(context, newBlog); // Return the new blog to the previous screen

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Blog uploaded successfully', style: TextStyle(color: Colors.green)),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Blog'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _addBlog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            SizedBox(height: 10),
            if (_imageFile != null)
              Image.file(File(_imageFile!.path), height: 200),
            if (_videoFile != null)
              Text('Video selected: ${_videoFile!.name}'),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick Video'),
            ),
          ],
        ),
      ),
    );
  }
}
