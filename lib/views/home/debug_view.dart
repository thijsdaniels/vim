import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/document.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';

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
    return WithConfirmationDialog(
      builder: (context, confirm) => FilledButton(
        onPressed: () async {
          if (!(await confirm())) {
            return;
          }

          // await assignOwners(
          //   IngredientsCollectionGroup.instance.collectionGroup,
          // );

          // await assignOwners(
          //   RecipesCollectionGroup.instance.collectionGroup,
          // );

          // await assignOwners(
          //   EquipmentsCollectionGroup.instance.collectionGroup,
          // );

          // await assignOwners(
          //   ExercisesCollectionGroup.instance.collectionGroup,
          // );

          // await assignOwners(
          //   RoutinesCollectionGroup.instance.collectionGroup,
          // );

          // await assignOwners(
          //   ConsumptionsCollectionGroup.instance.collectionGroup,
          // );

          // await assignOwners(
          //   PerformancesCollectionGroup.instance.collectionGroup,
          // );
        },
        child: const Text('Migrate'),
      ),
    );
  }

  DocumentReference? findOwner(DocumentReference reference) {
    var parentDocument = reference.parent.parent;

    if (parentDocument == null) {
      return null;
    } else if (parentDocument.parent.id == 'users') {
      return parentDocument;
    } else {
      return findOwner(parentDocument);
    }
  }

  Future<void> assignOwners<D extends OwnedDocument>(Query<D> query) async {
    await traverseDocuments(
      query,
      (document, index, length) async {
        print(
          'Visiting document "${document.reference!.path}" (${index + 1} of $length)...',
        );

        var owner = findOwner(document.reference!);

        if (owner == null) {
          throw Exception(
            'Could not find owner for document "${document.reference!.path}"',
          );
        }

        document.user = owner;

        print('  Updating document...');
        await document.reference!.set(document);
      },
    );
  }

  Future<void> traverseSnapshots<D>(
    Query<D> query,
    Future<void> Function(
      QueryDocumentSnapshot<D> snapshot,
      int index,
      int length,
    ) visit,
  ) async {
    var snapshots = (await query.get()).docs;

    print('Found ${snapshots.length} snapshots.');

    for (var i = 0; i < snapshots.length; i++) {
      await visit(snapshots[i], i, snapshots.length);
    }
  }

  Future<void> traverseDocuments<D extends Document>(
    Query<D> query,
    Future<void> Function(D document, int index, int length) visit,
  ) async {
    await traverseSnapshots<D>(
      query,
      (snapshot, index, length) {
        return visit(snapshot.data(), index, length);
      },
    );
  }

  Future<void> saveDocuments<D extends Document>(Query<D> query) async {
    await traverseDocuments(
      query,
      (document, index, length) async {
        print(
          'Saving document "${document.reference!.path}" (${index + 1} of $length)...',
        );

        document.reference!.set(document);
      },
    );
  }
}
