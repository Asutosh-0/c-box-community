import 'package:flutter/material.dart';

class TweetIconButton extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback onTap;

  const TweetIconButton({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          Container(margin:EdgeInsets.all(6),
            child: Text(text,style: TextStyle(fontSize: 14),))
        ],
      ),
    );
  }
}
