import 'package:flutter/material.dart';

class BookMarkWidget extends StatefulWidget {
  const BookMarkWidget({super.key});

  @override
  State<BookMarkWidget> createState() => _BookMarkWidgetState();
}

class _BookMarkWidgetState extends State<BookMarkWidget> {
  bool flag = false;
  void toggleBookMark() {
    setState(() {
      flag != flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            flag? Icons.bookmark: Icons.bookmark_outline,
            color: Colors.blue,
          )),
    );
  }
}
