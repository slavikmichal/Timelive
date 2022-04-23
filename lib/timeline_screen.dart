import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timelive/controllers/event_controller.dart';
import 'package:timelive/event_screen.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/tile.dart';

import 'icon_indicator.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot<Event>>(
        stream: EventController.getEventsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          final data = snapshot.requireData;

          return ListView(
            children: data.docs.map((e) => buildTile(context, e.data())).toList(),
          );
        }),
    );
  }

  Widget buildTile(
      BuildContext context,
      Event event, {
      bool isFirst = false,
      bool isLast = false}) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => EventScreen(event: event,),
      )),
      child: Hero(
        tag: 'event-tag$event.id!',
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
}
