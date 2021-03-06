import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelive/bloc/filters_cubit.dart';
import 'package:timelive/bloc/zoom_cubit.dart';
import 'package:timelive/models/timeline_zoom.dart';
import 'package:timelive/themes/color_schemer.dart';
import 'package:timelive/timeline_screen.dart';

import 'bloc/events_cubit.dart';

class TimeliveApp extends StatelessWidget {
  const TimeliveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FiltersCubit(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) {
            final cubit = EventsCubit();
            // cubit.refreshEvents(context.read<FiltersCubit>().activeTags);
            return cubit;
          }),
          BlocProvider(
            create: (_) => ZoomCubit(TimelineZoom.fullDescription),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Timelive',
          // themeMode: ThemeMode.system,
          themeMode: ThemeMode.light,
          theme: ColorSchemer.lightTheme(),
          darkTheme: ColorSchemer.darkTheme(),
          home: TimelineScreen(),
        ),
      ),
    );
  }
}
