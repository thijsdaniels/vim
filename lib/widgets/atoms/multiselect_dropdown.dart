import 'package:flutter/material.dart';

class MultiselectDropdown<T> extends StatelessWidget {
  final List<({T value, String name})> items;
  final List<T> selected;
  final Function(List<T>) onChanged;
  final InputDecoration? decoration;
  final Widget? icon;

  const MultiselectDropdown({
    Key? key,
    required this.items,
    required this.selected,
    required this.onChanged,
    this.decoration,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: decoration,
      icon: icon,
      onChanged: (_) {},
      value: selected[0],
      selectedItemBuilder: _selectedItemBuilder,
      items: items.map(_dropdownMenuItem).toList(),
    );
  }

  List<Widget> _selectedItemBuilder(context) => items
      .map(
        (item) => Text(
          items
              .where((item) => selected.contains(item.value))
              .map((item) => item.name)
              .join(", "),
        ),
      )
      .toList();

  DropdownMenuItem<T> _dropdownMenuItem(({T value, String name}) item) =>
      DropdownMenuItem<T>(
        value: item.value,
        onTap: () {
          var newSelection = selected;
          selected.contains(item.value)
              ? newSelection.remove(item.value)
              : newSelection.add(item.value);
          onChanged(newSelection);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.name),
            if (selected.contains(item.value)) const Icon(Icons.check),
          ],
        ),
      );
}
