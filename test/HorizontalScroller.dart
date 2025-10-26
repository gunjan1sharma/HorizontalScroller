import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:HorizontalScroller/HorizontalScroller.dart';

/// Sample data class for testing
class TickerDetails {
  final String propertyCode;
  final String propertyName;
  final String irr;

  TickerDetails({
    required this.propertyCode,
    required this.propertyName,
    required this.irr,
  });
}

void main() {
  // Sample data
  final List<TickerDetails> testItems = [
    TickerDetails(
        propertyCode: 'PGXIO', propertyName: 'Property One', irr: '5%'),
    TickerDetails(
        propertyCode: 'ABCD', propertyName: 'Property Two', irr: '7%'),
  ];

  testWidgets('HorizontalScroller renders without error',
      (WidgetTester tester) async {
    // Build widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HorizontalScroller<TickerDetails>(
            items: testItems,
            height: 80,
            enableAutoScroll: false, // disable auto-scroll for test stability
            itemBuilder: (item, index) {
              return Text('${item.propertyCode}-${item.propertyName}');
            },
          ),
        ),
      ),
    );

    // Verify that the text from testItems is rendered
    expect(find.text('PGXIO-Property One'), findsOneWidget);
    expect(find.text('ABCD-Property Two'), findsOneWidget);
  });

  testWidgets('HorizontalScroller onItemClick works',
      (WidgetTester tester) async {
    bool clicked = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HorizontalScroller<TickerDetails>(
            items: testItems,
            height: 80,
            enableAutoScroll: false,
            onItemClick: (item, index) {
              clicked = true;
            },
            itemBuilder: (item, index) {
              return Text('${item.propertyCode}-${item.propertyName}');
            },
          ),
        ),
      ),
    );

    // Tap the first item
    await tester.tap(find.text('PGXIO-Property One'));
    await tester.pump();

    expect(clicked, isTrue);
  });
}
