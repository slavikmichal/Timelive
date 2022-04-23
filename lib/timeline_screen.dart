import 'package:flutter/material.dart';
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
          Tile(
            indicator: const IconIndicator(
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
            indicator: const IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
          ),
          Tile(
            indicator: const IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
          ),
          Tile(
            indicator: const IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
          ),
          Tile(
            indicator: const IconIndicator(
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
