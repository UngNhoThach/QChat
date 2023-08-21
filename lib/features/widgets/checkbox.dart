import 'package:flutter/material.dart';
import 'package:qchat/constants/textString.dart';

class PasswordCheckBox extends StatefulWidget {
  final String labelText;
  final ValueChanged<bool> onChanged;

  const PasswordCheckBox({
    super.key,
    required this.labelText,
    required this.onChanged,
  });

  @override
  _PasswordCheckBoxState createState() => _PasswordCheckBoxState();
}

class _PasswordCheckBoxState extends State<PasswordCheckBox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.labelText, style: textString.text_Body),
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
        });
      },
    );
  }
}
