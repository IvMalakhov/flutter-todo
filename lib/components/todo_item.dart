import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  bool isSelected;
  final String text;
  final int itemId;
  final void Function({required int idItem, required String text}) onEdit;
  final void Function({required int idItem}) onRemove;
  final void Function({required int idItem}) onSelect;

  TodoItem({
    Key? key,
    this.isSelected = false,
    required this.text,
    required this.itemId,
    required this.onEdit,
    required this.onRemove,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // cursor pointer for web
      child: GestureDetector(
        onTap: () => widget.onSelect(idItem: widget.itemId),
        child: Card(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Checkbox(
                        checkColor: Colors.white,
                        value: widget.isSelected,
                        onChanged: (bool? value) {
                          widget.onSelect(idItem: widget.itemId);
                        },
                      ),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          Text(widget.text),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => widget.onEdit(
                              text: widget.text, idItem: widget.itemId),
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () =>
                              widget.onRemove(idItem: widget.itemId),
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
            ],
          ),
        ),
      ),
    );
  }
}
