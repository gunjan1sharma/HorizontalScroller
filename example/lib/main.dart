// example/lib/main.dart
import 'package:flutter/material.dart';
// Import the public API of your package:
import 'package:HorizontalScroller/HorizontalScroller.dart'; // package name you chose

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HorizontalScroller Example',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // sample mock data
  List<TickerDetails> _makeSample() => [
        TickerDetails(
          propertyId: 'p1',
          propertyCode: 'PGXIO',
          propertyName: 'Prime Growth X',
          irr: '12.3%',
        ),
        TickerDetails(
          propertyId: 'p2',
          propertyCode: 'ABC01',
          propertyName: 'Alpha Build Corp.',
          irr: '8.9%',
        ),
        TickerDetails(
          propertyId: 'p3',
          propertyCode: 'DEF02',
          propertyName: 'Delta Estates',
          irr: '10.2%',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final tickerList = _makeSample();

    return Scaffold(
      appBar: AppBar(title: const Text('HorizontalScroller Demo')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Using your HorizontalScroller exactly like your snippet
          Builder(builder: (context) {
            return HorizontalScroller<TickerDetails>(
              items: tickerList,
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: Colors.black,
              itemPadding: const EdgeInsets.only(left: 15),

              enableAutoScroll: true,
              scrollSpeed: 50.0, // pixels per second (depends on impl)
              enableInfiniteScroll: true,
              startDelay: Duration.zero,

              enableClick: true,
              enableRipple: true,
              onItemClick: (item, index) {
                // navigate to a simple details page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailsPage(item: item),
                  ),
                );
              },
              itemBuilder: (item, index) {
                // replicate your item layout (shortened slightly for brevity)
                return Row(
                  children: [
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (item.propertyCode == "PGXIO")
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item.propertyCode ?? "N/A",
                                    ),
                                    const SizedBox(width: 8),
                                    // up/down icons stack
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: const [
                                          Positioned(
                                            right: -6,
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          ),
                                          Positioned(
                                            left: -6,
                                            child: Icon(
                                              Icons.arrow_drop_up,
                                              color: Color.fromARGB(
                                                  255, 66, 223, 102),
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      item.irr ?? "N/A",
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item.propertyCode ?? "N/A",
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_drop_up,
                                      size: 30,
                                      color: Color.fromARGB(255, 66, 223, 102),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      item.irr ?? "N/A",
                                    ),
                                  ],
                                ),
                          Text(
                            item.propertyName ?? "N/A",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.circle,
                      color: Color.fromARGB(64, 255, 255, 255),
                      size: 7,
                    ),
                    const SizedBox(width: 10),
                  ],
                );
              },
            );
          }),
          const SizedBox(height: 24),
          const Text('Scroll above to see behavior'),
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final TickerDetails item;
  const DetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: Text(
          '${item.propertyName}\n${item.propertyCode}\nIRR: ${item.irr}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Sample model used by the scroller
class TickerDetails {
  final String? propertyId;
  final String? propertyCode;
  final String? propertyName;
  final String? irr;

  TickerDetails({
    this.propertyId,
    this.propertyCode,
    this.propertyName,
    this.irr,
  });
}
