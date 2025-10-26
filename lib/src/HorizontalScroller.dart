import 'package:flutter/material.dart';
import 'dart:async';

/// A robust, plug-and-play horizontal auto-scrolling widget
/// Optimized for iOS and Android with configurable options
class HorizontalScroller<T> extends StatefulWidget {
  // Required
  final List<T> items;
  final Widget Function(T item, int index) itemBuilder;

  // Dimensions
  final double height;
  final double? customWidth;
  final EdgeInsets margin;

  // Animation Config
  final bool enableAutoScroll;
  final double scrollSpeed; // pixels per second
  final bool enableInfiniteScroll;
  final Duration? startDelay;

  // Interaction Config
  final bool enableClick;
  final bool enableRipple;
  final Function(T item, int index)? onItemClick;

  // Background
  final Color? backgroundColor;
  final EdgeInsets itemPadding;

  const HorizontalScroller({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.height = 80.0,
    this.customWidth,
    this.margin = const EdgeInsets.symmetric(vertical: 15),
    this.enableAutoScroll = true,
    this.scrollSpeed = 50.0, // pixels per second
    this.enableInfiniteScroll = true,
    this.startDelay,
    this.enableClick = true,
    this.enableRipple = true,
    this.onItemClick,
    this.backgroundColor = Colors.black,
    this.itemPadding = const EdgeInsets.only(left: 15),
  }) : super(key: key);

  @override
  State<HorizontalScroller<T>> createState() => _HorizontalScrollerState<T>();
}

class _HorizontalScrollerState<T> extends State<HorizontalScroller<T>> {
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  Timer? _startDelayTimer;
  Timer? _resumeTimer;

  bool _isAutoScrolling = false;
  bool _isUserInteracting = false;
  bool _isDragging = false;

  // For infinite scroll
  late List<T> _displayItems;

  // Track scroll position for infinite loop
  double _lastScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeScrollController();
    _prepareDisplayItems();
    _scheduleAutoScroll();
  }

  void _initializeScrollController() {
    _scrollController = ScrollController();
  }

  void _prepareDisplayItems() {
    if (widget.items.isEmpty) {
      _displayItems = [];
      return;
    }

    if (widget.enableInfiniteScroll) {
      // Triple the items for seamless infinite scroll
      _displayItems = [...widget.items, ...widget.items, ...widget.items];
    } else {
      _displayItems = widget.items;
    }
  }

  void _scheduleAutoScroll() {
    if (!widget.enableAutoScroll || widget.items.isEmpty) return;

    final delay = widget.startDelay ?? Duration.zero;

    _startDelayTimer = Timer(delay, () {
      if (mounted) {
        _startAutoScroll();
      }
    });
  }

  void _startAutoScroll() {
    if (!widget.enableAutoScroll ||
        _isAutoScrolling ||
        _isUserInteracting ||
        _isDragging ||
        !mounted) return;

    // Wait for layout to complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients || !mounted) return;

      _isAutoScrolling = true;

      // Use Timer.periodic for continuous smooth scrolling
      _scrollTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
        if (!mounted || !_scrollController.hasClients) {
          timer.cancel();
          return;
        }

        if (_isUserInteracting || _isDragging) {
          return; // Pause but don't cancel
        }

        try {
          final currentPosition = _scrollController.offset;
          final maxScroll = _scrollController.position.maxScrollExtent;

          // Calculate pixels to move based on speed (pixels per second)
          final pixelsToMove = widget.scrollSpeed / 60; // 60fps

          final newPosition = currentPosition + pixelsToMove;

          if (widget.enableInfiniteScroll) {
            // Check if we need to reset for infinite scroll
            final oneThirdPosition = maxScroll / 3;
            final twoThirdsPosition = (maxScroll / 3) * 2;

            if (newPosition >= twoThirdsPosition) {
              // Jump back to start of second set
              _scrollController.jumpTo(oneThirdPosition);
            } else {
              _scrollController.jumpTo(newPosition);
            }
          } else {
            // Non-infinite scroll: restart from beginning
            if (newPosition >= maxScroll) {
              _scrollController.jumpTo(0);
            } else {
              _scrollController.jumpTo(newPosition);
            }
          }

          _lastScrollPosition = _scrollController.offset;
        } catch (e) {
          print('Scroll error: $e');
        }
      });
    });
  }

  void _stopAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = null;
    _isAutoScrolling = false;
  }

  void _pauseAutoScroll() {
    _isUserInteracting = true;
  }

  void _resumeAutoScroll() {
    _isUserInteracting = false;

    _resumeTimer?.cancel();
    _resumeTimer = Timer(Duration(milliseconds: 1000), () {
      if (mounted && !_isUserInteracting && !_isDragging) {
        // Don't restart, just allow existing timer to continue
        if (_scrollTimer == null || !_scrollTimer!.isActive) {
          _startAutoScroll();
        }
      }
    });
  }

  void _handleItemTap(T item, int index) {
    if (!widget.enableClick || widget.onItemClick == null) return;

    _pauseAutoScroll();

    // Execute callback
    widget.onItemClick!(item, index % widget.items.length);

    // Resume after navigation
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        _resumeAutoScroll();
      }
    });
  }

  @override
  void didUpdateWidget(covariant HorizontalScroller<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items.length != widget.items.length) {
      _prepareDisplayItems();
      _stopAutoScroll();

      if (widget.enableAutoScroll) {
        Future.delayed(Duration(milliseconds: 300), () {
          if (mounted) {
            _startAutoScroll();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _startDelayTimer?.cancel();
    _resumeTimer?.cancel();
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = widget.customWidth ?? screenWidth;

    return Container(
      width: containerWidth,
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: Listener(
        onPointerDown: (_) {
          _isDragging = true;
          _pauseAutoScroll();
        },
        onPointerUp: (_) {
          _isDragging = false;
          _resumeAutoScroll();
        },
        child: ListView.builder(
          controller: _scrollController,
          padding: widget.itemPadding,
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: _displayItems.length,
          itemBuilder: (context, index) {
            final item = _displayItems[index];
            final actualIndex = index % widget.items.length;

            Widget child = widget.itemBuilder(item, actualIndex);

            if (widget.enableClick && widget.onItemClick != null) {
              if (widget.enableRipple) {
                return InkWell(
                  onTap: () => _handleItemTap(item, index),
                  splashColor: Colors.white.withOpacity(0.3),
                  highlightColor: Colors.white.withOpacity(0.1),
                  child: child,
                );
              } else {
                return GestureDetector(
                  onTap: () => _handleItemTap(item, index),
                  behavior: HitTestBehavior.opaque,
                  child: child,
                );
              }
            }

            return child;
          },
        ),
      ),
    );
  }
}
