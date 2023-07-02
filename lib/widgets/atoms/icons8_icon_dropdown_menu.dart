import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class Icons8IconDropdownMenu extends StatelessWidget {
  final SearchController _controller = SearchController();

  final String? initialSelection;
  final void Function(String? icon)? onSelected;

  Icons8IconDropdownMenu({
    super.key,
    this.initialSelection,
    this.onSelected,
  }) {
    if (initialSelection != null) {
      _controller.text = initialSelection!.fromKebabCase().toTitleCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: _controller,
      builder: (context, controller) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Icon',
          suffixIcon: initialSelection != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icons8Icon(initialSelection!, size: 32),
                )
              : null,
        ),
        onTap: controller.openView,
      ),
      viewElevation: 4,
      isFullScreen: true,
      suggestionsBuilder: (context, controller) {
        return [
          const SizedBox(height: 6),
          ...icons8Slugs
              .where((slug) => slug
                  .toLowerCase()
                  .contains(controller.value.text.toLowerCase()))
              .map(
                (slug) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListSurface(
                    elevation: 8,
                    icon: Icons8Icon(slug),
                    title: slug.fromKebabCase().toTitleCase(),
                    onTap: () {
                      if (onSelected != null) {
                        onSelected!(slug);
                      }
                      controller.text = slug.fromKebabCase().toTitleCase();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
          const SizedBox(height: 6),
        ];
      },
    );

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
    //         elevation: 4.0,
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
