import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/components/add_edit_todo_modal.dart';
import 'package:flutter_todo/components/todo_item.dart';
import 'package:flutter_todo/layouts/todos_layout.dart';

class ListOnFB extends StatefulWidget {
  const ListOnFB({Key? key}) : super(key: key);

  @override
  State<ListOnFB> createState() => _ListOnFBState();
}

class _ListOnFBState extends State<ListOnFB> {

  @override
  void initState() {
    super.initState();
  }

  onRemove(String? id) {
    FirebaseFirestore.instance.collection('todos').doc(id).delete();
  }
  onSelect(String? id, bool value) {
    FirebaseFirestore.instance.collection('todos').doc(id).update({'selected': !value});
  }

  addEditTodo({int? itmId, String? uuid, required String text, bool isNew = true}) {
    if (isNew) {
      FirebaseFirestore.instance.collection('todos').add({
        'text': text,
        'selected': false,
      });
    } else {
      FirebaseFirestore.instance.collection('todos').doc(uuid).update({'text': text,});
    };

  }
  showAddEditModal(
      {bool isNew = true, String text = '', int? indexForEdit, String? uuid}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddEditTodoModal(
              isNew: isNew,
              text: text,
              id: indexForEdit,
              uuid: uuid,
              onSuccess: addEditTodo
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return TodosLayout(
      title: 'Todo list on fair base',
      showAddEditModal: showAddEditModal,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('todos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) return const Text('No data');
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var myItem = snapshot.data?.docs[index];

                return Dismissible(
                  key: Key(myItem!.id),
                  child: TodoItem(
                    text: myItem.get('text'),
                    itemId: index,
                    isSelected: myItem.get('selected'),
                    onEdit: ({required int idItem, required String text}){
                      showAddEditModal(isNew: false, uuid: myItem.id, text: myItem.get('text') );

                    },
                    onRemove: ({required int idItem}) => {
                      // this hack for not doing redesign  TodoItem which based on
                      // int index for 'to-do on state'
                      onRemove(myItem.id)
                    },
                    onSelect: ({required int idItem}) => {onSelect( myItem.id, myItem.get('selected'))},
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      FirebaseFirestore.instance.collection('todos').doc(snapshot.data?.docs[index].id).delete();
                    }
                  },
                );
              });
        },
      ),
    );
  }
}
