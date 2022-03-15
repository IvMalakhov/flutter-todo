import 'package:flutter/material.dart';
import 'package:flutter_todo/components/todo_item.dart';

class ListOnState extends StatefulWidget {
  const ListOnState({Key? key}) : super(key: key);

  @override
  State<ListOnState> createState() => _ListOnStateState();
}

class _ListOnStateState extends State<ListOnState> {
  List todoList = [];
  String _newTodo = '';

  @override
  void initState() {

    super.initState();
    todoList.addAll(['Milk', 'Wash dishes', 'buy carrot']);
  }

  void _showAddEditModal(
      {bool edit = false, String text = '', int? indexForEdit}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${edit ? 'Edit' : 'Add'} item'),
            content: TextField(
              controller: TextEditingController(text: text),
              onChanged: (String value) {
                _newTodo = value;
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
                        if (edit && indexForEdit != null) {
                          setState(() {
                            todoList[indexForEdit] = _newTodo;
                          });
                        } else {
                          setState(() {
                            todoList.add(_newTodo);
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add')),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ],
          );
        });
  }

  void _openMenu() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: Text('Main Page')),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Text('another menu items'),
          ],
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    void onEdit({required int idItem, required String text}) {
      _showAddEditModal(
          text: todoList[idItem],
          edit: true,
          indexForEdit: idItem);
    }
    void onRemove({required int idItem}) {
      setState(() {
        todoList.removeAt(idItem);
      });
    }


    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('ToDo list on state'),
        actions: [IconButton(onPressed: _openMenu, icon: Icon(Icons.menu))],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(todoList[index]),
              child: TodoItem(
                text: todoList[index],
                itemId: index,
                isSelected: false,
                onEdit: onEdit,
                onRemove: onRemove,
                onSelect: ({required int idItem}) {},
              ),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                onRemove(idItem: index);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditModal();
        },
        child: Icon(Icons.add_box_outlined),
      ),
    );
  }
}

// Icon(Icons.star, size: 50, color: Theme.of(context).colorScheme.secondary,)
