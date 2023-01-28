import 'package:flutter/material.dart';

class WithConfirmationDialog extends StatelessWidget {
  final String? title;
  final String description;
  final Widget Function(BuildContext, Future<bool> Function()) builder;

  const WithConfirmationDialog({
    super.key,
    required this.builder,
    this.title,
    this.description = 'Are you sure?',
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, () async {
      bool? response = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: title != null ? Text(title!) : null,
            content: Text(description),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Confirm'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      return response ?? false;
    });
  }
}
