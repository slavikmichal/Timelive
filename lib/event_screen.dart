import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:timelive/line_painter.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/models/timeline_zoom.dart';
import 'package:timelive/qr_code/screen/generated_qr_code.dart';
import 'package:timelive/tile.dart';

import 'icon_indicator.dart';

class EventScreen extends StatefulWidget {
  final Event event;
  final int index;

  const EventScreen({Key? key, required this.event, required this.index}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  static const textShift = 0.19988425925925924769188314471879;

  List<String> kDemoImages = [
    'https://i.pinimg.com/originals/7f/91/a1/7f91a18bcfbc35570c82063da8575be8.jpg',
    'https://www.absolutearts.com/portfolio3/a/afifaridasiddique/Still_Life-1545967888l.jpg',
    'https://cdn11.bigcommerce.com/s-x49po/images/stencil/1280x1280/products/53415/72138/1597120261997_IMG_20200811_095922__49127.1597493165.jpg?c=2',
    'https://i.pinimg.com/originals/47/7e/15/477e155db1f8f981c4abb6b2f0092836.jpg',
    'https://images.saatchiart.com/saatchi/770124/art/3760260/2830144-QFPTZRUH-7.jpg',
    'https://images.unsplash.com/photo-1471943311424-646960669fbc?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c3RpbGwlMjBsaWZlfGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80',
    'https://cdn11.bigcommerce.com/s-x49po/images/stencil/1280x1280/products/40895/55777/1526876829723_P211_24X36__2018_Stilllife_15000_20090__91926.1563511650.jpg?c=2',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIUsxpakPiqVF4W_rOlq6eoLYboOFoxw45qw&usqp=CAU',
    'https://images.mojarto.com/photos/267893/large/DA-SL-01.jpg?1560834975',
  ];

  // Scroll controller for carousel
  late InfiniteScrollController _controller;

  // Maintain current index of carousel
  int _selectedIndex = 0;

  // Width of each item
  double? _itemExtent;

  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    _controller = InfiniteScrollController(initialItem: _selectedIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemExtent = screenWidth - 200;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GeneratedQrCodeScreen(eventId: widget.event.id!),
        )),
      ),
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Hero(
              tag: 'event-tag${widget.index}',
              child: Tile(
                indicator: const IconIndicator(
                  iconData: Icons.circle,
                  size: 20,
                ),
                zoom: TimelineZoom.fullDescription,
                event: widget.event,
                isFirst: false,
                isLast: false,
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  width: screenWidth * textShift,
                  child: CustomPaint(
                    painter: LinePainter(
                      MediaQuery.of(context).size.height - 50,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: InfiniteCarousel.builder(
                    itemCount: kDemoImages.length,
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
                    loop: true,
                    controller: _controller,
                    onIndexChanged: (index) {
                      if (_selectedIndex != index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      }
                    },
                    itemBuilder: (context, itemIndex, realIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            _controller.animateToItem(realIndex);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: kElevationToShadow[2],
                              image: DecorationImage(
                                image: NetworkImage(
                                  kDemoImages[itemIndex],
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
