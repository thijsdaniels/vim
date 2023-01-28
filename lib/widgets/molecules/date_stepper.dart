import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';

class DateStepper extends StatelessWidget {
  const DateStepper({super.key});

  @override
  Widget build(BuildContext context) {
    DateModel dateModel = Provider.of<DateModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: dateModel.previous,
          icon: const Icon(Icons.chevron_left),
        ),
        IconButton(
          onPressed: dateModel.today,
          icon: const Icon(Icons.circle),
          iconSize: 8,
        ),
        IconButton(
          onPressed: dateModel.next,
          icon: const Icon(Icons.chevron_right),
        ),
        const SizedBox(width: 16),
        Text(
          DateFormat.yMMMMd('en_US').format(dateModel.date),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
