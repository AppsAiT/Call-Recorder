import 'package:flutter/material.dart';

class NewPassView extends StatefulWidget {
  const NewPassView({super.key});

  @override
  State<NewPassView> createState() => _NewPassViewState();
}

class _NewPassViewState extends State<NewPassView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("New Password Screen"),);
  }
}
