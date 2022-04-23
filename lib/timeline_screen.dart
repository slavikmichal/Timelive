import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelive/controllers/event_controller.dart';
import 'package:timelive/event_screen.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/qr_code/model/qr_code_data.dart';
import 'package:timelive/qr_code/scanner/qr_scanner.dart';
import 'package:timelive/tile.dart';

import 'icon_indicator.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _navigateToEventScreen(context, eventData!, 0);
          }),
      // backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot<Event>>(
          stream: EventController.getEventsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            final Iterable<Event> data = snapshot.requireData.docs.map((e) => e.data());

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => buildTile(
                context,
                data.elementAt(index),
                index,
                isFirst: index == 0,
                isLast: index == data.length - 1,
              ),
            );
          }),
    );
  }

  Widget buildTile(BuildContext context, Event event, int index, {bool isFirst = false, bool isLast = false}) {
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
}
