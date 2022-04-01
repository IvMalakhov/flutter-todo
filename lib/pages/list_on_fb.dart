import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/components/add_edit_todo_modal.dart';
import 'package:flutter_todo/components/todo_item.dart';
import 'package:flutter_todo/layouts/todos_layout.dart';
import 'package:flutter_todo/domain/base_user.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final BaseUser? user = Provider.of<BaseUser?>(context);

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
          'userId': user?.id,
        });
      } else {
        FirebaseFirestore.instance.collection('todos').doc(uuid).update({'text': text,});
      }
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

    return TodosLayout(
      title: 'Todo list on fair base',
      showAddEditModal: showAddEditModal,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('todos').where('userId', isEqualTo: user?.id).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) return const Text('No data');
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var item = snapshot.data?.docs[index];

                return Dismissible(
                  key: Key(item!.id),
                  child: TodoItem(
                    text: item.get('text'),
                    itemId: index,
                    isSelected: item.get('selected'),
                    onEdit: ({required int idItem, required String text}){
                      showAddEditModal(isNew: false, uuid: item.id, text: item.get('text') );

                    },
                    onRemove: ({required int idItem}) => {
                      // this hack for not doing redesign  TodoItem which based on
                      // int index for 'to-do on state'
                      onRemove(item.id)
                    },
                    onSelect: ({required int idItem}) => {onSelect( item.id, item.get('selected'))},
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      onRemove(item.id);
                    }
                  },
                );
              });
        },
      ),
    );
  }
}
