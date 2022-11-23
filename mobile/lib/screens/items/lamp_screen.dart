import 'package:flutter/cupertino.dart';

class LampScreen extends StatefulWidget {
  const LampScreen({Key? key}) : super(key: key);

  @override
  State<LampScreen> createState() => _LampScreenState();
}

class _LampScreenState extends State<LampScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Lampe"),
    );
  }
}
