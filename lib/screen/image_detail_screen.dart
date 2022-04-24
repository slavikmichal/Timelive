import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class ImagesDetailScreen extends StatefulWidget {
  final List<String> urls;
  final int startIndex;

  const ImagesDetailScreen({Key? key, required this.urls, required this.startIndex}) : super(key: key);

  @override
  State<ImagesDetailScreen> createState() => _ImagesDetailScreenState();
}

class _ImagesDetailScreenState extends State<ImagesDetailScreen> {
  // Scroll controller for carousel
  late InfiniteScrollController _controller;

  // Maintain current index of carousel
  late int _selectedIndex;

  // Width of each item
  double? _itemExtent;

  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.startIndex;
    _controller = InfiniteScrollController(initialItem: _selectedIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemExtent = screenWidth - 30;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: SizedBox(
              height: 400,
              child: InfiniteCarousel.builder(
                velocityFactor: 0.5,
                itemCount: widget.urls.length,
                itemExtent: _itemExtent ?? 40,
                scrollBehavior: kIsWeb
                    ? ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          // Allows to swipe in web browsers
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse
                        },
                      )
                    : null,
                loop: false,
                controller: _controller,
                onIndexChanged: (index) {
                  if (_selectedIndex != index) {
                    setState(() => _selectedIndex = index);
                  }
                },
                itemBuilder: (context, itemIndex, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GestureDetector(
                      onTap: () => _controller.animateToItem(realIndex),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: kElevationToShadow[2],
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.urls[itemIndex],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
