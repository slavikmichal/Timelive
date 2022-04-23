import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'icon_indicator.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          _buildTimelineTile(
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
          _buildTimelineTile(
            indicator: const IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
          ),
          _buildTimelineTile(
            indicator: const IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
          ),
          _buildTimelineTile(
            indicator: const IconIndicator(
              iconData: Icons.circle,
              size: 20,
            ),
            date: '13.05.2022',
            title: 'First one',
            tags: ['one', 'two', 'three'],
            description: 'This is a very nice description of this first event',
          ),
          _buildTimelineTile(
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

  TimelineTile _buildTimelineTile({
    required IconIndicator indicator,
    required String date,
    required String title,
    required List<String> tags,
    required String description,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.3,
      beforeLineStyle: LineStyle(color: Colors.white.withOpacity(0.7)),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.3,
        drawGap: true,
        width: 30,
        height: 30,
        indicator: indicator,
      ),
      isFirst: isFirst,
      isLast: isLast,
      startChild: Center(
        child: Container(
          alignment: const Alignment(0.0, -0.50),
          child: Text(
            date,
            style: GoogleFonts.ubuntu(
              fontSize: 18,
              color: Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      endChild: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 18,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tags.fold(
                  '', (previousValue, element) => previousValue + ' #$element'),
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: GoogleFonts.lato(
                fontSize: 14,
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
