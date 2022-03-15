import 'package:flutter/material.dart';

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
    var map1 = Map<String, String>();
    map1['a'] = 'a1';
    map1['b'] = 'b2';
    print('map1--${map1}');
    print('map1--${map1.length}');

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('ToDo list on state'),
        actions: [IconButton(onPressed: _openMenu, icon: Icon(Icons.menu))],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            // print('context--${context}');
            return Dismissible(
              key: Key(todoList[index]),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(todoList[index]),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _showAddEditModal(
                                  text: todoList[index],
                                  edit: true,
                                  indexForEdit: index);
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                todoList.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete)),
                      ],
                    ),
                  ],
                ),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  setState(() {
                    todoList.removeAt(index);
                  });
                }
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
