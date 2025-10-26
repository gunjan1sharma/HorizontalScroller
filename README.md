# HorizontalScroller

[![Flutter](https://img.shields.io/badge/Flutter-%5E3.13-blue?logo=flutter&logoColor=white)](https://flutter.dev)
[![Pub Version](https://img.shields.io/pub/v/horizontal_scroller?color=blue)](https://pub.dev/packages/horizontal_scroller)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A **robust, plug-and-play horizontal auto-scrolling widget** for Flutter, designed for high performance and flexibility. Ideal for **tickers, news feeds, image carousels, and promotional banners**. Optimized for both **iOS and Android**.

HorizontalScroller is **generic**, supports **auto-scroll, infinite looping, click handling, ripple effects**, and **full customization**.

---

## Features

- ✅ **Auto-Scrolling**: Smooth scrolling at configurable speeds.
- ✅ **Infinite or Finite Scroll**: Seamless looping or bounded scrolling.
- ✅ **Custom Dimensions**: Height, width, margin, and padding fully configurable.
- ✅ **Interaction Support**: Clickable items with optional ripple effect.
- ✅ **Pause & Resume**: Auto-scroll pauses during user interaction and resumes automatically.
- ✅ **Generic Data Support**: Works with any type `T`.
- ✅ **Performance Optimized**: Lightweight and efficient for long lists.

---

## Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  horizontal_scroller: ^0.1.0
```

Then import in your Dart file:

```dart
import 'package:horizontal_scroller/horizontal_scroller.dart';
```

---

## Usage

### Basic Example

```dart
HorizontalScroller<TickerDetails>(
  items: tickerList,
  height: 80,
  margin: EdgeInsets.symmetric(vertical: 15),
  backgroundColor: Colors.black,
  itemPadding: EdgeInsets.only(left: 15),

  enableAutoScroll: true,
  scrollSpeed: 50.0,
  enableInfiniteScroll: true,
  startDelay: Duration.zero,

  enableClick: true,
  enableRipple: true,
  onItemClick: (item, index) {
    print("Clicked item: ${item.propertyName}");
  },
  itemBuilder: (item, index) {
    return Text(item.propertyName);
  },
);
```

---

## Constructor Parameters

<details>
<summary><b>All Available Options</b></summary>

| Parameter              | Type                                 | Default                              | Description                                             |
| ---------------------- | ------------------------------------ | ------------------------------------ | ------------------------------------------------------- |
| `items`                | `List<T>`                            | required                             | List of items to display.                               |
| `itemBuilder`          | `Widget Function(T item, int index)` | required                             | Function to build each item.                            |
| `height`               | `double`                             | `80.0`                               | Height of the scroller container.                       |
| `customWidth`          | `double?`                            | `null`                               | Optional width; defaults to screen width.               |
| `margin`               | `EdgeInsets`                         | `EdgeInsets.symmetric(vertical: 15)` | Outer container margin.                                 |
| `enableAutoScroll`     | `bool`                               | `true`                               | Enables automatic scrolling.                            |
| `scrollSpeed`          | `double`                             | `50.0`                               | Pixels per second for auto-scroll.                      |
| `enableInfiniteScroll` | `bool`                               | `true`                               | Enable infinite scroll by duplicating items internally. |
| `startDelay`           | `Duration?`                          | `Duration.zero`                      | Delay before auto-scroll starts.                        |
| `enableClick`          | `bool`                               | `true`                               | Enable tap/click events on items.                       |
| `enableRipple`         | `bool`                               | `true`                               | Add Material ripple effect for taps.                    |
| `onItemClick`          | `Function(T item, int index)?`       | `null`                               | Callback triggered when an item is clicked.             |
| `backgroundColor`      | `Color?`                             | `Colors.black`                       | Background color of the scroller.                       |
| `itemPadding`          | `EdgeInsets`                         | `EdgeInsets.only(left: 15)`          | Padding for items inside the scroll view.               |

</details>

---

## Advanced Example

```dart
HorizontalScroller<TickerDetails>(
  items: tickerList,
  height: 100,
  enableAutoScroll: true,
  scrollSpeed: 60,
  enableInfiniteScroll: true,
  onItemClick: (item, index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailPage(item: item)),
    );
  },
  itemBuilder: (item, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.propertyCode ?? "N/A",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(item.propertyName ?? "N/A",
            style: TextStyle(color: Colors.orangeAccent)),
      ],
    );
  },
);
```

---

## Notes & Best Practices

- **Generic Type:** The widget is fully generic (`HorizontalScroller<T>`).
- **Infinite Scroll:** Internal duplication of items ensures smooth, seamless looping.
- **Auto-Scroll:** Smooth, frame-based auto-scroll optimized for 60 FPS.
- **Interaction Handling:** Pauses auto-scroll when the user is interacting (dragging or tapping).
- **Performance:** Efficient even for large datasets; minimal impact on CPU/GPU.

---

## Sample Model

```dart
class TickerDetails {
  final String? propertyId;
  final String? propertyCode;
  final String? propertyName;
  final String? irr;

  TickerDetails({this.propertyId, this.propertyCode, this.propertyName, this.irr});
}
```

---

## Contact & Support

**Gunjan Sharma**

- Email: [gunjan.sharmo@gmail.com](mailto:gunjan.sharmo@gmail.com)
- LinkedIn: [https://www.linkedin.com/in/gunjan1sharma/](https://www.linkedin.com/in/gunjan1sharma/)

Feel free to reach out for support, feature requests, or collaborations.

---

## License

This project is licensed under the **MIT License**. See [LICENSE](LICENSE) for details.

---
