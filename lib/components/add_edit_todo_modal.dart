import 'package:flutter/material.dart';

class AddEditTodoModal extends StatelessWidget {

  int? id;
  bool isNew;
  String? uuid;
  String? text;
  final void Function({int? itmId, String? uuid, required String text, bool isNew}) onSuccess;

  AddEditTodoModal({
    Key? key,
    required this.id,
    this.uuid,
    this.isNew = false,
    this.text,
    required this.onSuccess
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String todoText = '';
    return AlertDialog(
      title: Text('${isNew ? 'Add' : 'Edit'} item'),
      content: TextField(
        controller: TextEditingController(text: text),
        onChanged: (String value) {
          todoText = value;
        },
      ),
      actions: [
        Row(
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
                onPressed: () {
                  onSuccess(itmId: id, uuid: uuid, text: todoText, isNew: isNew);
                  Navigator.of(context).pop();
                },
                child: Text(isNew ? 'Add' : 'Edit')),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ],
    );
  }
}
