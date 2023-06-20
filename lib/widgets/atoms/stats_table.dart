import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';

class StatsTable extends StatelessWidget {
  const StatsTable({
    super.key,
    required this.items,
  });

  final Map<String, String?> items;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: items.entries
          .map(
            (entry) => TableRow(
              children: [
                SecondaryText(entry.key),
                const SizedBox(width: 32),
                entry.value != null
                    ? Text(entry.value!)
                    : const SecondaryText('--'),
              ],
            ),
          )
          .toList(),
    );
  }
}
