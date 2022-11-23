import 'package:flutter/cupertino.dart';

class DoorScreen extends StatefulWidget {
  const DoorScreen({Key? key}) : super(key: key);

  @override
  State<DoorScreen> createState() => _DoorScreenState();
}

class _DoorScreenState extends State<DoorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Door"),
    );
  }
}
