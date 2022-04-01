import 'package:flutter/material.dart';
import 'package:flutter_todo/components/todo_item.dart';
import 'package:flutter_todo/components/add_edit_todo_modal.dart';
import 'package:flutter_todo/layouts/todos_layout.dart';
import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

class ListOnState extends StatefulWidget {
  const ListOnState({Key? key}) : super(key: key);

  @override
  State<ListOnState> createState() => _ListOnStateState();
}

class Todo {
  String? uuid;
  String? text;
  bool selected = false;
  DateTime? dateOfCreation;

  Todo({this.text, DateTime? dateCreation}) {
    dateOfCreation = dateCreation ?? DateTime.now();
    uuid = _uuid.v4();
  }
}

class _ListOnStateState extends State<ListOnState> {
  List<Todo> todoList = [];
  String todoText = '';

  @override
  void initState() {
    super.initState();
    todoList.addAll([
      Todo(text: 'Buy Milk'),
      Todo(text: 'Wash dishes'),
    ]);
  }

  void addEditTodo({int? itmId, String? uuid, required String text, bool isNew = false}) {
    if (isNew) {
      setState(() {
        todoList.add(Todo(text: text));
      });
    } else if (itmId != null) {
      setState(() {
        todoList[itmId].text = text;
      });
    }
  }

  void showAddEditModal(
      {bool isNew = true, String text = '', int? indexForEdit}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddEditTodoModal(
              isNew: isNew, text: text, id: indexForEdit, onSuccess: addEditTodo);
        });
  }

  @override
  Widget build(BuildContext context) {
    void onEdit({required int idItem, required String text}) {
      showAddEditModal(
          text: todoList[idItem].text ?? '',
          isNew: false,
          indexForEdit: idItem);
    }

    void onRemove({required int idItem}) {
      setState(() {
        todoList.removeAt(idItem);
      });
    }

    void onSelect({required int idItem}) {
      setState(() {
        todoList[idItem].selected = !todoList[idItem].selected;
      });
    }

    return TodosLayout(
        title: 'Todo list on state',
        showAddEditModal: showAddEditModal,
        child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(todoList[index].uuid ?? '$index'),
                child: TodoItem(
                  text: todoList[index].text ?? '',
                  itemId: index,
                  isSelected: todoList[index].selected,
                  onEdit: onEdit,
                  onRemove: onRemove,
                  onSelect: onSelect,
                ),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  onRemove(idItem: index);
                },
              );
            }));
  }
}
