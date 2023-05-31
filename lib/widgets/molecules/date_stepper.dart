import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/models/date_model.dart';

class DateStepper extends StatelessWidget {
  const DateStepper({super.key});

  @override
  Widget build(BuildContext context) {
    DateModel dateModel = Provider.of<DateModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              dateModel.date.isToday()
                  ? 'Today'
                  : dateModel.date.isTomorrow()
                      ? 'Tomorrow'
                      : dateModel.date.isYesterday()
                          ? 'Yesterday'
                          : DateFormat.yMMMMd('en_US').format(dateModel.date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: dateModel.previous,
                icon: const Icon(Icons.chevron_left),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: !dateModel.date.isToday() ? dateModel.today : null,
                icon: const Icon(Icons.circle),
                iconSize: 8,
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: dateModel.next,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
