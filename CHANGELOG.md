---
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and adheres to [Semantic Versioning](https://semver.org/).
---

## [0.1.0] - 2025-10-26

### Added

- Initial release of `HorizontalScroller` widget.
- Fully **generic horizontal scrolling widget** with support for type `T`.
- **Auto-scroll** functionality with configurable speed (`scrollSpeed`) and optional start delay (`startDelay`).
- **Infinite scroll** option for seamless looping of items.
- **Custom dimensions**: height, optional width (`customWidth`), margin, and padding (`itemPadding`).
- **Click handling** with optional ripple effect (`enableClick`, `enableRipple`) and `onItemClick` callback.
- Background color customization (`backgroundColor`).
- Smooth frame-based scrolling optimized for **60 FPS**.
- Pause and resume auto-scroll during user interaction (dragging, tapping).
- Fully compatible with **iOS and Android**.

### Fixed

- N/A (first release)

### Known Issues

- Auto-scroll may have minor jump if `ListView` contains extremely dynamic content.
- Large datasets (>1000 items) may require careful optimization of `itemBuilder`.

---

## Recommended Usage Notes

- For **infinite scrolling**, the widget internally duplicates items 3x to ensure smooth looping.
- `scrollSpeed` is defined in **pixels per second** and can be adjusted according to your UI requirements.
- For **clickable items**, the `enableRipple` flag provides a Material-style ripple effect; set to `false` for custom UI.
- Auto-scroll automatically **pauses during user interaction** and resumes once interaction ends.
- The widget is fully **generic**; you can pass any custom model type for `T` and implement your own `itemBuilder`.

---

## Future Roadmap

- ✅ Support for **vertical auto-scrolling**.
- ✅ Optional **scroll easing animations**.
- ✅ Built-in support for **dynamic content updates** without resetting scroll position.
- ✅ Widget-level **performance profiling tools** for extremely long lists.

---

## Contact & Support

For feature requests, bug reports, or general inquiries:

**Gunjan Sharma**

- Email: [gunjan.sharmo@gmail.com](mailto:gunjan.sharmo@gmail.com)
- LinkedIn: [https://www.linkedin.com/in/gunjan1sharma/](https://www.linkedin.com/in/gunjan1sharma/)

---

## License

This project is licensed under the **MIT License**. See [LICENSE](LICENSE) for details.
