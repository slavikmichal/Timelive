import 'package:flutter/material.dart';
import 'package:timelive/event_screen.dart';
import 'package:timelive/tile.dart';

import 'icon_indicator.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          buildTile( context, '1', isFirst: true ),
          buildTile( context, '2' ),
          buildTile( context, '3' ),
          buildTile( context, '4' ),
          buildTile( context, '5' ),
          buildTile( context, '6' ),
          buildTile( context, '7' ),
          buildTile( context, '8' ),
          buildTile( context, '9', isLast: true ),
        ],
      ),
    );
  }

  Widget buildTile(
      BuildContext context,
      String id, {
      bool isFirst = false,
      bool isLast = false}) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => EventScreen(id: id,),
      )),
      child: Hero(
        tag: 'event-tag$id',
        child: Tile(
          indicator: const IconIndicator(
            iconData: Icons.circle,
            size: 20,
          ),
          date: '13.05.2022',
          title: 'First one',
          tags: ['one', 'two', 'three'],
          description: 'This is a very nice description of this first event',
          isFirst: isFirst,
          isLast: isLast,
        ),
      ),
    );
  }
}
