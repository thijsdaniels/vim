import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';

class Icons8IconStack extends StatelessWidget {
  final List<String?> icons;

  const Icons8IconStack({
    super.key,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: icons
          .slice(0, min(3, icons.length))
          .asMap()
          .entries
          .map(
            (entry) => Transform.translate(
              offset: Offset(
                [-7.0, 10.0, -4.0][entry.key],
                [-6.0, -1.0, 4.0][entry.key],
              ),
              child: entry.value != null
                  ? Icons8Icon(
                      entry.value!,
                      size: [40.0, 36.0, 32.0][entry.key],
                    )
                  : const SizedBox(),
            ),
          )
          .toList(),
    );
  }
}
