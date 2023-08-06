import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';

class StatsTable extends StatelessWidget {
  const StatsTable({
    super.key,
    required this.children,
  });

  final List<StatsRow> children;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: children,
    );
  }
}

class StatsRow extends TableRow {
  final String label;
  final dynamic value;
  final String? unit;

  const StatsRow(
    this.label,
    this.value, {
    super.key,
    this.unit,
  });

  @override
  get children {
    return [
      SecondaryText(label),
      const SizedBox(width: 32),
      Row(
        children: [
          value != null
              ? value is Widget
                  ? value!
                  : Text(value.toString(), overflow: TextOverflow.ellipsis)
              : const SecondaryText('--'),
          if (value != null && unit != null) ...[
            const SizedBox(width: 4),
            SecondaryText(unit!),
          ]
        ],
      ),
    ];
  }
}
