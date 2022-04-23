import 'package:flutter/material.dart';
import 'package:timelive/event_screen.dart';
import 'package:timelive/tile.dart';

import 'icon_indicator.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => EventScreen(),
        )),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: const <Widget>[
          Tile(
            indicator: IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
            isFirst: true,
          ),
          Tile(
            indicator: IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
          ),
          Tile(
            indicator: IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
          ),
          Tile(
            indicator: IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
          ),
          Tile(
            indicator: IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
            isLast: true,
          ),
        ],
      ),
    );
  }
}
