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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: dateModel.previous,
          icon: const Icon(Icons.chevron_left),
        ),
        Text(
          dateModel.date.isToday()
              ? 'Today'
              : dateModel.date.isTomorrow()
                  ? 'Tomorrow'
                  : dateModel.date.isYesterday()
                      ? 'Yesterday'
                      : DateFormat.yMMMMd('en_US').format(dateModel.date),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        // IconButton(
        //   onPressed: dateModel.today,
        //   icon: const Icon(Icons.circle),
        //   iconSize: 8,
        // ),
        IconButton(
          onPressed: dateModel.next,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
