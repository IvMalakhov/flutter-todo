import 'package:flutter/material.dart';
import 'package:flutter_todo/components/todo_item.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arr = <String>[];

    void myFunct2({required int idItem, required String text}) {
      print('idItem--${idItem} , text -- ${text}');
    }

    arr.addAll(['iteqable', 'some']);
    return Center(
      child: Column(
        children: arr
            .map((e) => Row(
                  children: [
                    Text('data'),
                    TodoItem(
                      text: e,
                      itemId: 17,
                      isSelected: e == 'some',
                      onEdit: myFunct2,
                      onRemove: ({required int idItem}) {},
                      onSelect: ({required int idItem}) {},
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
