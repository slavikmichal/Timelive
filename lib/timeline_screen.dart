import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelive/controllers/event_controller.dart';
import 'package:timelive/data/data_generator.dart';
import 'package:timelive/event_screen.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/qr_code/model/qr_code_data.dart';
import 'package:timelive/qr_code/scanner/qr_scanner.dart';
import 'package:timelive/tile.dart';

import 'bloc/events_cubit.dart';
import 'icon_indicator.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => DataGenerator.generateSomeData(),
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => DataGenerator.clearGeneratedData(),
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
            _navigateToEventScreen(context, eventData!, 0);
          }),
      // backgroundColor: Colors.black,
      body: BlocBuilder<EventsCubit, List<Event>>(
          builder: (context, events) {

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) => buildTile(
                context,
                events.elementAt(index),
                index,
                isFirst: index == 0,
                isLast: index == events.length - 1,
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
