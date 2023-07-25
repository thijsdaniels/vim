import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/document.dart';
import 'package:vim/services/consumptions_collection_group.dart';
import 'package:vim/services/performances_collection_group.dart';
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

          await traverseDocuments(
              PerformancesCollectionGroup.instance.collectionGroup,
              (performance, index, length) async {
            print(
              'Visiting performance "${performance.reference!.path}" (${index + 1} of $length)...',
            );

            if (performance.reference!.parent.parent!.id == 'performances') {
              performance.user =
                  performance.reference!.parent.parent!.parent.parent!;
            } else {
              performance.user = performance.reference!.parent.parent!;
            }

            print('  Updating performance...');
            await performance.reference!.set(performance);
          });

          await traverseDocuments(
            ConsumptionsCollectionGroup.instance.collectionGroup,
            (consumption, index, length) async {
              print(
                'Visiting consumption "${consumption.reference!.path}" (${index + 1} of $length)...',
              );

              if (consumption.reference!.parent.parent!.id == 'consumptions') {
                consumption.user =
                    consumption.reference!.parent.parent!.parent.parent!;
              } else {
                consumption.user = consumption.reference!.parent.parent!;
              }

              print('  Updating consumption...');
              await consumption.reference!.set(consumption);
            },
          );
        },
        child: const Text('Migrate'),
      ),
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
