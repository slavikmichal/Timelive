import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as Cool;
import 'package:timelive/qr_code/generator/qr_generator.dart';

class ImagesDetailScreen extends StatefulWidget {
  final List<String> urls;
  final int startIndex;
  final String eventId;

  const ImagesDetailScreen({Key? key, required this.urls, required this.startIndex, required this.eventId}) : super(key: key);

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

  final ScreenshotController screenshotController = ScreenshotController();

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
                      child: InkWell(
                        onLongPress: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => savePhoto(),
                                      child: const Text("Save image"),
                                    ),
                                    // ElevatedButton(
                                    //   onPressed: () => savePhotoQr(),
                                    //   child: const Text("Save with QR code"),
                                    // ),
                                  ],
                                ),
                              );
                            }),
                        child: Screenshot(
                          controller: screenshotController,
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

  savePhoto() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        try {
          final String fullPath = '$directory/${DateTime.now().millisecond}.png';
          File capturedFile = File(fullPath);
          await capturedFile.writeAsBytes(image);
          print(capturedFile.path);
          await GallerySaver.saveImage(capturedFile.path).then((value) {
            print('PRINTED');
          });
        } catch (error) {}
      }
    });
  }

  // savePhotoQr() async {
  //   final directory = (await getApplicationDocumentsDirectory()).path;
  //   screenshotController.capture().then((Uint8List? image) async {
  //     if (image != null) {
  //       try {
  //         final qrCode = QrCodeFactory.generateSimple(eventId: widget.eventId, size: 280);
  //         final mergedImage = Cool.Image(800, 500);
  //         Cool.copyInto(mergedImage, Image.memory(image), blend = false);
  //         Cool.copyInto(mergedImage, qrCode, dstx = image1.width, blend = false);
  //
  //
  //         final documentDirectory = await getApplicationDocumentsDirectory();
  //         final file = new File(join(documentDirectory.path, "merged_image.jpg"));
  //         file.writeAsBytesSync(encodeJpg(mergedImage));
  //
  //         final String fullPath = '$directory/${DateTime.now().millisecond}.png';
  //         File capturedFile = File(fullPath);
  //         await capturedFile.writeAsBytes(image);
  //         print(capturedFile.path);
  //         await GallerySaver.saveImage(capturedFile.path).then((value) {
  //           print('PRINTED');
  //         });
  //       } catch (error) {}
  //     }
  //   });
  // }
}
