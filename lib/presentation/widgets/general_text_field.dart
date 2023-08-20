import 'package:flutter/material.dart';

class GeneralTextField extends StatefulWidget {
  final Color color;
  final TextEditingController controller;
  final String labelText;
  final TextInputType? textInputType;

  const GeneralTextField({
    super.key,
    required this.color,
    required this.controller,
    required this.labelText,
    this.textInputType,
  });

  @override
  State<StatefulWidget> createState() => _GeneralTextFieldState();

}

class _GeneralTextFieldState extends State<GeneralTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(
          widget.labelText,
          overflow: TextOverflow.clip,
        ),
        labelStyle: TextStyle(
          color: widget.color,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.color,
          ),
        ),
        suffixIcon: widget.controller.text != ''
            ? IconButton(
          icon: Icon(
            Icons.highlight_remove,
            color: widget.color,
          ),
          onPressed: () => setState(() {
            widget.controller.text = '';
          }),
        )
            : null,
      ),
      keyboardType: widget.textInputType,
      controller: widget.controller,
      onChanged: (value) => setState(() => widget.controller),
    );
  }

}