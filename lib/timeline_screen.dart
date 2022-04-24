import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:timelive/bloc/zoom_cubit.dart';
import 'package:timelive/controllers/event_controller.dart';
import 'package:timelive/event_screen.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/models/timeline_zoom.dart';
import 'package:timelive/qr_code/model/qr_code_data.dart';
import 'package:timelive/qr_code/scanner/qr_scanner.dart';
import 'package:timelive/tile.dart';

import 'bloc/events_cubit.dart';
import 'icon_indicator.dart';

class TimelineScreen extends StatelessWidget {
  final ItemScrollController _scrollController = ItemScrollController();

  TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => context.read<ZoomCubit>().zoomIn(),
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => context.read<ZoomCubit>().zoomOut(),
        )
      ],
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.qr_code_scanner),
          onPressed: () async {
            QrCodeData? qrCode = await QrScanner.scan();
            if (qrCode == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scanner could not read a QR code.')),
              );
              return;
            }

            DocumentSnapshot<Event> eventSnapshot = await EventController.getEventById(qrCode.eventId);
            Event? eventData = eventSnapshot.data();
            _navigateToEvent(context, eventData);
          }),
      // backgroundColor: Colors.black,
      body: BlocBuilder<ZoomCubit, TimelineZoom>(
        builder: (context, zoom) => BlocBuilder<EventsCubit, List<Event>>(
          builder: (context, events) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ScrollablePositionedList.builder(
                itemScrollController: _scrollController,
                itemCount: events.length,
                itemBuilder: (context, index) => buildTile(
                  context,
                  events.elementAt(index),
                  index,
                  zoom,
                  isFirst: index == 0,
                  isLast: index == events.length - 1,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTile(BuildContext context, Event event, int index, TimelineZoom zoom, {bool isFirst = false, bool isLast = false}) {
    return InkWell(
      onTap: () => _navigateToEventScreen(context, event, index),
      child: Hero(
        tag: 'event-tag$index',
        child: Tile(
          indicator: const IconIndicator(
            iconData: Icons.circle,
            size: 20,
          ),
          event: event,
          zoom: zoom,
          isFirst: isFirst,
          isLast: isLast,
        ),
      ),
    );
  }

  Future<dynamic> _navigateToEventScreen(BuildContext context, Event event, int index) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => EventScreen(
        event: event,
        index: index,
      ),
    ));
  }

  void _navigateToEvent(BuildContext context, Event? eventData) {
    var indexById = context.read<EventsCubit>().getIndexById(eventData!.id!);
    _scrollController.scrollTo(index: indexById, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    _navigateToEventScreen(context, eventData, indexById);
  }
}
