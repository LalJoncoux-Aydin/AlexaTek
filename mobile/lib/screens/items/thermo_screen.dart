import 'package:flutter/cupertino.dart';

class ThermoScreen extends StatefulWidget {
  const ThermoScreen({Key? key}) : super(key: key);

  @override
  State<ThermoScreen> createState() => _ThermoScreenState();
}

class _ThermoScreenState extends State<ThermoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Thermo"),
    );
  }
}
