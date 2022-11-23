import 'package:flutter/material.dart';

import '../../utils/global_variables.dart';

class CustomValidationButton extends StatelessWidget {
  const CustomValidationButton({
    Key? key,
    required this.displayText,
    required this.formKey,
    required this.loadingState,
    required this.onTapFunction,
    required this.buttonColor,
  }) : super(key: key);

  final String displayText;
  final GlobalKey<FormState> formKey;
  final bool loadingState;
  final void Function(GlobalKey<FormState>, BuildContext? context) onTapFunction;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            backgroundColor: buttonColor,
        ),
        onPressed: () => onTapFunction(formKey, context),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: !loadingState
              ? Text(displayText, style: Theme.of(context).textTheme.button)
              : CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
