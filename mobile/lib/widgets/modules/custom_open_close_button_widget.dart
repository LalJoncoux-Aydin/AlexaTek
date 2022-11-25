import 'package:flutter/material.dart';

class CustomOpenCloseButton extends StatelessWidget {
  const CustomOpenCloseButton({Key? key, required this.id, required this.setLedOn, required this.isSwitched}) : super(key: key);

  final int id;
  final Function(bool) setLedOn;
  final bool isSwitched;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Colors.blue.withOpacity(0.04);
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed))
                  return Colors.blue.withOpacity(0.12);
                return null; // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () => setLedOn(isSwitched),
          child: (isSwitched == true ? const Text('On') : const Text('Off')),
      )
    );
  }
}
