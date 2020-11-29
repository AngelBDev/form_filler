import 'package:flutter/material.dart';

class AddedField extends StatelessWidget {
  const AddedField({
    Key key,
    this.title,
    this.onTapField,
    this.onTapRemove,
  }) : super(key: key);

  final Widget title;

  final Function() onTapField;
  final Function() onTapRemove;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTapField,
      title: title,
      trailing: IconButton(
        onPressed: onTapRemove,
        icon: Icon(
          Icons.remove_circle,
          color: Colors.red.shade300,
        ),
      ),
    );
  }
}
