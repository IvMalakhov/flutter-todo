import 'package:flutter/material.dart';
import 'package:flutter_todo/components/app_bar_wrapper.dart';

class TodosLayout extends StatelessWidget {
  final Widget child;
  String? title;
  void Function() showAddEditModal;

  TodosLayout(
      {Key? key,
      required this.child,
      this.title,
      required this.showAddEditModal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openMenu() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return AppBarWrapper();
      }));
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(title ?? ''),
        actions: [
          IconButton(onPressed: openMenu, icon: const Icon(Icons.menu))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 600),
            child: child,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddEditModal();
        },
        child: const Icon(Icons.add_box_outlined),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
