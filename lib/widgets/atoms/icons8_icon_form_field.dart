import 'package:flutter/material.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/search_form_field.dart';

class Icons8IconFormField extends StatelessWidget {
  final String? selection;
  final void Function(String? icon)? onSelected;

  const Icons8IconFormField({
    super.key,
    this.selection,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SearchFormField(
      decoration: InputDecoration(
        labelText: 'Icon',
        suffixIcon: selection != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icons8Icon(selection!, size: 32),
              )
            : null,
      ),
      options: icons8Slugs,
      selection: selection,
      onSelected: onSelected,
      titleBuilder: (slug) => slug.fromKebabCase().toTitleCase(),
      iconBuilder: (slug) => Icons8Icon(slug),
    );

    /// TODO: Decide whether I want to use `Autocomplete` for anything in the
    /// app and then either turn this into an abstract widget, or delete this
    /// code.
    // return Autocomplete<String>(
    //   optionsBuilder: (value) => icons8Slugs.where(
    //     (slug) => slug.fromKebabCase().toLowerCase().contains(
    //           value.text.toLowerCase(),
    //         ),
    //   ),
    //   initialValue: initialSelection != null
    //       ? TextEditingValue(
    //           text: initialSelection!.fromKebabCase().toTitleCase())
    //       : null,
    //   onSelected: onSelected,
    //   displayStringForOption: (slug) => slug.fromKebabCase().toTitleCase(),
    //   fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
    //     return TextFormField(
    //       controller: controller,
    //       decoration: InputDecoration(
    //         labelText: 'Icon',
    //         suffixIcon: initialSelection != null
    //             ? Padding(
    //                 padding: const EdgeInsets.all(16.0),
    //                 child: Icons8Icon(initialSelection!, size: 32),
    //               )
    //             : null,
    //       ),
    //       focusNode: focusNode,
    //       onFieldSubmitted: (String value) {
    //         onFieldSubmitted();
    //       },
    //     );
    //   },
    //   optionsViewBuilder: (context, onSelected, options) {
    //     return Align(
    //       alignment: Alignment.topLeft,
    //       child: Material(
    //         elevation: 4,
    //         child: SizedBox(
    //           height: 256.0,
    //           child: ListView.builder(
    //             padding: const EdgeInsets.all(8.0),
    //             itemCount: options.length,
    //             itemBuilder: (BuildContext context, int index) {
    //               final String slug = options.elementAt(index);
    //               return GestureDetector(
    //                 onTap: () {
    //                   onSelected(slug);
    //                 },
    //                 child: ListTile(
    //                   leading: Icons8Icon(slug, size: 32),
    //                   title: Text(
    //                     slug.fromKebabCase().toTitleCase(),
    //                     style: const TextStyle(overflow: TextOverflow.ellipsis),
    //                   ),
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
