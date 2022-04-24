import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/models/timeline_zoom.dart';
import 'package:timelive/themes/color_schemer.dart';

import 'icon_indicator.dart';

class Tile extends StatelessWidget {
  final IconIndicator indicator;
  final Event event;
  final TimelineZoom zoom;
  final bool isFirst;
  final bool isLast;

  const Tile({
    Key? key,
    required this.indicator,
    required this.event,
    required this.zoom,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      beforeLineStyle: LineStyle(color: ColorSchemer.palicaColor),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.3,
        drawGap: true,
        width: 30,
        height: 30,
        indicator: indicator,
      ),
      isFirst: isFirst,
      isLast: isLast,
      endChild: Padding(
        padding: const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    _getTitleByZoom(event),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.ubuntu(
                      fontSize: 18,
                      color: ColorSchemer.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (zoom == TimelineZoom.fullDescription || zoom == TimelineZoom.shortDescription)
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      _formatDateTime(event.date),
                      style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        color: ColorSchemer.textColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            if (zoom == TimelineZoom.fullDescription || zoom == TimelineZoom.shortDescription)
              Text(
                event.tags.fold('', (previousValue, element) => previousValue + ' #$element'),
                style: GoogleFonts.ubuntu(
                  fontSize: 16,
                  color: ColorSchemer.textColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            const SizedBox(height: 4),
            if (zoom == TimelineZoom.fullDescription)
              Text(
                event.description,
                style: GoogleFonts.ubuntu(
                  fontSize: 14,
                  color: ColorSchemer.textColor,
                  fontWeight: FontWeight.normal,
                ),
              )
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    var day = date.day.toString().padLeft(2, '0');
    var month = date.month.toString().padLeft(2, '0');
    var year = date.year.toString();
    return "$day.$month.$year";
  }

  String _getTitleByZoom(Event event) {
    switch (zoom) {
      case TimelineZoom.year:
        {
          return event.date.year.toString();
        }
      case TimelineZoom.month:
        {
          return _formatDateTime(event.date).substring(3);
        }
      case TimelineZoom.day:
        {
          return _formatDateTime(event.date);
        }
      case TimelineZoom.shortDescription:
      case TimelineZoom.fullDescription:
        {
          return event.name;
        }
    }
  }
}
