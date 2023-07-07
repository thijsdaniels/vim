import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/document.dart';

class DebugView extends StatelessWidget {
  const DebugView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: const Center(child: MigrateButton()),
    );
  }
}

class MigrateButton extends StatelessWidget {
  const MigrateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        print('no migrations needed');
      },
      child: const Text('Migrate'),
    );
  }

  /// TODO: This method does not take care of moving any subcollections of the
  /// documents. It could be made to do so recursively.
  Future<void> moveDocuments<D extends Document>(
    CollectionReference<D> source,
    CollectionReference<D> destination,
  ) async {
    var documents = (await source.get()).docs.map((doc) => doc.data()).toList();
    print('  found ${documents.length} documents');

    for (var i = 0; i < documents.length; i++) {
      var document = documents[i];
      print('    document ${i + 1} of ${documents.length}');

      print('      creating ${document.reference!.id} at destination...');
      await destination.doc(document.reference!.id).set(document);

      print('      deleting ${document.reference!.id} from source...');
      await source.doc(document.reference!.id).delete();
    }
  }
}
