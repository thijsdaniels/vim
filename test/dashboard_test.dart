import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vim/views/not_found_view.dart';

void main() {
  testWidgets('NotFoundView displays message', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: NotFoundView()),
    );

    expect(find.text('404: Not Found'), findsOneWidget);
  });
}
