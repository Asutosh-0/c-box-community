import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback onTap;
   OptionItem({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            icon,
            Flexible(child: Text("     $text",style: TextStyle(fontSize: 16,color: Colors.black87,letterSpacing: 0.5),))
          ],
        ),
      ),
    );
  }
}
