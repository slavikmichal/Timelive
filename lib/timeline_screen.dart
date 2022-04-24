import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:timelive/bloc/zoom_cubit.dart';
import 'package:timelive/controllers/event_controller.dart';
import 'package:timelive/create_event_screen.dart';
import 'package:timelive/data/data_generator.dart';
import 'package:timelive/event_screen.dart';
import 'package:timelive/models/event.dart';
import 'package:timelive/models/tag.dart';
import 'package:timelive/models/timeline_zoom.dart';
import 'package:timelive/qr_code/model/qr_code_data.dart';
import 'package:timelive/qr_code/scanner/qr_scanner.dart';
import 'package:timelive/tag_filters.dart';
import 'package:timelive/themes/color_schemer.dart';
import 'package:timelive/tile.dart';
import 'package:timelive/widget/CommonScaffold.dart';

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
          onPressed: () {
            context.read<ZoomCubit>().zoomIn();
            context.read<EventsCubit>().filterEvents(context.read<ZoomCubit>().state);
          },
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            context.read<ZoomCubit>().zoomOut();
            context.read<EventsCubit>().filterEvents(context.read<ZoomCubit>().state);
          },
        )
      ],
      floatingActionButton: SpeedDial(
        child: const Icon(Icons.notes),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            backgroundColor: ColorSchemer.buttonColor,
            foregroundColor: ColorSchemer.vismaBlack,
            label: 'New Event'.toUpperCase(),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const CreateEventScreen(),
            )),
          ),
          SpeedDialChild(
            child: const Icon(Icons.qr_code),
            backgroundColor: ColorSchemer.buttonColor,
            foregroundColor: ColorSchemer.vismaBlack,
            label: 'Scan QR Code'.toUpperCase(),
            onTap: () async {
              QrCodeData? qrCode = await QrScanner.scan();
              if (qrCode == null) {
                ScaffoldMessengerManager.publish(
                  context,
                  const Text('Scanner could not read a QR code.'),
                );
                return;
              }

              DocumentSnapshot<Event> eventSnapshot = await EventController.getEventById(qrCode.eventId);
              Event? eventData = eventSnapshot.data();
              _navigateToEvent(context, eventData);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.quickreply),
            backgroundColor: ColorSchemer.buttonColor,
            foregroundColor: ColorSchemer.vismaBlack,
            label: 'Data Manipulation'.toUpperCase(),
            onTap: () async {
              int generatedEventsCount = await DataGenerator.generateSomeData();
              ScaffoldMessengerManager.publish(
                context,
                Text('Generated $generatedEventsCount events.'),
              );
            },
            onLongPress: () {
              DataGenerator.clearGeneratedData();
              ScaffoldMessengerManager.publish(
                context,
                const Text('Cleared generated events.'),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 10,
        child: FutureBuilder(
            future: EventController.getTags(),
            builder: (context, AsyncSnapshot<List<Tag>> snapshot) {
              if (snapshot.hasData) {
                List<Tag> loadedTags = snapshot.data!.toList();

                return TagFilters(allTags: loadedTags);
              } else {
                return Column(
                  children: const [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ],
                );
              }
            }),
      ),
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

  Widget buildTile(BuildContext context, Event event, int index, TimelineZoom zoom,
      {bool isFirst = false, bool isLast = false}) {
    return InkWell(
      onTap: () => _handleTileClick(context, event, index, zoom),
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

  void _handleTileClick(BuildContext context, Event event, int index, TimelineZoom zoom) {
    final zoomCubit = context.read<ZoomCubit>();
    switch (zoom) {
      case TimelineZoom.year:
        {
          zoomCubit.zoomIn();
          break;
        }
      case TimelineZoom.month:
        {
          zoomCubit.zoomIn();
          break;
        }
      case TimelineZoom.day:
        {
          zoomCubit.zoomIn();
          break;
        }
      case TimelineZoom.shortDescription:
        {
          _navigateToEventScreen(context, event, index);
          break;
        }
      case TimelineZoom.fullDescription:
        {
          _navigateToEventScreen(context, event, index);
          break;
        }
    }
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
    _scrollController.scrollTo(index: indexById, duration: const Duration(seconds: 3), curve: Curves.fastOutSlowIn);
    _navigateToEventScreen(context, eventData, indexById);
  }
}
