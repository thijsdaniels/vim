import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/extensions/string.dart';

class Icons8IconDropdownMenu extends StatelessWidget {
  final String? initialSelection;
  final TextEditingController? controller;
  final void Function(String? icon)? onSelected;

  const Icons8IconDropdownMenu({
    super.key,
    this.initialSelection,
    this.controller,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: initialSelection,
      controller: controller,
      menuHeight: 256,
      enableFilter: true,
      label: const Text('Icon'),
      dropdownMenuEntries: icons8Slugs.map((slug) {
        return DropdownMenuEntry(
          leadingIcon: Icons8Icon(slug, size: 32),
          value: slug,
          label: slug.fromKebabCase().toTitleCase(),
        );
      }).toList(),
      onSelected: onSelected,
    );
  }
}
