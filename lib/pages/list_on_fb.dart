import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/const/routs.dart';

class ListOnFB extends StatefulWidget {
  const ListOnFB({Key? key}) : super(key: key);

  @override
  State<ListOnFB> createState() => _ListOnFBState();
}

class _ListOnFBState extends State<ListOnFB> {
  List todoList = [];
  String _newTodo = '';

  @override
  void initState() {
    super.initState();
    todoList.addAll(['Milk', 'Wash dishes', 'Buy carrot']);
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, Routs.landing, (route) => false);
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
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('ToDo list'),
        actions: [IconButton(onPressed: _openMenu, icon: Icon(Icons.menu))],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) return Text('No data');
          return ListView.builder(
              // itemCount: todoList.length,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  // key: Key(todoList[index]),
                  key: Key(snapshot.data?.docs[index].id as String),
                  child: Card(
                    child: ListTile(
                      // title: Text(todoList[index]),
                      title: Text(snapshot.data?.docs[index].get('item')),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance.collection('items').doc(snapshot.data?.docs[index].id).delete();
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      FirebaseFirestore.instance.collection('items').doc(snapshot.data?.docs[index].id).delete();
                    }
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add item'),
                  content: TextField(
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
                              // setState(() {
                              //   todoList.add(_newTodo);
                              // });
                              FirebaseFirestore.instance.collection('items').add({'item': _newTodo});
                              Navigator.of(context).pop();
                            },
                            child: const Text('Add')),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.add_box_outlined),
      ),
    );
  }
}
